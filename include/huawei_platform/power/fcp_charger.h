/*
 * fcp_charger.h
 *
 * fcp charger driver interface
 *
 * Copyright (c) 2020-2020 Huawei Technologies Co., Ltd.
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

#include <linux/power/huawei_battery.h>
#include <huawei_platform/power/huawei_charger_adaptor.h>

#ifndef _FCP_CHARGER_H_
#define _FCP_CHARGER_H_

void reset_fcp_flag(void);
void fcp_charge_check(struct huawei_battery_info *info);
void fcp_set_stage_status(enum fcp_check_stage_type stage_type);
void set_fcp_charging_flag(int val);
void force_stop_fcp_charging(struct huawei_battery_info *info);

#endif /* _FCP_CHARGER_H_ */
