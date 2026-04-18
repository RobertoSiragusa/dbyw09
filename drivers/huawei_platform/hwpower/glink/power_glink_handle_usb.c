// SPDX-License-Identifier: GPL-2.0
/*
 * power_glink_handle_usb.c
 *
 * glink channel for handle usb
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
#include <chipset_common/hwpower/common_module/power_printk.h>
#include <chipset_common/hwpower/common_module/power_event_ne.h>
#include <chipset_common/hwusb/hw_usb.h>
#include <huawei_platform/hwpower/common_module/power_glink.h>

#define HWLOG_TAG power_glink_handle_usb
HWLOG_REGIST();

static void power_glink_handle_usb_connect_message(u32 msg)
{
	u32 data;

	switch (msg) {
	case POWER_GLINK_NOTIFY_VAL_USB_DISCONNECT:
		data = 0;
		power_event_bnc_notify(POWER_BNT_HW_PD, POWER_NE_HW_PD_CHARGER, &data);
		break;
	case POWER_GLINK_NOTIFY_VAL_USB_CONNECT:
		break;
	default:
		break;
	}
}

static void power_glink_handle_usb_typec_message(u32 msg)
{
	u32 cc_orientation;

	switch (msg) {
	case POWER_GLINK_NOTIFY_VAL_ORIENTATION_CC1:
		cc_orientation = 0;
		power_event_bnc_notify(POWER_BNT_HW_PD, POWER_NE_HW_PD_ORIENTATION_CC,
			&cc_orientation);
		break;
	case POWER_GLINK_NOTIFY_VAL_ORIENTATION_CC2:
		cc_orientation = 1;
		power_event_bnc_notify(POWER_BNT_HW_PD, POWER_NE_HW_PD_ORIENTATION_CC,
			&cc_orientation);
		break;
	default:
		break;
	}
}

static void power_glink_handle_usb_pd_message(u32 msg)
{
	u32 data;

	switch (msg) {
	case POWER_GLINK_NOTIFY_VAL_PD_CHARGER:
		data = 1;
		power_event_bnc_notify(POWER_BNT_HW_PD, POWER_NE_HW_PD_CHARGER, &data);
		break;
	default:
		break;
	}
}

void power_glink_handle_usb_notify_message(u32 id, u32 msg)
{
	switch (id) {
	case POWER_GLINK_NOTIFY_ID_USB_CONNECT_EVENT:
		power_glink_handle_usb_connect_message(msg);
		break;
	case POWER_GLINK_NOTIFY_ID_TYPEC_EVENT:
		power_glink_handle_usb_typec_message(msg);
		break;
	case POWER_GLINK_NOTIFY_ID_PD_EVENT:
		power_glink_handle_usb_pd_message(msg);
		break;
	default:
		break;
	}
}
