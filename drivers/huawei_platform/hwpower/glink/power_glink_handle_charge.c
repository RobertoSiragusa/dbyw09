// SPDX-License-Identifier: GPL-2.0
/*
 * power_glink_handle_charge.c
 *
 * glink channel for handle charge
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
#include <chipset_common/hwpower/charger/charger_type.h>
#include <chipset_common/hwpower/common_module/power_printk.h>
#include <chipset_common/hwpower/common_module/power_supply_interface.h>
#include <huawei_platform/hwpower/common_module/power_glink.h>
#include <huawei_platform/power/huawei_charger_adaptor.h>
#include <huawei_platform/power/wireless/wireless_charger.h>

#define HWLOG_TAG power_glink_handle_charge
HWLOG_REGIST();

static void power_glink_handle_charge_type_message(u32 msg)
{
	unsigned int type = CHARGER_REMOVED;

	switch (msg) {
	case POWER_GLINK_NOTIFY_VAL_SDP_CHARGER:
		type = CHARGER_TYPE_USB;
		break;
	case POWER_GLINK_NOTIFY_VAL_CDP_CHARGER:
		type = CHARGER_TYPE_BC_USB;
		break;
	case POWER_GLINK_NOTIFY_VAL_DCP_CHARGER:
		type = CHARGER_TYPE_STANDARD;
		break;
	case POWER_GLINK_NOTIFY_VAL_NONSTANDARD_CHARGER:
		type = CHARGER_TYPE_NON_STANDARD;
		break;
	default:
		break;
	}

	huawei_set_charger_type(type);
}

void power_glink_handle_charge_notify_message(u32 id, u32 msg)
{
	switch (id) {
	case POWER_GLINK_NOTIFY_ID_APSD_EVENT:
		power_glink_handle_charge_type_message(msg);
		break;
	case POWER_GLINK_NOTIFY_ID_WLS2WIRED:
		wlrx_switch_to_wired_handler();
		break;
	default:
		break;
	}
}
