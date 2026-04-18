// SPDX-License-Identifier: GPL-2.0
/*
 * power_glink_debug.c
 *
 * glink debug for power module
 *
 * Copyright (c) 2021-2021 Huawei Technologies Co., Ltd.
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

#include <linux/device.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/kobject.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <chipset_common/hwpower/common_module/power_debug.h>
#include <chipset_common/hwpower/common_module/power_printk.h>
#include <huawei_platform/hwpower/common_module/power_glink.h>

#define HWLOG_TAG power_glink_dbg
HWLOG_REGIST();

struct power_glink_dbg_info {
	u32 prop_id;
};

static struct power_glink_dbg_info *g_power_glink_dbg_info;

static ssize_t power_glink_dbg_setprop_store(void *dev_data, const char *buf,
	size_t size)
{
	struct power_glink_dbg_info *info = dev_data;
	u32 prop_id = 0;
	u32 data_buffer = 0;

	if (!buf || !info)
		return -EINVAL;

	/* 2: two parameters */
	if (sscanf(buf, "%u %u", &prop_id, &data_buffer) != 2) {
		hwlog_err("unable to parse input:%s\n", buf);
		return -EINVAL;
	}

	power_glink_set_property_value(prop_id, &data_buffer, 1);

	hwlog_info("dbg_setprop: prop_id=%u data_buf=%u\n", prop_id, data_buffer);
	return size;
}

static ssize_t power_glink_dbg_getprop_store(void *dev_data, const char *buf,
	size_t size)
{
	struct power_glink_dbg_info *info = dev_data;
	u32 prop_id = 0;

	if (!buf || !info)
		return -EINVAL;

	if (kstrtou32(buf, 0, &prop_id)) {
		hwlog_err("unable to parse input:%s\n", buf);
		return -EINVAL;
	}

	info->prop_id = prop_id;

	hwlog_info("dbg_getprop: prop_id=%u\n", prop_id);
	return size;
}

static ssize_t power_glink_dbg_getprop_show(void *dev_data, char *buf, size_t size)
{
	struct power_glink_dbg_info *info = dev_data;
	u32 prop_id;
	u32 data_buffer = 0;

	if (!info)
		return -EINVAL;

	prop_id = info->prop_id;
	power_glink_get_property_value(prop_id, &data_buffer, 1);
	info->prop_id = POWER_GLINK_PROP_ID_END;

	return scnprintf(buf, PAGE_SIZE, "dbg_getprop: prop_id=%u data_buf=%u\n",
		prop_id, data_buffer);
}

static int __init power_glink_dbg_init(void)
{
	struct power_glink_dbg_info *info = NULL;

	info = kzalloc(sizeof(*info), GFP_KERNEL);
	if (!info)
		return -ENOMEM;

	g_power_glink_dbg_info = info;
	info->prop_id = POWER_GLINK_PROP_ID_END;

	power_dbg_ops_register("glink_setprop", (void *)info,
		NULL, power_glink_dbg_setprop_store);
	power_dbg_ops_register("glink_getprop", (void *)info,
		power_glink_dbg_getprop_show,
		power_glink_dbg_getprop_store);
	return 0;
}

static void __exit power_glink_dbg_exit(void)
{
	if (!g_power_glink_dbg_info)
		return;

	kfree(g_power_glink_dbg_info);
	g_power_glink_dbg_info = NULL;
}

module_init(power_glink_dbg_init);
module_exit(power_glink_dbg_exit);

MODULE_LICENSE("GPL v2");
MODULE_DESCRIPTION("debug for power glink module driver");
MODULE_AUTHOR("Huawei Technologies Co., Ltd.");
