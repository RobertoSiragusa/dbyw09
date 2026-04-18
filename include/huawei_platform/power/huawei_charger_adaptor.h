/*
 * huawei_charger_common.h
 *
 * common interface for huawei charger driver
 *
 * Copyright (c) 2012-2019 Huawei Technologies Co., Ltd.
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

#ifndef _HUAWEI_CHARGER_ADAPTOR_H_
#define _HUAWEI_CHARGER_ADAPTOR_H_

#include <linux/power/huawei_charger.h>
enum {
	EVENT_EOC,
	EVENT_RECHARGE,
};

void charge_send_uevent(int input_events);
void charge_request_charge_monitor(void);
unsigned int converse_usb_type(unsigned int type);
unsigned int huawei_get_charger_type(void);
void huawei_set_charger_type(unsigned int type);

int charge_enable_force_sleep(bool enable);

int get_reset_adapter(void);
u32 get_rt_curr_th(void);
void set_rt_test_result(bool flag);
int charger_dev_get_chg_state(u32 *pg_state);
int charger_dev_get_ibus(u32 *ibus);
signed int battery_get_bat_current(void);
int charger_dev_set_mivr(u32 uv);
int charger_dev_set_vbus_vset(u32 uv);
int charge_enable_eoc(bool eoc_enable);
void reset_cur_delay_eoc_count(void);

void charger_detect_init(void);
void charger_detect_release(void);
unsigned int get_charging_time(void);

#endif /* _HUAWEI_CHARGER_ADAPTOR_H_ */
