/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2016-2019. All rights reserved.
 * Description: mas block unistore
 *
 * This software is licensed under the terms of the GNU General Public
 * License version 2, as published by the Free Software Foundation, and
 * may be copied, distributed, and modified under those terms.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

#define pr_fmt(fmt) "[BLK-IO]" fmt

#include <linux/kernel.h>
#include <linux/blkdev.h>
#include <linux/blk-mq.h>
#include <linux/module.h>
#include <linux/bio.h>
#include <linux/delay.h>
#include <linux/gfp.h>
#ifdef MAS_POWER_KEY
#include <linux/mas/mas_powerkey_event.h>
#endif
#include <trace/events/block.h>
#include <trace/iotrace.h>
#include <linux/types.h>
#include <scsi/scsi_host.h>
#include "blk.h"
#include "dsm_block.h"

#ifdef CONFIG_MAS_UNISTORE_PRESERVE
unsigned char mas_blk_req_get_order_nr_unistore(
	struct request *req, unsigned char new_stream_type, bool extern_protect)
{
	unsigned char order = 0;
	unsigned long flags = 0;
	bool inc = false;
	struct blk_dev_lld *lld = NULL;

	if (!req_cp(req)) {
		lld = mas_blk_get_lld(req->q);
		if (req->mas_req.protocol_nr) {
			pr_err("old protocol_nr exist! %d\n", req->mas_req.protocol_nr);
			return req->mas_req.protocol_nr;
		}

#if defined(CONFIG_MAS_DEBUG_FS) || defined(CONFIG_MAS_BLK_DEBUG)
		if (mas_blk_unistore_debug_en())
			pr_err("new_stream_type = %u, old_stream_type = %u, fsync_ind = %d\n",
				new_stream_type, lld->last_stream_type, req->mas_req.fsync_ind);
#endif
		if (req->mas_req.fsync_ind) {
			inc = true;
			req->mas_req.fsync_ind = false;
			io_trace_unistore_count(UNISTORE_FSYNC_INC_ORDER_CNT, 1);
		} else if (lld->last_stream_type == STREAM_TYPE_INVALID) {
			inc = true;
			io_trace_unistore_count(UNISTORE_STREAM_INC_ORDER_CNT, 1);
		} else if (((new_stream_type) && (!lld->last_stream_type)) ||
				((!new_stream_type) && (lld->last_stream_type))) {
			inc = true;
			io_trace_unistore_count(UNISTORE_RPMB_INC_ORDER_CNT, 1);
		} else if (((new_stream_type == STREAM_TYPE_RPMB) &&
				(lld->last_stream_type != STREAM_TYPE_RPMB)) ||
				((new_stream_type != STREAM_TYPE_RPMB) &&
				(lld->last_stream_type == STREAM_TYPE_RPMB))) {
			inc = true;
		}

		if (!extern_protect)
			spin_lock_irqsave(&lld->write_num_lock, flags);

		if (inc) {
			lld->write_num++;
			lld->write_num &= 0xff;
			if (unlikely(!lld->write_num))
				lld->write_num++;
			order = lld->write_num;
			lld->last_stream_type = new_stream_type;
		} else {
			order = lld->write_num;
		}
		if (!extern_protect)
			spin_unlock_irqrestore(&lld->write_num_lock, flags);
	}
	req->mas_req.protocol_nr = order;

	return order;
}

void mas_blk_partition_remap(struct bio *bio, struct hd_struct *p)
{
	if (!blk_queue_query_unistore_enable(bio->bi_disk->queue))
		return;

#if defined(CONFIG_MAS_DEBUG_FS) || defined(CONFIG_MAS_BLK_DEBUG)
	if (unlikely(p->mas_hd.stream_id_tst_mode == 0x5A)) {
		if ((bio->bi_iter.bi_sector >> SECTOR_BYTE) <
			p->mas_hd.stream_id_0_max_addr)
			bio->mas_bio.stream_type = BLK_STREAM_META;
		else if ((bio->bi_iter.bi_sector >> SECTOR_BYTE) <
			p->mas_hd.stream_id_1_max_addr)
			bio->mas_bio.stream_type = BLK_STREAM_COLD_NODE;
		else if ((bio->bi_iter.bi_sector >> SECTOR_BYTE) <
			p->mas_hd.stream_id_2_max_addr)
			bio->mas_bio.stream_type = BLK_STREAM_COLD_DATA;
		else if ((bio->bi_iter.bi_sector >> SECTOR_BYTE) <
			p->mas_hd.stream_id_3_max_addr)
			bio->mas_bio.stream_type = BLK_STREAM_HOT_NODE;
		else if ((bio->bi_iter.bi_sector >> SECTOR_BYTE) <
			p->mas_hd.stream_id_4_max_addr)
			bio->mas_bio.stream_type = BLK_STREAM_HOT_DATA;
		return;
	}
#endif

	if (unlikely(p->mas_hd.default_stream_id))
		bio->mas_bio.stream_type = p->mas_hd.default_stream_id;
}

static void mas_blk_del_section_list(struct blk_dev_lld *lld,
	sector_t section_start_lba, unsigned char stream_type)
{
	struct unistore_section_info *section_info = NULL;

	if ((!stream_type) || (stream_type > MAX_WRITE_STREAM_TYPE))
		return;

#if defined(CONFIG_MAS_DEBUG_FS) || defined(CONFIG_MAS_BLK_DEBUG)
	if (mas_blk_unistore_debug_en()) {
		if (!lld->mas_sec_size) {
			pr_err("%s - section size error: %u\n", __func__, lld->mas_sec_size);
			return;
		}

		pr_err("%s, section_start_lba = 0x%llx - 0x%llx, stream_type = %d\n",
				__func__, section_start_lba / (lld->mas_sec_size),
					section_start_lba % (lld->mas_sec_size), stream_type);
	}
#endif

	list_for_each_entry(section_info,
		&lld->section_list[stream_type - 1], section_list) {
		if (section_info->section_start_lba == section_start_lba)
			break;
	}
	if (&section_info->section_list != &lld->section_list[stream_type - 1]) {
		list_del_init(&section_info->section_list);
		kfree(section_info);
	}
}

static inline bool mas_blk_judge_consecutive_section(
	sector_t section_1, sector_t section_2)
{
	return ((section_1 == section_2) || (section_1 == section_2 + 1));
}

static inline void mas_blk_update_lba_time(struct blk_dev_lld *lld,
	sector_t update_lba, unsigned char stream_type)
{
	lld->expected_lba[stream_type - 1] = update_lba;
	lld->expected_refresh_time[stream_type - 1] = ktime_get();
}

static inline void mas_blk_update_section(struct blk_dev_lld *lld,
	sector_t expected_section, unsigned char stream_type)
{
	lld->old_section[stream_type - 1] = expected_section;
	mas_blk_del_section_list(lld, (lld->old_section[stream_type - 1] *
			(lld->mas_sec_size)), stream_type);
}

void mas_blk_update_expected_lba(struct request *req, unsigned int nr_bytes)
{
	struct blk_dev_lld *lld = mas_blk_get_lld(req->q);
	sector_t current_lba = blk_rq_pos(req) >> SECTION_SECTOR;
	sector_t update_lba;
	sector_t update_section;
	sector_t expected_section;
	bool consecutive_section = false;
	unsigned char stream_type = req->mas_req.stream_type;
	unsigned long flags = 0;

	if ((req_op(req) != REQ_OP_WRITE) || !(lld->features & BLK_LLD_UFS_UNISTORE_EN))
		return;

	if ((!stream_type) || (stream_type > MAX_WRITE_STREAM_TYPE))
		return;

	if (!lld->mas_sec_size)
		return;

	update_lba = current_lba + ((nr_bytes >> SECTOR_BYTE) >> SECTION_SECTOR);
	if (update_lba % (lld->mas_sec_size) == (lld->mas_sec_size / 3) && req->mas_req.slc_mode)
		update_lba += ((lld->mas_sec_size) - (lld->mas_sec_size / 3)); /* tlc : slc = 3 */
	update_section = update_lba / (lld->mas_sec_size);

	spin_lock_irqsave(&lld->expected_lba_lock[stream_type - 1], flags);
	expected_section = lld->expected_lba[stream_type - 1] / (lld->mas_sec_size);
	consecutive_section = mas_blk_judge_consecutive_section(update_section, expected_section);

	if (!lld->expected_lba[stream_type - 1]) {
		mas_blk_update_lba_time(lld, update_lba, stream_type);
	} else if (consecutive_section && (update_lba > lld->expected_lba[stream_type - 1])) {
		mas_blk_update_lba_time(lld, update_lba, stream_type);
		if (update_section == expected_section + 1)
			mas_blk_update_section(lld, expected_section, stream_type);
	} else if (!consecutive_section) {
		if (lld->old_section[stream_type - 1] &&
			mas_blk_judge_consecutive_section(update_section,
				lld->old_section[stream_type - 1])) {
			goto out;
		} else {
			if ((lld->expected_lba[stream_type - 1] % (lld->mas_sec_size)))
				mas_blk_update_section(lld, expected_section, stream_type);
			mas_blk_update_lba_time(lld, update_lba, stream_type);
		}
	}

out:
	spin_unlock_irqrestore(&lld->expected_lba_lock[stream_type - 1], flags);
	return;
}

bool mas_blk_match_expected_lba(struct request_queue *q, struct bio *bio)
{
	unsigned long flags = 0;
	struct blk_dev_lld *lld = NULL;
	sector_t current_lba;
	unsigned char stream_type;
	struct unistore_section_info *section_info = NULL;
	sector_t section_start_lba = 0;

	if (!q || !bio)
		return false;

	lld = mas_blk_get_lld(q);
	if (!(lld->features & BLK_LLD_UFS_UNISTORE_EN))
		return false;

	current_lba = bio->bi_iter.bi_sector >> SECTION_SECTOR;
	stream_type = bio->mas_bio.stream_type;

	if ((!stream_type) || (stream_type > MAX_WRITE_STREAM_TYPE))
		return false;

	spin_lock_irqsave(&lld->expected_lba_lock[stream_type - 1], flags);
	if (!list_empty_careful(&lld->section_list[stream_type - 1])) {
		section_info = list_first_entry(
				&lld->section_list[stream_type - 1],
				struct unistore_section_info, section_list);
		section_start_lba = section_info->section_start_lba;
	}
	if ((lld->expected_lba[stream_type - 1] == current_lba) ||
					(current_lba == section_start_lba)) {
#if defined(CONFIG_MAS_DEBUG_FS) || defined(CONFIG_MAS_BLK_DEBUG)
		if (mas_blk_unistore_debug_en()) {
			if (!lld->mas_sec_size) {
				spin_unlock_irqrestore(
					&lld->expected_lba_lock[stream_type - 1], flags);
				pr_err("%s - section size error: %u\n",
					__func__, lld->mas_sec_size);
				return false;
			}
			pr_err("%s, expect_lba = 0x%llx - 0x%llx, cur_lba = 0x%llx - 0x%llx\n",
					__func__,
					lld->expected_lba[stream_type - 1] / (lld->mas_sec_size),
					lld->expected_lba[stream_type - 1] % (lld->mas_sec_size),
					current_lba / (lld->mas_sec_size),
					current_lba % (lld->mas_sec_size));
		}
#endif
		spin_unlock_irqrestore(&lld->expected_lba_lock[stream_type - 1], flags);
		return true;
	}
	spin_unlock_irqrestore(&lld->expected_lba_lock[stream_type - 1], flags);
	return false;
}

#if defined(CONFIG_MAS_DEBUG_FS) || defined(CONFIG_MAS_BLK_DEBUG)
ssize_t mas_queue_unistore_en_show(struct request_queue *q, char *page)
{
	unsigned long offset = 0;
	struct blk_dev_lld *lld = mas_blk_get_lld(q);

	offset += snprintf(page, PAGE_SIZE, "unistore_enabled: %d\n",
		(lld->features & BLK_LLD_UFS_UNISTORE_EN) ? 1 : 0);

	return (ssize_t)offset;
}

static int unistore_debug_en;
int mas_blk_unistore_debug_en(void)
{
	return unistore_debug_en;
}

ssize_t mas_queue_unistore_debug_en_show(struct request_queue *q, char *page)
{
	unsigned long offset;
	offset = snprintf(page, PAGE_SIZE, "unistore_debug_en: %d\n", unistore_debug_en);
	return (ssize_t)offset;
}

ssize_t mas_queue_unistore_debug_en_store(
	struct request_queue *q, const char *page, size_t count)
{
	ssize_t ret;
	unsigned long val;

	ret = queue_var_store(&val, page, count);
	if (ret < 0)
		return (ssize_t)count;

	if (val)
		unistore_debug_en = val;
	else
		unistore_debug_en = 0;

	return (ssize_t)count;
}
#endif

static void mas_blk_bad_block_notify_fn(struct Scsi_Host *host,
	struct stor_dev_bad_block_info *bad_block_info)
{
	struct blk_dev_lld *lld = &(host->tag_set.lld_func);

	if (!lld)
		return;

	lld->bad_block_info = *bad_block_info;
	if (!atomic_cmpxchg(&lld->bad_block_atomic, 0, 1))
		schedule_work(&lld->bad_block_work);
}

static void mas_blk_bad_block_notify_handler(struct work_struct *work)
{
	struct blk_dev_lld *lld = container_of(
		work, struct blk_dev_lld, bad_block_work);

	if (!lld || !lld->unistore_ops.dev_bad_block_notfiy_fn)
		return;

	lld->unistore_ops.dev_bad_block_notfiy_fn(lld->bad_block_info,
		lld->unistore_ops.dev_bad_block_notfiy_param_data);

	atomic_set(&lld->bad_block_atomic, 0);
}

static void mas_blk_bad_block_notify_work_init(struct request_queue *q)
{
	struct blk_dev_lld *lld = mas_blk_get_lld(q);

	if (!lld || !lld->unistore_ops.dev_bad_block_notify_register)
		return;

	atomic_set(&lld->bad_block_atomic, 0);
	INIT_WORK(&lld->bad_block_work, mas_blk_bad_block_notify_handler);
	lld->unistore_ops.dev_bad_block_notify_register(q, mas_blk_bad_block_notify_fn);
}

void mas_blk_request_init_from_bio_unistore(
	struct request *req, struct bio *bio)
{
	req->mas_req.stream_type = bio->mas_bio.stream_type;
	req->mas_req.slc_mode = bio->mas_bio.slc_mode;
	req->mas_req.cp_tag = bio->mas_bio.cp_tag;
	req->mas_req.data_ino = bio->mas_bio.data_ino;
	req->mas_req.data_idx = bio->mas_bio.data_idx;
	req->mas_req.fsync_ind = bio->mas_bio.fsync_ind;
	req->mas_req.fg_io = bio->mas_bio.fg_io;
}

void mas_blk_dev_lld_init_unistore(struct blk_dev_lld *blk_lld)
{
	unsigned int i;

	blk_lld->unistore_ops.dev_bad_block_notfiy_fn = NULL;
	blk_lld->unistore_ops.dev_bad_block_notfiy_param_data = NULL;
	blk_lld->last_stream_type = STREAM_TYPE_INVALID;
	blk_lld->fsync_ind = false;
	blk_lld->mas_sec_size = 0;
	spin_lock_init(&blk_lld->fsync_ind_lock);
	for (i = 0; i < MAX_WRITE_STREAM_TYPE; i++) {
		spin_lock_init(&blk_lld->expected_lba_lock[i]);
		blk_lld->expected_lba[i] = 0;
		blk_lld->expected_refresh_time[i] = 0;
		blk_lld->old_section[i] = 0;
		INIT_LIST_HEAD(&blk_lld->section_list[i]);
	}

	blk_lld->features &= ~BLK_LLD_UFS_UNISTORE_EN;
}

void mas_blk_queue_unistore_enable(struct request_queue *q, bool enable)
{
	struct blk_dev_lld *lld = mas_blk_get_lld(q);
	if (enable)
		lld->features |= BLK_LLD_UFS_UNISTORE_EN;
	else
		lld->features &= ~BLK_LLD_UFS_UNISTORE_EN;
}

static void mas_blk_mq_free_map_and_requests(
	struct blk_mq_tag_set *set)
{
	unsigned int i;

	for (i = 0; i < set->nr_hw_queues; i++)
		blk_mq_free_map_and_requests(set, i);
}

int mas_blk_mq_update_unistore_tags(struct blk_mq_tag_set *set)
{
	int ret;

	if (!set)
		return -EINVAL;

	mas_blk_mq_free_map_and_requests(set);

	ret = blk_mq_alloc_rq_maps(set);
	if (ret)
		pr_err("%s alloc rq maps fail %d\n", __func__, ret);

	return ret;
}

unsigned int mas_blk_get_sec_size(struct request_queue *q)
{
	struct blk_dev_lld *lld = mas_blk_get_lld(q);

	return lld->mas_sec_size;
}

static void mas_blk_set_sec_size(struct request_queue *q, unsigned int mas_sec_size)
{
	struct blk_dev_lld *lld = mas_blk_get_lld(q);

	lld->mas_sec_size = mas_sec_size;
}

void mas_blk_set_up_unistore_env(struct request_queue *q,
	unsigned int mas_sec_size, bool enable)
{
	mas_blk_queue_unistore_enable(q, enable);

	if (enable) {
		mas_blk_set_sec_size(q, mas_sec_size);
		mas_blk_bad_block_notify_work_init(q);
	}
}
#endif /* CONFIG_MAS_UNISTORE_PRESERVE */

bool blk_queue_query_unistore_enable(struct request_queue *q)
{
	struct blk_dev_lld *lld = NULL;

	if (!q)
		return false;

	lld = mas_blk_get_lld(q);

	return ((lld->features & BLK_LLD_UFS_UNISTORE_EN) ? true : false);
}
