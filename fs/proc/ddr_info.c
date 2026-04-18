/*
 * ddr_info.c
 *
 * set ddr info API
 *
 * Copyright (c) 2019-2019 Huawei Technologies Co., Ltd.
 *
 * This software is licensed under the terms of the GNU General Public
 * License version 2, as published by the Free Software Foundation, and
 * may be copied, distributed, and modified under those terms.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 */

#include <misc/app_info.h>
#include <misc/ddr_info.h>
#include <linux/export.h>
#include <linux/fs.h>
#include <linux/proc_fs.h>
#include <linux/seq_file.h>
#include <asm-generic/errno-base.h>
#include <linux/soc/qcom/smem.h>
#include <linux/module.h>

void export_ddr_info(unsigned int ddr_vendor_id, unsigned int ddr_size,
	unsigned int ddr_type)
{
	char ddr_info_all[APP_INFO_VALUE_LENTH] = {0};
	char *ddr_info = NULL;
	char *samsung_ddr = "SAMSUNG";
	char *elpida_ddr = "MICRON";
	char *hynix_ddr = "HYNIX";
	char *fc_ddr = "FC";
	char *micron_ddr = "MICRON";
	char ddr_size_info[8] = {0};
	char *ddr_type_info = NULL;

	switch (ddr_vendor_id) {
	case SAMSUNG_ID:
		ddr_info = samsung_ddr;
		break;
	case ELPIDA_ID:
		ddr_info = elpida_ddr;
		break;
	case HYNIX_ID:
		ddr_info = hynix_ddr;
		break;
	case FC_ID:
		ddr_info = fc_ddr;
		break;
	case MICRON_ID:
		ddr_info = micron_ddr;
		break;
	default:
		ddr_info = "UNKNOWN";
		break;
	}
	if (ddr_size >= DDR_SIZE_MIN && ddr_size <= DDR_SIZE_MAX)
		snprintf(ddr_size_info, HW_BUF_LEN_8, "%dGbit", ddr_size);
	else
		snprintf(ddr_size_info, HW_BUF_LEN_8, "UNKNOWN");
	switch (ddr_type) {
	case DDR_TYPE_LPDDR1:
		ddr_type_info = "LPDDR1";
		break;
	case DDR_TYPE_LPDDR2:
		ddr_type_info = "LPDDR2";
		break;
	case DDR_TYPE_LPDDR3:
		ddr_type_info = "LPDDR3";
		break;
	case DDR_TYPE_LPDDR4X:
		ddr_type_info = "LPDDR4X";
		break;
	default:
		ddr_type_info = "UNKNOWN";
		break;
	}
	snprintf(ddr_info_all, APP_INFO_VALUE_LENTH - 1, "%s %s %s",
		ddr_info, ddr_size_info, ddr_type_info);
	if (app_info_set("ddr_vendor", ddr_info_all))
		pr_err("Error setting DDR vendor info\n");
}

void app_info_print_smem(void)
{
	unsigned int ddr_vendor_id;
	/* read share memory and get DDR ID */
	struct smem_exten_huawei_paramater *smem = NULL;
	unsigned int ddr_size;
	unsigned int ddr_type;
	unsigned int ret;
	size_t size = sizeof(*smem);

	ret = qcom_smem_alloc(QCOM_SMEM_HOST_ANY, SMEM_ID_VENDOR1, size);
	if (ret < 0 && ret != -EEXIST) {
		if (app_info_set("ddr_vendor", "UNKNOWN"))
			pr_err("Error setting DDR vendor name to UNKNOWN\n");
		pr_err("%s: qcom_smem_alloc failed, %d\n", __func__, ret);
		return;
	}
	smem = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_ID_VENDOR1, &size);

	if (smem == NULL) {
		/* Set the vendor name in app_info */
		if (app_info_set("ddr_vendor", "UNKNOWN"))
			pr_err("Error setting DDR vendor name to UNKNOWN\n");
		pr_err("%s: SMEM Error, READING DDR VENDOR NAME", __func__);
		return;
	}

	ddr_vendor_id = smem->lpddr_id;
	ddr_vendor_id &= HW_MASK;

	ddr_size = (smem->lpddr_id >> HW_RIGHT_SHIFT_8) & HW_MASK;
	ddr_type = (smem->lpddr_id >> HW_RIGHT_SHIFT_24) & HW_MASK;

	export_ddr_info(ddr_vendor_id, ddr_size, ddr_type);
}

static int ddr_info_show(struct seq_file *m, void *v)
{
	unsigned int ddr_vendor_id;
	/* read share memory and get DDR ID */
	struct smem_exten_huawei_paramater *smem = NULL;
	unsigned int ddr_size;
	unsigned int tmp_reg_value;
	unsigned int ret;
	size_t size = sizeof(*smem);

	ret = qcom_smem_alloc(QCOM_SMEM_HOST_ANY, SMEM_ID_VENDOR1, size);
	if (ret < 0 && ret != -EEXIST) {
		pr_err("%s: qcom_smem_alloc failed, %d\n", __func__, ret);
		return ret;
	}
	smem = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_ID_VENDOR1, &size);

	if (smem == NULL) {
		/* Set the vendor name in app_info */
		pr_err("%s: SMEM Error, READING DDR VENDOR NAME", __func__);
		return -EINVAL;
	}
	ddr_vendor_id = smem->lpddr_id;
	ddr_vendor_id &= HW_MASK;

	ddr_size = ((smem->lpddr_id >> HW_RIGHT_SHIFT_8) & HW_MASK) >> 3;

	tmp_reg_value = (ddr_vendor_id & 0xFF) | (ddr_size << 8);
	seq_printf(m, "ddr_info:\n0x%x\n", tmp_reg_value);
	return 0;
}

static int ddrinfo_open(struct inode *inode, struct file *file)
{
	return single_open(file, ddr_info_show, NULL);
}

static const struct file_operations proc_ddrinfo_operations = {
	.open = ddrinfo_open,
	.read = seq_read,
	.llseek = seq_lseek,
	.release = single_release,
};

static int __init proc_ddr_info_init(void)
{
	proc_create("ddr_info", 0644, NULL, &proc_ddrinfo_operations);
	return 0;
}

module_init(proc_ddr_info_init);
