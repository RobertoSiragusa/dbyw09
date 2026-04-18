/* SPDX-License-Identifier: GPL-2.0 */
/*
 * adapter_protocol_ufcs_auth.h
 *
 * authenticate for ufcs protocol
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

#ifndef _ADAPTER_PROTOCOL_UFCS_AUTH_H_
#define _ADAPTER_PROTOCOL_UFCS_AUTH_H_

#include <linux/errno.h>

#define UFCS_AUTH_DIGEST_LEN         32
#define UFCS_AUTH_HASH_LEN           (UFCS_AUTH_DIGEST_LEN * 2 + 1)
#define UFCS_AUTH_WAIT_TIMEOUT       1000
#define UFCS_AUTH_GENL_OPS_NUM       1

#ifdef CONFIG_ADAPTER_PROTOCOL_UFCS
bool ufcs_auth_get_srv_state(void);
int ufcs_auth_wait_completion(void);
void ufcs_auth_clean_hash_data(void);
u8 *ufcs_auth_get_hash_data_header(void);
unsigned int ufcs_auth_get_hash_data_size(void);
#else
static inline bool ufcs_auth_get_srv_state(void)
{
	return false;
}

static inline void ufcs_auth_clean_hash_data(void)
{
}

static inline u8 *ufcs_auth_get_hash_data_header(void)
{
	return NULL;
}

static inline unsigned int ufcs_auth_get_hash_data_size(void)
{
	return 0;
}

static inline int ufcs_auth_wait_completion(void)
{
	return -EPERM;
}
#endif /* CONFIG_ADAPTER_PROTOCOL_UFCS */

#endif /* _ADAPTER_PROTOCOL_UFCS_AUTH_H_ */
