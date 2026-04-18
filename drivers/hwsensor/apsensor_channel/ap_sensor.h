/*
 * ap_sensor.h
 *
 * code for ap motion channel
 *
 * Copyright (c) 2020- Huawei Technologies Co., Ltd.
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

#ifndef __AP_SENSOR_H
#define __AP_SENSOR_H
#include <huawei_platform/log/hw_log.h>

enum {
	SENSOR_TYPE_MOTION,
	SENSOR_TYPE_FINGER_SENSE,
	SENSOR_TYPE_EXT_STEP_COUNTER,
	SENSOR_TYPE_AR,
	SENSOR_TYPE_SENSOR_MAX,
};

enum {
	FINGER_SENSE_REQ = 0x01,
	STD_SENSOR_DATA_REPORT,
	SENSOR_NAME_CFG_REQ,
	MOTION_CMD_REQ,
	MAX_CMD_ID,
};

enum {
	FINGER_SENSE_DISABLE,
	FINGER_SENSE_ENABLE,
};

#endif
