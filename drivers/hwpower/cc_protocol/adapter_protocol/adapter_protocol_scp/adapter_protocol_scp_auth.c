// SPDX-License-Identifier: GPL-2.0
/*
 * adapter_protocol_scp_auth.c
 *
 * authenticate for scp protocol
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

#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/jiffies.h>
#include <linux/completion.h>
#include <chipset_common/hwpower/common_module/power_genl.h>
#include <chipset_common/hwpower/common_module/power_printk.h>
#include <chipset_common/hwpower/protocol/adapter_protocol_scp_auth.h>

#define HWLOG_TAG scp_protocol
HWLOG_REGIST();

static struct completion g_scp_auth_completion;
static bool g_scp_auth_srv_state;
static int g_scp_auth_result;
static u8 g_scp_auth_hash[SCP_AUTH_HASH_LEN];

bool scp_auth_get_srv_state(void)
{
	return g_scp_auth_srv_state;
}

void scp_auth_clean_hash_data(void)
{
	memset(g_scp_auth_hash, 0x00, SCP_AUTH_HASH_LEN);
}

u8 *scp_auth_get_hash_data_header(void)
{
	return g_scp_auth_hash;
}

unsigned int scp_auth_get_hash_data_size(void)
{
	return SCP_AUTH_HASH_LEN;
}

int scp_auth_wait_completion(void)
{
	g_scp_auth_result = 0;
	reinit_completion(&g_scp_auth_completion);

	/*
	 * if bms_auth service not ready, we assume the serivce is dead,
	 * return hash calculate ok anyway
	 */
	if (g_scp_auth_srv_state == false) {
		hwlog_err("service not ready\n");
		return -EPERM;
	}

	power_genl_easy_send(POWER_GENL_TP_AF,
		POWER_GENL_CMD_SCP_AUTH_HASH, 0,
		g_scp_auth_hash, SCP_AUTH_HASH_LEN);

	/*
	 * if timeout happend, we assume the serivce is dead,
	 * return hash calculate ok anyway
	 */
	if (!wait_for_completion_timeout(&g_scp_auth_completion,
		msecs_to_jiffies(SCP_AUTH_WAIT_TIMEOUT))) {
		hwlog_err("service wait timeout\n");
		return -EPERM;
	}

	/*
	 * if not timeout,
	 * return the antifake result base on the hash calc result
	 */
	if (g_scp_auth_result == 0) {
		hwlog_err("hash calculate fail\n");
		return -EPERM;
	}

	hwlog_info("hash calculate ok\n");
	return 0;
}

static int scp_auth_srv_on_cb(void)
{
	g_scp_auth_srv_state = true;
	hwlog_info("srv_on_cb ok\n");
	return 0;
}

static int scp_auth_cb(unsigned char version, void *data, int len)
{
	if (!data || (len != 1)) {
		hwlog_err("data is null or len invalid\n");
		return -EPERM;
	}

	g_scp_auth_result = *(int *)data;
	complete(&g_scp_auth_completion);

	hwlog_info("version=%u auth_result=%d\n", version, g_scp_auth_result);
	return 0;
}

static const struct power_genl_easy_ops scp_auth_easy_ops[] = {
	{
		.cmd = POWER_GENL_CMD_SCP_AUTH_HASH,
		.doit = scp_auth_cb,
	}
};

static struct power_genl_node scp_auth_genl_node = {
	.target = POWER_GENL_TP_AF,
	.name = "SCP_AUTH",
	.easy_ops = scp_auth_easy_ops,
	.n_easy_ops = SCP_AUTH_GENL_OPS_NUM,
	.srv_on_cb = scp_auth_srv_on_cb,
};

static int __init scp_auth_init(void)
{
	init_completion(&g_scp_auth_completion);
	power_genl_easy_node_register(&scp_auth_genl_node);
	return 0;
}

static void __exit scp_auth_exit(void)
{
}

subsys_initcall(scp_auth_init);
module_exit(scp_auth_exit);

MODULE_LICENSE("GPL v2");
MODULE_DESCRIPTION("auth for scp protocol driver");
MODULE_AUTHOR("Huawei Technologies Co., Ltd.");
