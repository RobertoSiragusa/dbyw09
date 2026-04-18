/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2012-2019. All rights reserved.
 * Team:    Huawei DIVS
 * Date:    2020.07.20
 * Description: xhub logbuff module
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

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/slab.h>
#include <linux/init.h>
#include <linux/semaphore.h>
#include <linux/device.h>
#include <linux/platform_device.h>
#include <linux/sched.h>
#include <asm/uaccess.h>
#include <asm/io.h>
#include <linux/sysfs.h>

static struct semaphore logbuff_sem;

static ssize_t logbuff_flush_show(
	struct device *dev, struct device_attribute *attr, char *buf)
{
	int ret;

	ret = down_interruptible(&logbuff_sem);
	if (ret != 0)
		return sprintf(buf, "1");
	pr_info("get logbuff_sem\n");
	return sprintf(buf, "0\n");
}

static ssize_t logbuff_flush_store(
	struct device *dev,
	struct device_attribute *attr,
	const char *buf,
	size_t count)
{
	up(&logbuff_sem);
	return count;
}

static DEVICE_ATTR(logbuff_flush, S_IWUSR | S_IRUGO, logbuff_flush_show, logbuff_flush_store);

static struct platform_device xhub_logbuff = {
	.name = "huawei_sensorhub_logbuff",
	.id = -1,
};

int logbuff_device_register(void)
{
	int ret;

	ret = platform_device_register(&xhub_logbuff);
	if (ret) {
		pr_err("platform_device_register failed, ret:%d.\n", ret);
		return -1;
	}
	return 0;
}

int creat_logbuff_flush_file(void)
{
	int ret;

	ret = device_create_file(&xhub_logbuff.dev,
		&dev_attr_logbuff_flush);
	if (ret) {
		pr_err("create %s file failed, ret:%d.\n", "dev_attr_logbuff_flush", ret);
		return -1;
	}
	return 0;
}

static inline void logbuff_init_success(void)
{
	sema_init(&logbuff_sem, 0);
	pr_info("logbuff_init_success done\n");
}

static int xhub_logbuff_init(void)
{
	pr_info("xhub_logbuff_init\n");
	if (logbuff_device_register())
		goto REGISTER_ERR;
	if (creat_logbuff_flush_file())
		goto SYSFS_ERR_1;
	logbuff_init_success();
	return 0;
SYSFS_ERR_1:
	platform_device_unregister(&xhub_logbuff);
REGISTER_ERR:
	return -1;
}

static void xhub_logbuff_exit(void)
{
	device_remove_file(&xhub_logbuff.dev, &dev_attr_logbuff_flush);
	platform_device_unregister(&xhub_logbuff);
}

late_initcall_sync(xhub_logbuff_init);
module_exit(xhub_logbuff_exit);

MODULE_LICENSE("GPL");
