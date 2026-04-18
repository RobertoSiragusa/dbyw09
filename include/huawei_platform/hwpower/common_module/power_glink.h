/* SPDX-License-Identifier: GPL-2.0 */
/*
 * power_glink.h
 *
 * glink channel for power module
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

#ifndef _POWER_GLINK_H_
#define _POWER_GLINK_H_

/* define property id for power module */
enum power_glink_property_id {
	POWER_GLINK_PROP_ID_BEGIN = 0,
	POWER_GLINK_PROP_ID_TEST = POWER_GLINK_PROP_ID_BEGIN,
	POWER_GLINK_PROP_ID_SET_INPUT_SUSPEND,
	POWER_GLINK_PROP_ID_SET_CHARGE_ENABLE,
	POWER_GLINK_PROP_ID_SET_WLS_ICL,
	POWER_GLINK_PROP_ID_END,
};

/* define notify id for power module */
enum power_glink_notify_id {
	POWER_GLINK_NOTIFY_ID_BEGIN = 0,
	POWER_GLINK_NOTIFY_ID_USB_CONNECT_EVENT = POWER_GLINK_NOTIFY_ID_BEGIN,
	POWER_GLINK_NOTIFY_ID_DC_CONNECT_EVENT,
	POWER_GLINK_NOTIFY_ID_TYPEC_EVENT,
	POWER_GLINK_NOTIFY_ID_PD_EVENT,
	POWER_GLINK_NOTIFY_ID_APSD_EVENT,
	POWER_GLINK_NOTIFY_ID_WLS2WIRED,
	POWER_GLINK_NOTIFY_ID_END,
};

/* define notify msg for power module */
enum power_glink_notify_value {
	POWER_GLINK_NOTIFY_VAL_USB_DISCONNECT,
	POWER_GLINK_NOTIFY_VAL_USB_CONNECT,
	POWER_GLINK_NOTIFY_VAL_STOP_CHARGING,
	POWER_GLINK_NOTIFY_VAL_START_CHARGING,
};

/* define notify id for usb module */
enum power_glink_usbtypec_notify_value {
	POWER_GLINK_NOTIFY_VAL_ORIENTATION_CC1 = 9,
	POWER_GLINK_NOTIFY_VAL_ORIENTATION_CC2 = 10,
};

enum power_glink_usbpd_notify_value {
	POWER_GLINK_NOTIFY_VAL_PD_CHARGER,
};

enum power_glink_charge_type_notify_value {
	POWER_GLINK_NOTIFY_VAL_SDP_CHARGER,
	POWER_GLINK_NOTIFY_VAL_CDP_CHARGER,
	POWER_GLINK_NOTIFY_VAL_DCP_CHARGER,
	POWER_GLINK_NOTIFY_VAL_NONSTANDARD_CHARGER,
	POWER_GLINK_NOTIFY_VAL_INVALID_CHARGER,
};

#if IS_ENABLED(CONFIG_HUAWEI_POWER_GLINK)
int power_glink_get_property_value(u32 prop_id, u32 *data_buffer, u32 data_size);
int power_glink_set_property_value(u32 prop_id, u32 *data_buffer, u32 data_size);
void power_glink_set_usb_type(int type);
void power_glink_handle_charge_notify_message(u32 id, u32 msg);
void power_glink_handle_usb_notify_message(u32 id, u32 msg);
#else
static inline int power_glink_get_property_value(u32 prop_id, u32 *data_buffer, u32 data_size)
{
	return 0;
}

static inline int power_glink_set_property_value(u32 prop_id, u32 *data_buffer, u32 data_size)
{
	return 0;
}

static inline void power_glink_set_usb_type(int type)
{
}

static inline void power_glink_handle_charge_notify_message(u32 id, u32 msg)
{
}

static inline void power_glink_handle_usb_notify_message(u32 id, u32 msg)
{
}
#endif /* CONFIG_HUAWEI_POWER_GLINK */

#endif /* _POWER_GLINK_H_ */
