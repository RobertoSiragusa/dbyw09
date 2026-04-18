/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.
 * Description: some functions of acc horizontal mode
 * Author: huangxinlong
 * Create: 2021-1-20
 * Notes: horizontal mode
 */
#include <linux/input.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/mutex.h>
#include <linux/of.h>
#include <linux/of_device.h>
#include <linux/platform_device.h>
#include <linux/gpio.h>
#include <linux/init.h>
#include <linux/list.h>
#include <linux/spinlock.h>
#include <linux/device.h>
#include <linux/err.h>
#include <linux/ctype.h>
#include <linux/rwsem.h>
#include <securec.h>
#include "../sensors_class.h"
#include "sensor.h"

struct acc_mode acc_sensor_mode = {
	.horizontal_mode = 0,
};

static ssize_t acc_horizontal_mode_show(struct device *dev,
	struct device_attribute *attr, char *buf)
{
	int val = acc_sensor_mode.horizontal_mode;

	return snprintf_s(buf, PAGE_SIZE, PAGE_SIZE - 1, "%d\n", val);
}

static DEVICE_ATTR(acc_horizontal_mode, 0664, acc_horizontal_mode_show, NULL);

static struct attribute *acc_sensor_attrs[] = {
	&dev_attr_acc_horizontal_mode.attr,
	NULL,
};

static const struct attribute_group acc_sensor_attrs_grp = {
	.attrs = acc_sensor_attrs,
};

static struct platform_device sensor_input_info = {
	.name = "huawei_sensors",
	.id = -1,
};

static void hw_get_acc_para_from_dts(void)
{
	int ret, temp;
	struct device_node *number_node = NULL;
	number_node = of_find_compatible_node(NULL, NULL, "huawei,acc_horizontal");
	if (number_node == NULL) {
		pr_err("Cannot find acc mode acc_horizontal from dts\n");
		return;
	}

	ret = of_property_read_u32(number_node, "horizontal_mode", &temp);
	if (!ret) {
		pr_info("%s, horizontal_mode from dts:%d\n", __func__, temp);
		acc_sensor_mode.horizontal_mode = temp;
	} else {
		pr_err("%s, Cannot find horizontal_mode from dts\n", __func__);
	}
}

static int __init acc_mode_init(void)
{
	int rc;
	pr_info("%s: start\n", __func__);
	hw_get_acc_para_from_dts();
	if (acc_sensor_mode.horizontal_mode == 1) {
                rc = platform_device_register(&sensor_input_info);
		if (rc != 0) {
			pr_err("%s: register failed, ret:%d\n", __func__, rc);
			return rc;
		}

		rc = sysfs_create_group(&sensor_input_info.dev.kobj, &acc_sensor_attrs_grp);
		if (rc != 0) {
			pr_err("%s: add driver failed, rc=%d\n", __func__, rc);
			return rc;
		}
	}

	pr_info("%s: add driver success\n", __func__);
	return 0;
}

static void __exit acc_mode_exit(void)
{
	pr_info("%s: success\n", __func__);
}

module_init(acc_mode_init);
module_exit(acc_mode_exit);

MODULE_LICENSE("GPL v2");
MODULE_DESCRIPTION("acc horizontal mode driver");
MODULE_AUTHOR("Huawei Technologies Co., Ltd.");
