/* SPDX-License-Identifier: GPL-2.0 */
/*
 * charger_common_interface.h
 *
 * common interface for charger module
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

#ifndef _CHARGER_COMMON_INTERFACE_H_
#define _CHARGER_COMMON_INTERFACE_H_

#define HIZ_MODE_ENABLE            1
#define HIZ_MODE_DISABLE           0

#define CHARGE_DONE_NON            0
#define CHARGE_DONE                1

#define ADAPTER_0V                 0
#define ADAPTER_5V                 5
#define ADAPTER_7V                 7
#define ADAPTER_9V                 9
#define ADAPTER_12V                12

#if (defined(CONFIG_HUAWEI_CHARGER_AP) || defined(CONFIG_HUAWEI_CHARGER) || defined(CONFIG_FCP_CHARGER))
int charge_check_charger_plugged(void);
int charge_set_hiz_enable(int enable);
bool charge_get_hiz_state(void);
int charge_get_ibus(void);
int charge_get_vbus(void);
int charge_get_vusb(void);
int charge_get_done_type(void);
#else
static inline int charge_check_charger_plugged(void)
{
	return -EINVAL;
}

static inline int charge_set_hiz_enable(int enable)
{
	return 0;
}

static inline bool charge_get_hiz_state(void)
{
	return false;
}

static inline int charge_get_ibus(void)
{
	return 0;
}

static inline int charge_get_vbus(void)
{
	return 0;
}

static inline int charge_get_vusb(void)
{
	return -EINVAL;
}

static inline int charge_get_done_type(void)
{
	return CHARGE_DONE_NON;
}
#endif /* CONFIG_HUAWEI_CHARGER_AP || CONFIG_HUAWEI_CHARGER || CONFIG_FCP_CHARGER */

#endif /* _CHARGER_COMMON_INTERFACE_H_ */
