/*
 * adapter_protocol_ufcs.h
 *
 * ufcs protocol driver
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

#ifndef _ADAPTER_PROTOCOL_UFCS_H_
#define _ADAPTER_PROTOCOL_UFCS_H_

#include <linux/device.h>
#include <linux/completion.h>
#include <linux/notifier.h>

#define UFCS_BYTE_SHIFT                     8
#define UFCS_BYTE_MASK                      0xff
#define UFCS_MSG_NOT_MATCH                  2
#define UFCS_POWER_READY_RETRY              14
#define UFCS_SEND_MSG_MAX_RETRY             3

enum ufcs_protocol_wait_type {
	UFCS_WAIT_CRC_ERROR = 0x1,
	UFCS_WAIT_SEND_PACKET_COMPLETE = 0x2,
	UFCS_WAIT_DATA_READY = 0x4,
};

enum ufcs_protocol_error_code {
	UFCS_DETECT_OTHER = -1,
	UFCS_DETECT_SUCC = 0,
	UFCS_DETECT_FAIL = 1,
};

/*
 * message header data as below:
 * bit0~2: message type
 * bit3~8: protocol version
 * bit9~12: message number
 * bit13~15: device address
 */
#define UFCS_MSG_PROT_VERSION               0x1
#define UFCS_MSG_MAX_COUNTER                16
#define UFCS_MSG_MAX_RX_BUFFER_SIZE         128

#define UFCS_HDR_MASK_MSG_TYPE              0x7
#define UFCS_HDR_MASK_PROT_VERSION          0x3f
#define UFCS_HDR_MASK_MSG_NUMBER            0xf
#define UFCS_HDR_MASK_DEV_ADDRESS           0x7

#define UFCS_HDR_HEADER_LEN                 4
#define UFCS_HDR_HEADER_H_OFFSET            0
#define UFCS_HDR_HEADER_L_OFFSET            1
#define UFCS_HDR_CMD_OFFSET                 2
#define UFCS_HDR_LENGTH_OFFSET              3

enum ufcs_protocol_header_data_shift {
	UFCS_HDR_SHIFT_MSG_TYPE = 0,
	UFCS_HDR_SHIFT_PROT_VERSION = 3,
	UFCS_HDR_SHIFT_MSG_NUMBER = 9,
	UFCS_HDR_SHIFT_DEV_ADDRESS = 13,
};

enum ufcs_protocol_message_type {
	UFCS_MSG_TYPE_CONTROL,
	UFCS_MSG_TYPE_DATA,
	UFCS_MSG_TYPE_VENDOR_DEFINED,
};

enum ufcs_protocol_device_address {
	UFCS_DEV_ADDRESS_SOURCE = 0x01,
	UFCS_DEV_ADDRESS_SINK,
	UFCS_DEV_ADDRESS_CABLE_ELECTRONIC_LABEL,
};

enum ufcs_protocol_control_message {
	UFCS_CTL_MSG_BEGIN = 0x0,
	UFCS_CTL_MSG_PING = UFCS_CTL_MSG_BEGIN,
	UFCS_CTL_MSG_ACK = 0x1,
	UFCS_CTL_MSG_NCK = 0x2,
	UFCS_CTL_MSG_ACCEPT = 0x3,
	UFCS_CTL_MSG_SOFT_RESET = 0x4,
	UFCS_CTL_MSG_POWER_READY = 0x5,
	UFCS_CTL_MSG_GET_OUTPUT_CAPABILITIES = 0x6,
	UFCS_CTL_MSG_GET_SOURCE_INFO = 0x7,
	UFCS_CTL_MSG_GET_SINK_INFO = 0x8,
	UFCS_CTL_MSG_GET_CABLE_INFO = 0x9,
	UFCS_CTL_MSG_GET_DEVICE_INFO = 0xa,
	UFCS_CTL_MSG_GET_ERROR_INFO = 0xb,
	UFCS_CTL_MSG_DETECT_CABLE_INFO = 0xc,
	UFCS_CTL_MSG_START_CABLE_DETECT = 0xd,
	UFCS_CTL_MSG_END_CABLE_DETECT = 0xe,
	UFCS_CTL_MSG_EXIT_UFCS_MODE = 0xf,
	UFCS_CTL_MSG_END,
};

enum ufcs_protocol_data_message {
	UFCS_DATA_MSG_BEGIN = 0x1,
	UFCS_DATA_MSG_OUTPUT_CAPABILITIES = UFCS_DATA_MSG_BEGIN,
	UFCS_DATA_MSG_REQUEST = 0x2,
	UFCS_DATA_MSG_SOURCE_INFO = 0x3,
	UFCS_DATA_MSG_SINK_INFO = 0x4,
	UFCS_DATA_MSG_CABLE_INFO = 0x5,
	UFCS_DATA_MSG_DEVICE_INFO = 0x6,
	UFCS_DATA_MSG_ERROR_INFO = 0x7,
	UFCS_DATA_MSG_CONFIG_WATCHDOG = 0x8,
	UFCS_DATA_MSG_REFUSE = 0x9,
	UFCS_DATA_MSG_VERIFY_REQUEST = 0xa,
	UFCS_DATA_MSG_VERIFY_RESPONSE = 0xb,
	UFCS_DATA_MSG_TEST_REQUEST = 0xff,
	UFCS_DATA_MSG_END,
};

struct ufcs_protocol_header_data {
	u8 header_h;
	u8 header_l;
	u8 cmd;
	u8 length;
};

/*
 * capabilities data message as below:
 * bit0~7: min output current
 * bit8~23: max output current
 * bit24~39: min output voltage
 * bit40~55: max output voltage
 * bit56: voltage adjust step
 * bit57~59: current adjust step
 * bit60~63: output mode
 */
#define UFCS_CAP_MASK_MIN_CURR              0xff
#define UFCS_CAP_MASK_MAX_CURR              0xffff
#define UFCS_CAP_MASK_MIN_VOLT              0xffff
#define UFCS_CAP_MASK_MAX_VOLT              0xffff
#define UFCS_CAP_MASK_VOLT_STEP             0x1
#define UFCS_CAP_MASK_CURR_STEP             0x7
#define UFCS_CAP_MASK_OUTPUT_MODE           0xf

#define UFCS_CAP_UNIT_CURR                  10 /* ma */
#define UFCS_CAP_UNIT_VOLT                  10 /* mv */

#define UFCS_CAP_MAX_OUTPUT_MODE            15

enum ufcs_protocol_capabilities_data_shift {
	UFCS_CAP_SHIFT_MIN_CURR = 0,
	UFCS_CAP_SHIFT_MAX_CURR = 8,
	UFCS_CAP_SHIFT_MIN_VOLT = 24,
	UFCS_CAP_SHIFT_MAX_VOLT = 40,
	UFCS_CAP_SHIFT_VOLT_STEP = 56,
	UFCS_CAP_SHIFT_CURR_STEP = 57,
	UFCS_CAP_SHIFT_OUTPUT_MODE = 60,
};

struct ufcs_protocol_capabilities_data {
	u16 min_curr;
	u16 max_curr;
	u16 min_volt;
	u16 max_volt;
	u16 volt_step;
	u16 curr_step;
	u16 output_mode;
};

/*
 * request data message as below:
 * bit0~15: request output current
 * bit16~31: request output voltage
 * bit32~59: reserved
 * bit60~63: output mode
 */
#define UFCS_REQ_MASK_OUTPUT_CURR           0xffff
#define UFCS_REQ_MASK_OUTPUT_VOLT           0xffff
#define UFCS_REQ_MASK_OUTPUT_MODE           0xf

#define UFCS_REQ_BASE_OUTPUT_MODE           1
#define UFCS_REQ_MIN_OUTPUT_MODE            1
#define UFCS_REQ_MAX_OUTPUT_MODE            15

#define UFCS_REQ_UNIT_OUTPUT_CURR           10 /* ma */
#define UFCS_REQ_UNIT_OUTPUT_VOLT           10 /* mv */

enum ufcs_protocol_request_data_shift {
	UFCS_REQ_SHIFT_OUTPUT_CURR = 0,
	UFCS_REQ_SHIFT_OUTPUT_VOLT = 16,
	UFCS_REQ_SHIFT_OUTPUT_MODE = 60,
};

struct ufcs_protocol_request_data {
	u16 output_curr;
	u16 output_volt;
	u16 output_mode;
};

/*
 * source information data message as below:
 * bit0~15: current output current
 * bit16~31: current output voltage
 * bit32~39: current usb port temp
 * bit40~47: current device temp
 */
#define UFCS_SOURCE_INFO_MASK_OUTPUT_CURR   0xffff
#define UFCS_SOURCE_INFO_MASK_OUTPUT_VOLT   0xffff
#define UFCS_SOURCE_INFO_MASK_PORT_TEMP     0xff
#define UFCS_SOURCE_INFO_MASK_DEV_TEMP      0xff

#define UFCS_SOURCE_INFO_UNIT_CURR          10 /* ma */
#define UFCS_SOURCE_INFO_UNIT_VOLT          10 /* mv */

#define UFCS_SOURCE_INFO_TEMP_BASE          50 /* centigrade */

enum ufcs_protocol_source_info_data_shift {
	UFCS_SOURCE_INFO_SHIFT_OUTPUT_CURR = 0,
	UFCS_SOURCE_INFO_SHIFT_OUTPUT_VOLT = 16,
	UFCS_SOURCE_INFO_SHIFT_PORT_TEMP = 32,
	UFCS_SOURCE_INFO_SHIFT_DEV_TEMP = 40,
};

struct ufcs_protocol_source_info_data {
	u16 output_curr;
	u16 output_volt;
	int port_temp;
	int dev_temp;
};

/*
 * sink information data message as below:
 * bit0~15: current charging current
 * bit16~31: current battery voltage
 * bit32~39: current usb temp
 * bit40~47: current battery temp
 */
#define UFCS_SINK_INFO_MASK_BAT_CURR        0xffff
#define UFCS_SINK_INFO_MASK_BAT_VOLT        0xffff
#define UFCS_SINK_INFO_MASK_USB_TEMP        0xff
#define UFCS_SINK_INFO_MASK_BAT_TEMP        0xff

#define UFCS_SINK_INFO_UNIT_CURR            10 /* ma */
#define UFCS_SINK_INFO_UNIT_VOLT            10 /* mv */

#define UFCS_SINK_INFO_TEMP_BASE            50 /* centigrade */

enum ufcs_protocol_sink_info_data_shift {
	UFCS_SINK_INFO_SHIFT_BAT_CURR = 0,
	UFCS_SINK_INFO_SHIFT_BAT_VOLT = 16,
	UFCS_SINK_INFO_SHIFT_USB_TEMP = 32,
	UFCS_SINK_INFO_SHIFT_BAT_TEMP = 40,
};

struct ufcs_protocol_sink_info_data {
	u16 bat_curr;
	u16 bat_volt;
	int usb_temp;
	int bat_temp;
};

/*
 * cable information data message as below:
 * bit0~7: max loading current
 * bit8~15: max loading voltage
 * bit16~31: cable resistance
 * bit32~47: cable electronic lable vendor id
 * bit48~63: cable vendor id
 */
#define UFCS_CABLE_INFO_MASK_MAX_CURR       0xff
#define UFCS_CABLE_INFO_MASK_MAX_VOLT       0xff
#define UFCS_CABLE_INFO_MASK_RESISTANCE     0xffff
#define UFCS_CABLE_INFO_MASK_ELABLE_VID     0xffff
#define UFCS_CABLE_INFO_MASK_VID            0xffff

#define UFCS_CABLE_INFO_UNIT_CURR           1000 /* ma */
#define UFCS_CABLE_INFO_UNIT_VOLT           1000 /* mv */
#define UFCS_CABLE_INFO_UNIT_RESISTANCE     1000 /* mo */

enum ufcs_protocol_cable_info_data_shift {
	UFCS_CABLE_INFO_SHIFT_MAX_CURR = 0,
	UFCS_CABLE_INFO_SHIFT_MAX_VOLT = 8,
	UFCS_CABLE_INFO_SHIFT_RESISTANCE = 16,
	UFCS_CABLE_INFO_SHIFT_ELABLE_VID = 32,
	UFCS_CABLE_INFO_SHIFT_VID = 48,
};

struct ufcs_protocol_cable_info_data {
	u16 max_curr;
	u16 max_volt;
	u16 resistance;
	u16 elable_vid;
	u16 vid;
};

/*
 * device information data message as below:
 * bit0~15: software version
 * bit16~31: hardware version
 * bit32~47: protocol chip vendor id
 * bit48~63: manufacture vendor id
 */
#define UFCS_DEV_INFO_MASK_SW_VER           0xffff
#define UFCS_DEV_INFO_MASK_HW_VER           0xffff
#define UFCS_DEV_INFO_MASK_CHIP_VID         0xffff
#define UFCS_DEV_INFO_MASK_MANU_VID         0xffff

enum ufcs_protocol_dev_info_data_shift {
	UFCS_DEV_INFO_SHIFT_SW_VER = 0,
	UFCS_DEV_INFO_SHIFT_HW_VER = 16,
	UFCS_DEV_INFO_SHIFT_CHIP_VID = 32,
	UFCS_DEV_INFO_SHIFT_MANU_VID = 48,
};

struct ufcs_protocol_dev_info_data {
	u16 sw_ver;
	u16 hw_ver;
	u16 chip_vid;
	u16 manu_vid;
};

/*
 * error information data message as below:
 * bit0: output ovp
 * bit1: output uvp
 * bit2: output ocp
 * bit3: output scp
 * bit4: usb otp
 * bit5: device otp
 * bit6: cc ovp
 * bit7: d- ovp
 * bit8: d+ ovp
 * bit9: input ovp
 * bit10: input uvp
 * bit11: over leakage current
 * bit12: input drop
 * bit13: crc error
 * bit14: watchdog overflow
 */
#define UFCS_ERROR_INFO_MASK_OUTPUT_OVP     0x1
#define UFCS_ERROR_INFO_MASK_OUTPUT_UVP     0x1
#define UFCS_ERROR_INFO_MASK_OUTPUT_OCP     0x1
#define UFCS_ERROR_INFO_MASK_OUTPUT_SCP     0x1
#define UFCS_ERROR_INFO_MASK_USB_OTP        0x1
#define UFCS_ERROR_INFO_MASK_DEVICE_OTP     0x1
#define UFCS_ERROR_INFO_MASK_CC_OVP         0x1
#define UFCS_ERROR_INFO_MASK_DMINUS_OVP     0x1
#define UFCS_ERROR_INFO_MASK_DPLUS_OVP      0x1
#define UFCS_ERROR_INFO_MASK_INPUT_OVP      0x1
#define UFCS_ERROR_INFO_MASK_INPUT_UVP      0x1
#define UFCS_ERROR_INFO_MASK_OVER_LEAKAGE   0x1
#define UFCS_ERROR_INFO_MASK_INPUT_DROP     0x1
#define UFCS_ERROR_INFO_MASK_CRC_ERROR      0x1
#define UFCS_ERROR_INFO_MASK_WTG_OVERFLOW   0x1

#define UFCS_ERROR_INFO_NORMAL              0
#define UFCS_ERROR_INFO_ABNORMAL            1

enum ufcs_protocol_error_info_data_shift {
	UFCS_ERROR_INFO_SHIFT_OUTPUT_OVP = 0,
	UFCS_ERROR_INFO_SHIFT_OUTPUT_UVP = 1,
	UFCS_ERROR_INFO_SHIFT_OUTPUT_OCP = 2,
	UFCS_ERROR_INFO_SHIFT_OUTPUT_SCP = 3,
	UFCS_ERROR_INFO_SHIFT_USB_OTP = 4,
	UFCS_ERROR_INFO_SHIFT_DEVICE_OTP = 5,
	UFCS_ERROR_INFO_SHIFT_CC_OVP = 6,
	UFCS_ERROR_INFO_SHIFT_DMINUS_OVP = 7,
	UFCS_ERROR_INFO_SHIFT_DPLUS_OVP = 8,
	UFCS_ERROR_INFO_SHIFT_INPUT_OVP = 9,
	UFCS_ERROR_INFO_SHIFT_INPUT_UVP = 10,
	UFCS_ERROR_INFO_SHIFT_OVER_LEAKAGE = 11,
	UFCS_ERROR_INFO_SHIFT_INPUT_DROP = 12,
	UFCS_ERROR_INFO_SHIFT_CRC_ERROR = 13,
	UFCS_ERROR_INFO_SHIFT_WTG_OVERFLOW = 14,
};

struct ufcs_protocol_error_info_data {
	u8 output_ovp;
	u8 output_uvp;
	u8 output_ocp;
	u8 output_scp;
	u8 usb_otp;
	u8 device_otp;
	u8 cc_ovp;
	u8 dminus_ovp;
	u8 dplus_ovp;
	u8 input_ovp;
	u8 input_uvp;
	u8 over_leakage;
	u8 input_drop;
	u8 crc_error;
	u8 wtg_overflow;
};

/*
 * config watchdog data message as below:
 * bit0~15: watchdog overflow time
 */
#define UFCS_WTG_MASK_TIME                  0xffff

#define UFCS_WTG_UNIT_TIME                  1000 /* ms */

enum ufcs_protocol_wtg_data_shift {
	UFCS_WTG_SHIFT_TIME = 0,
};

struct ufcs_protocol_wtg_data {
	u16 time;
};

/*
 * refuse data message as below:
 * bit0~7: reason
 * bit8~15: command number
 * bit16~18: message type
 * bit24~27: message number
 */
#define UFCS_REFUSE_MASK_REASON             0xff
#define UFCS_REFUSE_MASK_CMD_NUMBER         0xff
#define UFCS_REFUSE_MASK_MSG_TYPE           0x7
#define UFCS_REFUSE_MASK_MSG_NUMBER         0xf

#define UFCS_REFUSE_REASON_NOT_IDENTIFY     0x1
#define UFCS_REFUSE_REASON_NOT_SUPPORT      0x2
#define UFCS_REFUSE_REASON_DEVICE_BUSY      0x3
#define UFCS_REFUSE_REASON_OVER_RANGE       0x4
#define UFCS_REFUSE_REASON_OTHER            0x5

enum ufcs_protocol_refuse_data_shift {
	UFCS_REFUSE_SHIFT_REASON = 0,
	UFCS_REFUSE_SHIFT_CMD_NUMBER = 8,
	UFCS_REFUSE_SHIFT_MSG_TYPE = 16,
	UFCS_REFUSE_SHIFT_MSG_NUMBER = 24,
};

struct ufcs_protocol_refuse_data {
	u8 reason;
	u8 cmd_number;
	u8 msg_type;
	u8 msg_number;
};

/*
 * verify request data message as below:
 * byte0: encrypt index
 * byte0~15: random data
 */
#define UFCS_VERIFY_REQ_RANDOM_SIZE         16

struct ufcs_protocol_verify_request_data {
	u8 encrypt_index;
	u8 random[UFCS_VERIFY_REQ_RANDOM_SIZE];
};

/*
 * verify response data message as below:
 * byte0~31: encrypt data
 * byte0~15: random data
 */
#define UFCS_VERIFY_RSP_ENCRYPT_SIZE        32
#define UFCS_VERIFY_RSP_RANDOM_SIZE         16

struct ufcs_protocol_verify_response_data {
	u8 encrypt[UFCS_VERIFY_RSP_ENCRYPT_SIZE];
	u8 random[UFCS_VERIFY_RSP_RANDOM_SIZE];
};

/*
 * test request data message as below:
 * bit0~7: message number
 * bit8~10: message type
 * bit11~13: device address
 * bit14: voltage accuracy test mode
 */
#define UFCS_TEST_REQ_MASK_MSG_NUMBER       0xff
#define UFCS_TEST_REQ_MASK_MSG_TYPE         0x7
#define UFCS_TEST_REQ_MASK_DEV_ADDRESS      0x7
#define UFCS_TEST_REQ_MASK_VOLT_TEST_MODE   0x1

enum ufcs_protocol_test_request_data_shift {
	UFCS_TEST_REQ_SHIFT_MSG_NUMBER = 0,
	UFCS_TEST_REQ_SHIFT_MSG_TYPE = 8,
	UFCS_TEST_REQ_SHIFT_DEV_ADDRESS = 11,
	UFCS_TEST_REQ_SHIFT_VOLT_TEST_MODE = 14,
};

struct ufcs_protocol_test_request_data {
	u8 msg_number;
	u8 msg_type;
	u8 dev_address;
	u8 volt_test_mode;
};

struct ufcs_protocol_package_data {
	u8 msg_type;
	u8 prot_version;
	u8 msg_number;
	u8 dev_address;
	u8 cmd;
	u8 length;
};

struct ufcs_protocol_device_info {
	int support_mode; /* adapter support mode */
	u8 detect_finish_flag;
	u8 outout_capabilities_rd_flag;
	u8 dev_info_rd_flag;
	u8 msg_number;
	u16 output_volt;
	u16 output_curr;
	u8 output_mode;
	struct ufcs_protocol_capabilities_data cap[UFCS_CAP_MAX_OUTPUT_MODE];
	struct ufcs_protocol_dev_info_data dev_info;
};

struct ufcs_protocol_ops {
	const char *chip_name;
	void *dev_data;
	int (*detect_adapter)(void *dev_data);
	int (*send_msg_header)(void *dev_data, u8 *data, u8 len);
	int (*send_msg_body)(void *dev_data, u8 *data, u8 len);
	int (*end_send_msg)(void *dev_data, u8 flag);
	int (*wait_msg_ready)(void *dev_data, u8 flag);
	int (*receive_msg_header)(void *dev_data, u8 *data, u8 len);
	int (*receive_msg_body)(void *dev_data, u8 *data, u8 len);
	int (*end_receive_msg)(void *dev_data);
	int (*soft_reset_master)(void *dev_data);
};

struct ufcs_protocol_dev {
	struct device *dev;
	struct mutex msg_number_lock;
	int dev_id;
	struct ufcs_protocol_ops *p_ops;
	struct ufcs_protocol_device_info info;
};

#ifdef CONFIG_ADAPTER_PROTOCOL_UFCS
int ufcs_protocol_ops_register(struct ufcs_protocol_ops *ops);
#else
static inline int ufcs_protocol_ops_register(struct ufcs_protocol_ops *ops)
{
	return 0;
}
#endif /* CONFIG_ADAPTER_PROTOCOL_UFCS */

#endif /* _ADAPTER_PROTOCOL_UFCS_H_ */
