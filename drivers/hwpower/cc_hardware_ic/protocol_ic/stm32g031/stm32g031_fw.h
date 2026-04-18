/* SPDX-License-Identifier: GPL-2.0 */
/*
 * stm32g031_fw.h
 *
 * stm32g031 firmware header file
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

#ifndef _STM32G031_FW_H_
#define _STM32G031_FW_H_

/* dev_id reg=0x88 */
#define STM32G031_FW_DEV_ID_REG              0x88
#define STM32G031_FW_DEV_ID                  0x22

/* ver_id reg=0x90 */
#define STM32G031_FW_VER_ID_REG              0x90
#define STM32G031_FW_VER_ID                  0x10

#define STM32G031_FW_PAGE_SIZE               128
#define STM32G031_FW_CMD_SIZE                2
#define STM32G031_FW_ERASE_SIZE              3
#define STM32G031_FW_ADDR_SIZE               5
#define STM32G031_FW_ACK_COUNT               3

/* cmd */
#define STM32G031_FW_MTP_ADDR                0x08000000
#define STM32G031_FW_GET_VER_CMD             0x01FE
#define STM32G031_FW_WRITE_CMD               0x32CD
#define STM32G031_FW_ERASE_CMD               0x45BA
#define STM32G031_FW_GO_CMD                  0x21DE
#define STM32G031_FW_ACK_VAL                 0x79

int stm32g031_fw_get_dev_id(struct stm32g031_device_info *di);
int stm32g031_fw_get_rev_id(struct stm32g031_device_info *di);
int stm32g031_fw_update_empty_mtp(struct stm32g031_device_info *di);
int stm32g031_fw_update_latest_mtp(struct stm32g031_device_info *di);
int stm32g031_fw_update_online_mtp(struct stm32g031_device_info *di,
	u8 *mtp_data, int mtp_size, int rev_id);

#endif /* _STM32G031_FW_H_ */
