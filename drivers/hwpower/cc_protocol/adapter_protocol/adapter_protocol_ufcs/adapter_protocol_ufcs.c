// SPDX-License-Identifier: GPL-2.0
/*
 * adapter_protocol_ufcs.c
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

#include <linux/init.h>
#include <linux/module.h>
#include <linux/device.h>
#include <linux/kernel.h>
#include <linux/kobject.h>
#include <linux/slab.h>
#include <linux/random.h>
#include <linux/delay.h>
#include <linux/byteorder/generic.h>
#include <chipset_common/hwpower/protocol/adapter_protocol.h>
#include <chipset_common/hwpower/protocol/adapter_protocol_ufcs.h>
#include <chipset_common/hwpower/common_module/power_delay.h>
#include <chipset_common/hwpower/common_module/power_printk.h>

#define HWLOG_TAG ufcs_protocol
HWLOG_REGIST();

static struct ufcs_protocol_dev *g_ufcs_protocol_dev;

static const struct adapter_protocol_device_data g_ufcs_protocol_dev_data[] = {
	{ PROTOCOL_DEVICE_ID_STM32G031, "stm32g031" },
};

static const char * const g_ufcs_protocol_ctl_msg_table[] = {
	[UFCS_CTL_MSG_PING] = "ping",
	[UFCS_CTL_MSG_ACK] = "ack",
	[UFCS_CTL_MSG_NCK] = "nck",
	[UFCS_CTL_MSG_ACCEPT] = "accept",
	[UFCS_CTL_MSG_SOFT_RESET] = "soft_reset",
	[UFCS_CTL_MSG_POWER_READY] = "power_ready",
	[UFCS_CTL_MSG_GET_OUTPUT_CAPABILITIES] = "get_output_capabilities",
	[UFCS_CTL_MSG_GET_SOURCE_INFO] = "get_source_info",
	[UFCS_CTL_MSG_GET_SINK_INFO] = "get_sink_info",
	[UFCS_CTL_MSG_GET_CABLE_INFO] = "get_cable_info",
	[UFCS_CTL_MSG_GET_DEVICE_INFO] = "get_device_info",
	[UFCS_CTL_MSG_GET_ERROR_INFO] = "get_error_info",
	[UFCS_CTL_MSG_DETECT_CABLE_INFO] = "detect_cable_info",
	[UFCS_CTL_MSG_START_CABLE_DETECT] = "start_cable_detect",
	[UFCS_CTL_MSG_END_CABLE_DETECT] = "end_cable_detect",
	[UFCS_CTL_MSG_EXIT_UFCS_MODE] = "exit_ufcs_mode",
};

static const char * const g_ufcs_protocol_data_msg_table[] = {
	[UFCS_DATA_MSG_OUTPUT_CAPABILITIES] = "output_capabilities",
	[UFCS_DATA_MSG_REQUEST] = "request",
	[UFCS_DATA_MSG_SOURCE_INFO] = "source_info",
	[UFCS_DATA_MSG_SINK_INFO] = "sink_info",
	[UFCS_DATA_MSG_CABLE_INFO] = "cable_info",
	[UFCS_DATA_MSG_DEVICE_INFO] = "device_info",
	[UFCS_DATA_MSG_ERROR_INFO] = "error_info",
	[UFCS_DATA_MSG_CONFIG_WATCHDOG] = "config_watchdog",
	[UFCS_DATA_MSG_REFUSE] = "refuse",
	[UFCS_DATA_MSG_VERIFY_REQUEST] = "verify_request",
	[UFCS_DATA_MSG_VERIFY_RESPONSE] = "verify_response",
	[UFCS_DATA_MSG_TEST_REQUEST] = "test_request",
};

static int ufcs_protocol_get_device_id(const char *str)
{
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(g_ufcs_protocol_dev_data); i++) {
		if (!strncmp(str, g_ufcs_protocol_dev_data[i].name,
			strlen(str)))
			return g_ufcs_protocol_dev_data[i].id;
	}

	return -EPERM;
}

static const char *ufcs_protocol_get_ctl_msg_name(unsigned int msg)
{
	if ((msg >= UFCS_CTL_MSG_BEGIN) && (msg < UFCS_CTL_MSG_END))
		return g_ufcs_protocol_ctl_msg_table[msg];

	return "illegal ctl_msg";
}

static const char *ufcs_protocol_get_data_msg_name(unsigned int msg)
{
	if ((msg >= UFCS_DATA_MSG_BEGIN) && (msg < UFCS_DATA_MSG_END))
		return g_ufcs_protocol_data_msg_table[msg];

	return "illegal data_msg";
}

static struct ufcs_protocol_dev *ufcs_protocol_get_dev(void)
{
	if (!g_ufcs_protocol_dev) {
		hwlog_err("g_ufcs_protocol_dev is null\n");
		return NULL;
	}

	return g_ufcs_protocol_dev;
}

static struct ufcs_protocol_ops *ufcs_protocol_get_ops(void)
{
	if (!g_ufcs_protocol_dev || !g_ufcs_protocol_dev->p_ops) {
		hwlog_err("g_pd_protocol_dev or p_ops is null\n");
		return NULL;
	}

	return g_ufcs_protocol_dev->p_ops;
}

int ufcs_protocol_ops_register(struct ufcs_protocol_ops *ops)
{
	int dev_id;

	if (!g_ufcs_protocol_dev || !ops || !ops->chip_name) {
		hwlog_err("g_ufcs_protocol_dev or ops or chip_name is null\n");
		return -EPERM;
	}

	dev_id = ufcs_protocol_get_device_id(ops->chip_name);
	if (dev_id < 0) {
		hwlog_err("%s ops register fail\n", ops->chip_name);
		return -EPERM;
	}

	g_ufcs_protocol_dev->p_ops = ops;
	g_ufcs_protocol_dev->dev_id = dev_id;

	hwlog_info("%d:%s ops register ok\n", dev_id, ops->chip_name);
	return 0;
}

static u8 ufcs_protocol_get_msg_number(void)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();
	u8 msg_number;

	if (!l_dev)
		return 0;

	mutex_lock(&l_dev->msg_number_lock);
	msg_number = l_dev->info.msg_number;
	mutex_unlock(&l_dev->msg_number_lock);
	return msg_number;
}

static void ufcs_protocol_set_msg_number(u8 msg_number)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();

	if (!l_dev)
		return;

	mutex_lock(&l_dev->msg_number_lock);
	l_dev->info.msg_number = (msg_number % UFCS_MSG_MAX_COUNTER);
	mutex_unlock(&l_dev->msg_number_lock);
	hwlog_info("old_msg_number=%u new_msg_number=%u\n",
		msg_number, l_dev->info.msg_number);
}

static void ufcs_protocol_packet_tx_header(struct ufcs_protocol_package_data *pkt,
	struct ufcs_protocol_header_data *hdr)
{
	u16 data = 0;

	/* packet tx header data */
	data |= ((pkt->msg_type & UFCS_HDR_MASK_MSG_TYPE) <<
		UFCS_HDR_SHIFT_MSG_TYPE);
	data |= ((pkt->prot_version & UFCS_HDR_MASK_PROT_VERSION) <<
		UFCS_HDR_SHIFT_PROT_VERSION);
	data |= ((pkt->msg_number & UFCS_HDR_MASK_MSG_NUMBER) <<
		UFCS_HDR_SHIFT_MSG_NUMBER);
	data |= ((pkt->dev_address & UFCS_HDR_MASK_DEV_ADDRESS) <<
		UFCS_HDR_SHIFT_DEV_ADDRESS);

	/* fill tx header data */
	hdr->header_h = (data >> UFCS_BYTE_SHIFT) & UFCS_BYTE_MASK;
	hdr->header_l = (data >> 0) & UFCS_BYTE_MASK;
	hdr->cmd = pkt->cmd;
	hdr->length = pkt->length;
}

static void ufcs_protocol_unpack_rx_header(struct ufcs_protocol_package_data *pkt,
	struct ufcs_protocol_header_data *hdr)
{
	u16 data;

	/* unpacket rx header data */
	data = (hdr->header_h << UFCS_BYTE_SHIFT) | hdr->header_l;
	pkt->msg_type = (data >> UFCS_HDR_SHIFT_MSG_TYPE) &
		UFCS_HDR_MASK_MSG_TYPE;
	pkt->prot_version = (data >> UFCS_HDR_SHIFT_PROT_VERSION) &
		UFCS_HDR_MASK_PROT_VERSION;
	pkt->msg_number = (data >> UFCS_HDR_SHIFT_MSG_NUMBER) &
		UFCS_HDR_MASK_MSG_NUMBER;
	pkt->dev_address = (data >> UFCS_HDR_SHIFT_DEV_ADDRESS) &
		UFCS_HDR_MASK_DEV_ADDRESS;
	pkt->cmd = hdr->cmd;
	pkt->length = hdr->length;
}

static int ufcs_protocol_detect_adapter(void)
{
	struct ufcs_protocol_ops *l_ops = ufcs_protocol_get_ops();

	if (!l_ops)
		return -EPERM;

	if (!l_ops->detect_adapter) {
		hwlog_err("detect_adapter is null\n");
		return -EPERM;
	}

	hwlog_info("detect_adapter\n");

	return l_ops->detect_adapter(l_ops->dev_data);
}

static int ufcs_protocol_soft_reset_master(void)
{
	struct ufcs_protocol_ops *l_ops = ufcs_protocol_get_ops();

	if (!l_ops)
		return -EPERM;

	if (!l_ops->soft_reset_master) {
		hwlog_err("soft_reset_master is null\n");
		return -EPERM;
	}

	hwlog_info("soft_reset_master\n");

	return l_ops->soft_reset_master(l_ops->dev_data);
}

static int ufcs_protocol_send_msg_header(struct ufcs_protocol_package_data *pkt,
	struct ufcs_protocol_header_data *hdr)
{
	struct ufcs_protocol_ops *l_ops = ufcs_protocol_get_ops();
	u8 data[UFCS_HDR_HEADER_LEN] = { 0 };

	if (!l_ops)
		return -EPERM;

	if (!l_ops->send_msg_header) {
		hwlog_err("send_msg_header is null\n");
		return -EPERM;
	}

	ufcs_protocol_packet_tx_header(pkt, hdr);
	data[UFCS_HDR_HEADER_H_OFFSET] = hdr->header_h;
	data[UFCS_HDR_HEADER_L_OFFSET] = hdr->header_l;
	data[UFCS_HDR_CMD_OFFSET] = hdr->cmd;
	data[UFCS_HDR_LENGTH_OFFSET] = hdr->length;

	if (pkt->msg_type == UFCS_MSG_TYPE_CONTROL)
		hwlog_info("tx_ctl_msg=%s type=%u ver=%u num=%u addr=%u cmd=%u len=%u\n",
			ufcs_protocol_get_ctl_msg_name(pkt->cmd),
			pkt->msg_type, pkt->prot_version, pkt->msg_number,
			pkt->dev_address, pkt->cmd, pkt->length);
	if (pkt->msg_type == UFCS_MSG_TYPE_DATA)
		hwlog_info("tx_data_cmd=%s type=%u ver=%u num=%u addr=%u cmd=%u len=%u\n",
			ufcs_protocol_get_data_msg_name(pkt->cmd),
			pkt->msg_type, pkt->prot_version, pkt->msg_number,
			pkt->dev_address, pkt->cmd, pkt->length);

	return l_ops->send_msg_header(l_ops->dev_data, data, UFCS_HDR_HEADER_LEN);
}

static int ufcs_protocol_send_msg_body(u8 *data, u8 len)
{
	struct ufcs_protocol_ops *l_ops = ufcs_protocol_get_ops();

	if (!l_ops)
		return -EPERM;

	if (!l_ops->send_msg_body) {
		hwlog_err("send_msg_body is null\n");
		return -EPERM;
	}

	return l_ops->send_msg_body(l_ops->dev_data, data, len);
}

static int ufcs_protocol_end_send_msg(u8 flag)
{
	struct ufcs_protocol_ops *l_ops = ufcs_protocol_get_ops();

	if (!l_ops)
		return -EPERM;

	if (!l_ops->end_send_msg) {
		hwlog_err("end_send_msg is null\n");
		return -EPERM;
	}

	hwlog_info("end_send_msg: flag=%02x\n", flag);

	return l_ops->end_send_msg(l_ops->dev_data, flag);
}

static int ufcs_protocol_wait_msg_ready(u8 flag)
{
	struct ufcs_protocol_ops *l_ops = ufcs_protocol_get_ops();

	if (!l_ops)
		return -EPERM;

	if (!l_ops->wait_msg_ready) {
		hwlog_err("wait_msg_ready is null\n");
		return -EPERM;
	}

	hwlog_info("wait_msg_ready: flag=%02x\n", flag);

	return l_ops->wait_msg_ready(l_ops->dev_data, flag);
}

static int ufcs_protocol_receive_msg_header(struct ufcs_protocol_package_data *pkt,
	struct ufcs_protocol_header_data *hdr)
{
	struct ufcs_protocol_ops *l_ops = ufcs_protocol_get_ops();
	u8 data[UFCS_HDR_HEADER_LEN] = { 0 };
	int ret;

	if (!l_ops)
		return -EPERM;

	if (!l_ops->receive_msg_header) {
		hwlog_err("receive_msg_header is null\n");
		return -EPERM;
	}

	ret = l_ops->receive_msg_header(l_ops->dev_data, data, UFCS_HDR_HEADER_LEN);

	hdr->header_h = data[UFCS_HDR_HEADER_H_OFFSET];
	hdr->header_l = data[UFCS_HDR_HEADER_L_OFFSET];
	hdr->cmd = data[UFCS_HDR_CMD_OFFSET];
	hdr->length = data[UFCS_HDR_LENGTH_OFFSET];
	ufcs_protocol_unpack_rx_header(pkt, hdr);

	if (pkt->msg_type == UFCS_MSG_TYPE_CONTROL)
		hwlog_info("rx_ctl_msg=%s type=%u ver=%u num=%u addr=%u cmd=%u len=%u\n",
			ufcs_protocol_get_ctl_msg_name(pkt->cmd),
			pkt->msg_type, pkt->prot_version, pkt->msg_number,
			pkt->dev_address, pkt->cmd, pkt->length);
	if (pkt->msg_type == UFCS_MSG_TYPE_DATA)
		hwlog_info("rx_data_msg=%s type=%u ver=%u num=%u addr=%u cmd=%u len=%u\n",
			ufcs_protocol_get_data_msg_name(pkt->cmd),
			pkt->msg_type, pkt->prot_version, pkt->msg_number,
			pkt->dev_address, pkt->cmd, pkt->length);

	return ret;
}

static int ufcs_protocol_receive_msg_body(u8 *data, u8 len)
{
	struct ufcs_protocol_ops *l_ops = ufcs_protocol_get_ops();

	if (!l_ops)
		return -EPERM;

	if (!l_ops->receive_msg_body) {
		hwlog_err("receive_msg_body is null\n");
		return -EPERM;
	}

	hwlog_info("receive_msg_body\n");

	return l_ops->receive_msg_body(l_ops->dev_data, data, len);
}

static int ufcs_protocol_end_receive_msg(void)
{
	struct ufcs_protocol_ops *l_ops = ufcs_protocol_get_ops();

	if (!l_ops)
		return -EPERM;

	if (!l_ops->end_receive_msg) {
		hwlog_err("end_receive_msg is null\n");
		return -EPERM;
	}

	hwlog_info("end_receive_msg\n");

	return l_ops->end_receive_msg(l_ops->dev_data);
}

static int ufcs_protocol_send_control_cmd(u8 msg_number, u8 cmd)
{
	struct ufcs_protocol_package_data pkt = { 0 };
	struct ufcs_protocol_header_data hdr = { 0 };
	u8 flag = UFCS_WAIT_SEND_PACKET_COMPLETE;
	int ret;

	pkt.msg_type = UFCS_MSG_TYPE_CONTROL;
	pkt.prot_version = UFCS_MSG_PROT_VERSION;
	pkt.msg_number = msg_number;
	pkt.dev_address = UFCS_DEV_ADDRESS_SOURCE;
	pkt.cmd = cmd;
	pkt.length = 0;

	ret = ufcs_protocol_send_msg_header(&pkt, &hdr);
	ret += ufcs_protocol_end_send_msg(flag);
	if (ret) {
		hwlog_err("send_control_cmd msg_number=%u cmd=%u fail\n",
			msg_number, cmd);
		return -EPERM;
	}

	return 0;
}

static int ufcs_protocol_send_data_cmd(u8 msg_number, u8 cmd,
	u8 *data, u8 len)
{
	struct ufcs_protocol_package_data pkt = { 0 };
	struct ufcs_protocol_header_data hdr = { 0 };
	u8 flag = UFCS_WAIT_SEND_PACKET_COMPLETE;
	int ret;

	pkt.msg_type = UFCS_MSG_TYPE_DATA;
	pkt.prot_version = UFCS_MSG_PROT_VERSION;
	pkt.msg_number = msg_number;
	pkt.dev_address = UFCS_DEV_ADDRESS_SOURCE;
	pkt.cmd = cmd;
	pkt.length = len;

	ret = ufcs_protocol_send_msg_header(&pkt, &hdr);
	ret += ufcs_protocol_send_msg_body(data, len);
	ret += ufcs_protocol_end_send_msg(flag);
	if (ret) {
		hwlog_err("send_data_msg msg_number=%u cmd=%u fail\n",
			msg_number, cmd);
		return -EPERM;
	}

	return 0;
}

static int ufcs_protocol_send_control_msg(u8 cmd, bool ack)
{
	struct ufcs_protocol_package_data pkt = { 0 };
	struct ufcs_protocol_header_data hdr = { 0 };
	u8 msg_number = ufcs_protocol_get_msg_number();
	u8 flag = UFCS_WAIT_CRC_ERROR | UFCS_WAIT_DATA_READY;
	u8 retry = 0;
	int ret;

begin:
	/* send control cmd to tx */
	ret = ufcs_protocol_send_control_cmd(msg_number, cmd);
	if (ret)
		return -EPERM;

	if (!ack)
		goto end;

	/* wait msg from tx */
	ret = ufcs_protocol_wait_msg_ready(flag);
	if (ret)
		return -EPERM;

	/* receive msg header from tx */
	ret = ufcs_protocol_receive_msg_header(&pkt, &hdr);
	if (ret)
		return -EPERM;

	/* end */
	ret = ufcs_protocol_end_receive_msg();
	if (ret)
		return -EPERM;

	/* retry send cmd when receive nck cmd */
	if (pkt.cmd == UFCS_CTL_MSG_NCK) {
		if (retry++ >= UFCS_SEND_MSG_MAX_RETRY)
			return -EPERM;
		hwlog_err("send_control_msg cmd=nck retry=%u\n", retry);
		goto begin;
	}

	/* check ack control msg header */
	if (pkt.msg_type != UFCS_MSG_TYPE_CONTROL) {
		hwlog_err("send_control_msg msg_type=%u,%u invalid\n",
			pkt.msg_type, UFCS_MSG_TYPE_CONTROL);
		return -EPERM;
	}
	if (pkt.msg_number != msg_number) {
		hwlog_err("send_control_msg msg_number=%u,%u invalid\n",
			pkt.msg_number, msg_number);
		return -EPERM;
	}
	if (pkt.cmd != UFCS_CTL_MSG_ACK) {
		hwlog_err("send_control_msg cmd=%u,%u invalid\n",
			pkt.cmd, UFCS_CTL_MSG_ACK);
		return -EPERM;
	}

end:
	ufcs_protocol_set_msg_number(++msg_number);
	return 0;
}

static int ufcs_protocol_send_data_msg(u8 cmd, u8 *data, u8 len, bool ack)
{
	struct ufcs_protocol_package_data pkt = { 0 };
	struct ufcs_protocol_header_data hdr = { 0 };
	u8 msg_number = ufcs_protocol_get_msg_number();
	u8 flag = UFCS_WAIT_CRC_ERROR | UFCS_WAIT_DATA_READY;
	u8 retry = 0;
	int ret;

begin:
	/* send data cmd to tx */
	ret = ufcs_protocol_send_data_cmd(msg_number, cmd, data, len);
	if (ret)
		return -EPERM;

	if (!ack)
		goto end;

	/* wait msg from tx */
	ret = ufcs_protocol_wait_msg_ready(flag);
	if (ret)
		return -EPERM;

	/* receive msg header from tx */
	ret = ufcs_protocol_receive_msg_header(&pkt, &hdr);
	if (ret)
		return -EPERM;

	/* end */
	ret = ufcs_protocol_end_receive_msg();
	if (ret)
		return -EPERM;

	/* retry send cmd when receive nck cmd */
	if (pkt.cmd == UFCS_CTL_MSG_NCK) {
		hwlog_err("send_data_msg cmd=nck retry=%u\n", retry);
		if (retry++ >= UFCS_SEND_MSG_MAX_RETRY)
			return -EPERM;
		goto begin;
	}

	/* check ack control msg header */
	if (pkt.msg_type != UFCS_MSG_TYPE_CONTROL) {
		hwlog_err("send_data_msg msg_type=%u,%u invalid\n",
			pkt.msg_type, UFCS_MSG_TYPE_CONTROL);
		return -EPERM;
	}
	if (pkt.msg_number != msg_number) {
		hwlog_err("send_data_msg msg_number=%u,%u invalid\n",
			pkt.msg_number, msg_number);
		return -EPERM;
	}
	if (pkt.cmd != UFCS_CTL_MSG_ACK) {
		hwlog_err("send_data_msg cmd=%u,%u invalid\n",
			pkt.cmd, UFCS_CTL_MSG_ACK);
		return -EPERM;
	}

end:
	ufcs_protocol_set_msg_number(++msg_number);
	return 0;
}

static int ufcs_protocol_receive_control_msg(u8 cmd)
{
	struct ufcs_protocol_package_data pkt = { 0 };
	struct ufcs_protocol_header_data hdr = { 0 };
	u8 flag = UFCS_WAIT_CRC_ERROR | UFCS_WAIT_DATA_READY;
	int ret;

	/* wait msg from tx */
	ret = ufcs_protocol_wait_msg_ready(flag);
	if (ret)
		return -EPERM;

	/* receive msg header from tx */
	ret = ufcs_protocol_receive_msg_header(&pkt, &hdr);
	if (ret)
		return -EPERM;

	/* end */
	ret = ufcs_protocol_end_receive_msg();
	if (ret)
		return -EPERM;

	/* check control msg header */
	if (pkt.msg_type != UFCS_MSG_TYPE_CONTROL) {
		hwlog_err("receive_control_msg msg_type=%u,%u invalid\n",
			pkt.msg_type, UFCS_MSG_TYPE_CONTROL);
		return -UFCS_MSG_NOT_MATCH;
	}

	/* check control msg header */
	if (pkt.cmd != cmd) {
		hwlog_err("receive_control_msg cmd=%u,%u invalid\n",
			pkt.cmd, cmd);
		return -EPERM;
	}

	return 0;
}

static int ufcs_protocol_receive_data_msg(u8 cmd, u8 *data, u8 len,
	u8 *ret_len)
{
	struct ufcs_protocol_package_data pkt = { 0 };
	struct ufcs_protocol_header_data hdr = { 0 };
	u8 flag = UFCS_WAIT_CRC_ERROR | UFCS_WAIT_DATA_READY;
	int ret;

	/* wait msg from tx */
	ret = ufcs_protocol_wait_msg_ready(flag);
	if (ret)
		return -EPERM;

	/* receive msg header from tx */
	ret = ufcs_protocol_receive_msg_header(&pkt, &hdr);
	if (ret)
		return -EPERM;

	/* check data msg header */
	if (pkt.msg_type != UFCS_MSG_TYPE_DATA) {
		hwlog_err("receive_data_msg msg_type=%u,%u invalid\n",
			pkt.msg_type, UFCS_MSG_TYPE_DATA);
		return -UFCS_MSG_NOT_MATCH;
	}

	/* check data msg header */
	if (pkt.cmd != cmd) {
		hwlog_err("receive_data_msg cmd=%u,%u invalid\n",
			pkt.cmd, cmd);
		return -EPERM;
	}
	if (pkt.length > len) {
		hwlog_err("receive_data_msg length=%u,%u invalid\n",
			pkt.length, len);
		return -EPERM;
	}

	/* receive msg body from tx */
	ret = ufcs_protocol_receive_msg_body(data, pkt.length);
	if (ret)
		return -EPERM;

	*ret_len = pkt.length;

	/* end */
	return ufcs_protocol_end_receive_msg();
}

/* control message from sink to source: 0x00 ping */
static int ufcs_protocol_send_ping_ctrl_msg(void)
{
	return ufcs_protocol_send_control_msg(UFCS_CTL_MSG_PING, true);
}

#ifdef POWER_MODULE_DEBUG_FUNCTION
/* control message from sink to source: 0x01 ack */
static int ufcs_protocol_send_ack_ctrl_msg(void)
{
	return ufcs_protocol_send_control_msg(UFCS_CTL_MSG_ACK, false);
}

/* control message from sink to source: 0x02 nck */
static int ufcs_protocol_send_nck_ctrl_msg(void)
{
	return ufcs_protocol_send_control_msg(UFCS_CTL_MSG_NCK, false);
}

/* control message from sink to source: 0x03 accept */
static int ufcs_protocol_send_accept_ctrl_msg(void)
{
	return ufcs_protocol_send_control_msg(UFCS_CTL_MSG_ACCEPT, true);
}

/* control message from sink to source: 0x04 soft_reset */
static int ufcs_protocol_send_soft_reset_ctrl_msg(void)
{
	return ufcs_protocol_send_control_msg(UFCS_CTL_MSG_SOFT_RESET, true);
}

/* control message from sink to source: 0x05 power_ready */
static int ufcs_protocol_send_power_ready_ctrl_msg(void)
{
	return ufcs_protocol_send_control_msg(UFCS_CTL_MSG_POWER_READY, true);
}
#endif /* POWER_MODULE_DEBUG_FUNCTION */

/* control message from sink to source: 0x06 get_output_capabilities */
static int ufcs_protocol_send_get_output_capabilities_ctrl_msg(void)
{
	return ufcs_protocol_send_control_msg(UFCS_CTL_MSG_GET_OUTPUT_CAPABILITIES, true);
}

/* control message from sink to source: 0x07 get_source_info */
static int ufcs_protocol_send_get_source_info_ctrl_msg(void)
{
	return ufcs_protocol_send_control_msg(UFCS_CTL_MSG_GET_SOURCE_INFO, true);
}

#ifdef POWER_MODULE_DEBUG_FUNCTION
/* control message from sink to source: 0x08 get_sink_info */
static int ufcs_protocol_send_get_sink_info_ctrl_msg(void)
{
	return ufcs_protocol_send_control_msg(UFCS_CTL_MSG_GET_SINK_INFO, true);
}

/* control message from sink to source: 0x09 get_cable_info */
static int ufcs_protocol_send_get_cable_info_ctrl_msg(void)
{
	return ufcs_protocol_send_control_msg(UFCS_CTL_MSG_GET_CABLE_INFO, true);
}
#endif /* POWER_MODULE_DEBUG_FUNCTION */

/* control message from sink to source: 0x0a get_device_info */
static int ufcs_protocol_send_get_dev_info_ctrl_msg(void)
{
	return ufcs_protocol_send_control_msg(UFCS_CTL_MSG_GET_DEVICE_INFO, true);
}

#ifdef POWER_MODULE_DEBUG_FUNCTION
/* control message from sink to source: 0x0b get_error_info */
static int ufcs_protocol_send_get_error_info_ctrl_msg(void)
{
	return ufcs_protocol_send_control_msg(UFCS_CTL_MSG_GET_ERROR_INFO, true);
}

/* control message from sink to source: 0x0c detect_cable_info */
static int ufcs_protocol_send_detect_cable_info_ctrl_msg(void)
{
	return ufcs_protocol_send_control_msg(UFCS_CTL_MSG_DETECT_CABLE_INFO, true);
}

/* control message from sink to source: 0x0d start_cable_detect */
static int ufcs_protocol_send_start_cable_detect_ctrl_msg(void)
{
	return ufcs_protocol_send_control_msg(UFCS_CTL_MSG_START_CABLE_DETECT, true);
}

/* control message from sink to source: 0x0e end_cable_detect */
static int ufcs_protocol_send_end_cable_detect_ctrl_msg(void)
{
	return ufcs_protocol_send_control_msg(UFCS_CTL_MSG_END_CABLE_DETECT, true);
}

/* control message from sink to source: 0x0f exit_ufcs_mode */
static int ufcs_protocol_send_exit_ufcs_mode_ctrl_msg(void)
{
	return ufcs_protocol_send_control_msg(UFCS_CTL_MSG_EXIT_UFCS_MODE, true);
}
#endif /* POWER_MODULE_DEBUG_FUNCTION */

/* control message from source to sink: 0x03 accept */
static int ufcs_protocol_receive_accept_ctrl_msg(void)
{
	return ufcs_protocol_receive_control_msg(UFCS_CTL_MSG_ACCEPT);
}

/* control message from source to sink: 0x05 power_ready */
static int ufcs_protocol_receive_power_ready_ctrl_msg(void)
{
	return ufcs_protocol_receive_control_msg(UFCS_CTL_MSG_POWER_READY);
}

/* data message from sink to source: 0x02 request */
static int ufcs_protocol_send_request_data_msg(
	struct ufcs_protocol_request_data *p)
{
	u64 data = 0;
	u64 tmp_data;
	u8 len = sizeof(u64);

	data |= ((u64)((p->output_curr / UFCS_REQ_UNIT_OUTPUT_CURR) &
		UFCS_REQ_MASK_OUTPUT_CURR) << UFCS_REQ_SHIFT_OUTPUT_CURR);
	data |= ((u64)((p->output_volt / UFCS_REQ_UNIT_OUTPUT_VOLT) &
		UFCS_REQ_MASK_OUTPUT_VOLT) << UFCS_REQ_SHIFT_OUTPUT_VOLT);
	data |= ((u64)(p->output_mode & UFCS_REQ_MASK_OUTPUT_MODE) <<
		UFCS_REQ_SHIFT_OUTPUT_MODE);
	tmp_data = be64_to_cpu(data);

	return ufcs_protocol_send_data_msg(UFCS_DATA_MSG_REQUEST,
		(u8 *)&tmp_data, len, true);
}

#ifdef POWER_MODULE_DEBUG_FUNCTION
/* data message from sink to source: 0x04 sink_information */
static int ufcs_protocol_send_sink_information_data_msg(
	struct ufcs_protocol_sink_info_data *p)
{
	u64 data = 0;
	u64 tmp_data;
	u8 len = sizeof(u64);

	data |= ((u64)((p->bat_curr / UFCS_SINK_INFO_UNIT_CURR) &
		UFCS_SINK_INFO_MASK_BAT_CURR) << UFCS_SINK_INFO_SHIFT_BAT_CURR);
	data |= ((u64)((p->bat_volt / UFCS_SINK_INFO_UNIT_VOLT) &
		UFCS_SINK_INFO_MASK_BAT_VOLT) << UFCS_SINK_INFO_SHIFT_BAT_VOLT);
	data |= ((u64)((p->usb_temp + UFCS_SINK_INFO_TEMP_BASE) &
		UFCS_SINK_INFO_MASK_USB_TEMP) << UFCS_SINK_INFO_SHIFT_USB_TEMP);
	data |= ((u64)((p->bat_temp + UFCS_SINK_INFO_TEMP_BASE) &
		UFCS_SINK_INFO_MASK_BAT_TEMP) << UFCS_SINK_INFO_SHIFT_BAT_TEMP);
	tmp_data = be64_to_cpu(data);

	return ufcs_protocol_send_data_msg(UFCS_DATA_MSG_SINK_INFO,
		(u8 *)&tmp_data, len, true);
}

/* data message from sink to source: 0x05 cable_information */
static int ufcs_protocol_send_cable_information_data_msg(
	struct ufcs_protocol_cable_info_data *p)
{
	u64 data = 0;
	u64 tmp_data;
	u8 len = sizeof(u64);

	data |= ((u64)((p->max_curr / UFCS_CABLE_INFO_UNIT_CURR) &
		UFCS_CABLE_INFO_MASK_MAX_CURR) << UFCS_CABLE_INFO_SHIFT_MAX_CURR);
	data |= ((u64)((p->max_volt / UFCS_CABLE_INFO_UNIT_VOLT) &
		UFCS_CABLE_INFO_MASK_MAX_VOLT) << UFCS_CABLE_INFO_SHIFT_MAX_VOLT);
	data |= ((p->resistance & UFCS_CABLE_INFO_MASK_RESISTANCE) <<
		UFCS_CABLE_INFO_SHIFT_RESISTANCE);
	data |= ((u64)(p->elable_vid & UFCS_CABLE_INFO_MASK_ELABLE_VID) <<
		UFCS_CABLE_INFO_SHIFT_ELABLE_VID);
	data |= ((u64)(p->vid & UFCS_CABLE_INFO_MASK_VID) <<
		UFCS_CABLE_INFO_SHIFT_VID);
	tmp_data = be64_to_cpu(data);

	return ufcs_protocol_send_data_msg(UFCS_DATA_MSG_CABLE_INFO,
		(u8 *)&tmp_data, len, true);
}

/* data message from sink to source: 0x06 device_information */
static int ufcs_protocol_send_device_information_data_msg(
	struct ufcs_protocol_dev_info_data *p)
{
	u64 data = 0;
	u64 tmp_data;
	u8 len = sizeof(u64);

	data |= ((u64)(p->sw_ver & UFCS_DEV_INFO_MASK_SW_VER) <<
		UFCS_DEV_INFO_SHIFT_SW_VER);
	data |= ((u64)(p->hw_ver & UFCS_DEV_INFO_MASK_HW_VER) <<
		UFCS_DEV_INFO_SHIFT_HW_VER);
	data |= ((u64)(p->chip_vid & UFCS_DEV_INFO_MASK_CHIP_VID) <<
		UFCS_DEV_INFO_SHIFT_CHIP_VID);
	data |= ((u64)(p->manu_vid & UFCS_DEV_INFO_MASK_MANU_VID) <<
		UFCS_DEV_INFO_SHIFT_MANU_VID);
	tmp_data = be64_to_cpu(data);

	return ufcs_protocol_send_data_msg(UFCS_DATA_MSG_DEVICE_INFO,
		(u8 *)&tmp_data, len, true);
}

/* data message from sink to source: 0x07 error_information */
static int ufcs_protocol_send_error_information_data_msg(
	struct ufcs_protocol_error_info_data *p)
{
	u32 data = 0;
	u32 tmp_data;
	u8 len = sizeof(u32);

	data |= ((u32)(p->output_ovp & UFCS_ERROR_INFO_MASK_OUTPUT_OVP) <<
		UFCS_ERROR_INFO_SHIFT_OUTPUT_OVP);
	data |= ((u32)(p->output_uvp & UFCS_ERROR_INFO_MASK_OUTPUT_UVP) <<
		UFCS_ERROR_INFO_SHIFT_OUTPUT_UVP);
	data |= ((u32)(p->output_ocp & UFCS_ERROR_INFO_MASK_OUTPUT_OCP) <<
		UFCS_ERROR_INFO_SHIFT_OUTPUT_OCP);
	data |= ((u32)(p->output_scp & UFCS_ERROR_INFO_MASK_OUTPUT_SCP) <<
		UFCS_ERROR_INFO_SHIFT_OUTPUT_SCP);
	data |= ((u32)(p->usb_otp & UFCS_ERROR_INFO_MASK_USB_OTP) <<
		UFCS_ERROR_INFO_SHIFT_USB_OTP);
	data |= ((u32)(p->device_otp & UFCS_ERROR_INFO_MASK_DEVICE_OTP) <<
		UFCS_ERROR_INFO_SHIFT_DEVICE_OTP);
	data |= ((u32)(p->cc_ovp & UFCS_ERROR_INFO_MASK_CC_OVP) <<
		UFCS_ERROR_INFO_SHIFT_CC_OVP);
	data |= ((u32)(p->dminus_ovp & UFCS_ERROR_INFO_MASK_DMINUS_OVP) <<
		UFCS_ERROR_INFO_SHIFT_DMINUS_OVP);
	data |= ((u32)(p->dplus_ovp & UFCS_ERROR_INFO_MASK_DPLUS_OVP) <<
		UFCS_ERROR_INFO_SHIFT_DPLUS_OVP);
	data |= ((u32)(p->input_ovp & UFCS_ERROR_INFO_MASK_INPUT_OVP) <<
		UFCS_ERROR_INFO_SHIFT_INPUT_OVP);
	data |= ((u32)(p->input_uvp & UFCS_ERROR_INFO_MASK_INPUT_UVP) <<
		UFCS_ERROR_INFO_SHIFT_INPUT_UVP);
	data |= ((u32)(p->over_leakage & UFCS_ERROR_INFO_MASK_OVER_LEAKAGE) <<
		UFCS_ERROR_INFO_SHIFT_OVER_LEAKAGE);
	data |= ((u32)(p->input_drop & UFCS_ERROR_INFO_MASK_INPUT_DROP) <<
		UFCS_ERROR_INFO_SHIFT_INPUT_DROP);
	data |= ((u32)(p->crc_error & UFCS_ERROR_INFO_MASK_CRC_ERROR) <<
		UFCS_ERROR_INFO_SHIFT_CRC_ERROR);
	data |= ((u32)(p->wtg_overflow & UFCS_ERROR_INFO_MASK_WTG_OVERFLOW) <<
		UFCS_ERROR_INFO_SHIFT_WTG_OVERFLOW);
	tmp_data = be32_to_cpu(data);

	return ufcs_protocol_send_data_msg(UFCS_DATA_MSG_ERROR_INFO,
		(u8 *)&tmp_data, len, true);
}
#endif /* POWER_MODULE_DEBUG_FUNCTION */

/* data message from sink to source: 0x08 config_watchdog */
static int ufcs_protocol_send_config_watchdog_data_msg(
	struct ufcs_protocol_wtg_data *p)
{
	u16 data = 0;
	u16 tmp_data;
	u8 len = sizeof(u16);

	data |= ((u16)(p->time & UFCS_WTG_MASK_TIME) <<
		UFCS_WTG_SHIFT_TIME);
	tmp_data = be16_to_cpu(data);

	return ufcs_protocol_send_data_msg(UFCS_DATA_MSG_CONFIG_WATCHDOG,
		(u8 *)&tmp_data, len, true);
}

#ifdef POWER_MODULE_DEBUG_FUNCTION
/* data message from sink to source: 0x09 refuse */
static int ufcs_protocol_send_refuse_data_msg(
	struct ufcs_protocol_refuse_data *p)
{
	u32 data = 0;
	u32 tmp_data;
	u8 len = sizeof(u32);

	data |= ((u32)(p->reason & UFCS_REFUSE_MASK_REASON) <<
		UFCS_REFUSE_SHIFT_REASON);
	data |= ((u32)(p->cmd_number & UFCS_REFUSE_MASK_CMD_NUMBER) <<
		UFCS_REFUSE_SHIFT_CMD_NUMBER);
	data |= ((u32)(p->msg_type & UFCS_REFUSE_MASK_MSG_TYPE) <<
		UFCS_REFUSE_SHIFT_MSG_TYPE);
	data |= ((u32)(p->msg_number & UFCS_REFUSE_MASK_MSG_NUMBER) <<
		UFCS_REFUSE_SHIFT_MSG_NUMBER);
	tmp_data = be32_to_cpu(data);

	return ufcs_protocol_send_data_msg(UFCS_DATA_MSG_REFUSE,
		(u8 *)&tmp_data, len, true);
}

/* data message from sink to source: 0x0a verify_request */
static int ufcs_protocol_send_verify_request_data_msg(
	struct ufcs_protocol_verify_request_data *p)
{
	u8 len = sizeof(struct ufcs_protocol_verify_request_data);

	return ufcs_protocol_send_data_msg(UFCS_DATA_MSG_VERIFY_REQUEST,
		(u8 *)p, len, true);
}

/* data message from sink to source: 0x0b verify_response */
static int ufcs_protocol_send_verify_response_data_msg(
	struct ufcs_protocol_verify_response_data *p)
{
	u8 len = sizeof(struct ufcs_protocol_verify_response_data);

	return ufcs_protocol_send_data_msg(UFCS_DATA_MSG_VERIFY_RESPONSE,
		(u8 *)p, len, true);
}

/* data message from sink to source: 0xff test request */
static int ufcs_protocol_send_test_request_data_msg(
	struct ufcs_protocol_test_request_data *p)
{
	u16 data = 0;
	u16 tmp_data;
	u8 len = sizeof(u16);

	data |= ((u16)(p->msg_number & UFCS_TEST_REQ_MASK_MSG_NUMBER) <<
		UFCS_TEST_REQ_SHIFT_MSG_NUMBER);
	data |= ((u16)(p->msg_type & UFCS_TEST_REQ_MASK_MSG_TYPE) <<
		UFCS_TEST_REQ_SHIFT_MSG_TYPE);
	data |= ((u16)(p->dev_address & UFCS_TEST_REQ_MASK_DEV_ADDRESS) <<
		UFCS_TEST_REQ_SHIFT_DEV_ADDRESS);
	data |= ((u16)(p->volt_test_mode & UFCS_TEST_REQ_MASK_VOLT_TEST_MODE) <<
		UFCS_TEST_REQ_SHIFT_VOLT_TEST_MODE);
	tmp_data = be16_to_cpu(data);

	return ufcs_protocol_send_data_msg(UFCS_DATA_MSG_TEST_REQUEST,
		(u8 *)&tmp_data, len, true);
}
#endif /* POWER_MODULE_DEBUG_FUNCTION */

/* data message from source to sink: 0x01 output_capabilities */
static int ufcs_protocol_receive_output_capabilities_data_msg(
	struct ufcs_protocol_capabilities_data *p, u8 *ret_len)
{
	u64 data[UFCS_CAP_MAX_OUTPUT_MODE] = { 0 };
	u64 tmp_data;
	u8 len = UFCS_CAP_MAX_OUTPUT_MODE * sizeof(u64);
	u8 tmp_len = 0;
	int ret;
	u8 i;

	ret = ufcs_protocol_receive_data_msg(UFCS_DATA_MSG_OUTPUT_CAPABILITIES,
		(u8 *)&data, len, &tmp_len);
	if (ret)
		return -EPERM;

	if (tmp_len % sizeof(u64) != 0) {
		hwlog_err("output_capabilities length=%u,%u invalid\n", len, tmp_len);
		return -EPERM;
	}

	*ret_len = tmp_len / sizeof(u64);
	for (i = 0; i < *ret_len; i++) {
		tmp_data = cpu_to_be64(data[i]);
		/* min output current */
		p[i].min_curr = (tmp_data >> UFCS_CAP_SHIFT_MIN_CURR) &
			UFCS_CAP_MASK_MIN_CURR;
		p[i].min_curr *= UFCS_CAP_UNIT_CURR;
		/* max output current */
		p[i].max_curr = (tmp_data >> UFCS_CAP_SHIFT_MAX_CURR) &
			UFCS_CAP_MASK_MAX_CURR;
		p[i].max_curr *= UFCS_CAP_UNIT_CURR;
		/* min output voltage */
		p[i].min_volt = (tmp_data >> UFCS_CAP_SHIFT_MIN_VOLT) &
			UFCS_CAP_MASK_MIN_VOLT;
		p[i].min_volt *= UFCS_CAP_UNIT_VOLT;
		/* max output voltage */
		p[i].max_volt = (tmp_data >> UFCS_CAP_SHIFT_MAX_VOLT) &
			UFCS_CAP_MASK_MAX_VOLT;
		p[i].max_volt *= UFCS_CAP_UNIT_VOLT;
		/* voltage adjust step */
		p[i].volt_step = (tmp_data >> UFCS_CAP_SHIFT_VOLT_STEP) &
			UFCS_CAP_MASK_VOLT_STEP;
		p[i].volt_step++;
		p[i].volt_step *= UFCS_CAP_UNIT_VOLT;
		/* current adjust step */
		p[i].curr_step = (tmp_data >> UFCS_CAP_SHIFT_CURR_STEP) &
			UFCS_CAP_MASK_CURR_STEP;
		p[i].curr_step++;
		p[i].curr_step *= UFCS_CAP_UNIT_CURR;
		/* output mode */
		p[i].output_mode = (tmp_data >> UFCS_CAP_SHIFT_OUTPUT_MODE) &
			UFCS_CAP_MASK_OUTPUT_MODE;
	}

	for (i = 0; i < *ret_len; i++)
		hwlog_info("cap[%u]=%lx %umA %umA %umV %umV %umV %umA %u\n", i, tmp_data,
			p[i].min_curr, p[i].max_curr,
			p[i].min_volt, p[i].max_volt,
			p[i].volt_step, p[i].curr_step,
			p[i].output_mode);
	return 0;
}

/* data message from source to sink: 0x03 source_information */
static int ufcs_protocol_receive_source_info_data_msg(
	struct ufcs_protocol_source_info_data *p)
{
	u64 data = 0;
	u64 tmp_data;
	u8 len = sizeof(u64);
	u8 tmp_len = 0;
	int ret;

	ret = ufcs_protocol_receive_data_msg(UFCS_DATA_MSG_SOURCE_INFO,
		(u8 *)&data, len, &tmp_len);
	if (ret)
		return -EPERM;

	if (len != tmp_len) {
		hwlog_err("source_info length=%u,%u invalid\n", len, tmp_len);
		return -EPERM;
	}

	tmp_data = cpu_to_be64(data);
	/* current output current */
	p->output_curr = (tmp_data >> UFCS_SOURCE_INFO_SHIFT_OUTPUT_CURR) &
		UFCS_SOURCE_INFO_MASK_OUTPUT_CURR;
	p->output_curr *= UFCS_SOURCE_INFO_UNIT_CURR;
	/* current output voltage */
	p->output_volt = (tmp_data >> UFCS_SOURCE_INFO_SHIFT_OUTPUT_VOLT) &
		UFCS_SOURCE_INFO_MASK_OUTPUT_VOLT;
	p->output_volt *= UFCS_SOURCE_INFO_UNIT_VOLT;
	/* current usb port temp */
	p->port_temp = (tmp_data >> UFCS_SOURCE_INFO_SHIFT_PORT_TEMP) &
		UFCS_SOURCE_INFO_MASK_PORT_TEMP;
	p->port_temp -= UFCS_SOURCE_INFO_TEMP_BASE;
	/* current device temp */
	p->dev_temp = (tmp_data >> UFCS_SOURCE_INFO_SHIFT_DEV_TEMP) &
		UFCS_SOURCE_INFO_MASK_DEV_TEMP;
	p->dev_temp -= UFCS_SOURCE_INFO_TEMP_BASE;

	hwlog_info("source_info=%lx %umA %umV %dC %dC\n", tmp_data,
		p->output_curr, p->output_volt, p->port_temp, p->dev_temp);
	return 0;
}

#ifdef POWER_MODULE_DEBUG_FUNCTION
/* data message from source to sink: 0x05 cable_information */
static int ufcs_protocol_receive_cable_info_data_msg(
	struct ufcs_protocol_cable_info_data *p)
{
	u64 data = 0;
	u64 tmp_data;
	u8 len = sizeof(u64);
	u8 tmp_len = 0;
	int ret;

	ret = ufcs_protocol_receive_data_msg(UFCS_DATA_MSG_CABLE_INFO,
		(u8 *)&data, len, &tmp_len);
	if (ret)
		return -EPERM;

	if (len != tmp_len) {
		hwlog_err("cable_info length=%u,%u invalid\n", len, tmp_len);
		return -EPERM;
	}

	tmp_data = cpu_to_be64(data);
	/* max loading current */
	p->max_curr = (tmp_data >> UFCS_CABLE_INFO_SHIFT_MAX_CURR) &
		UFCS_CABLE_INFO_MASK_MAX_CURR;
	p->max_curr *= UFCS_CABLE_INFO_UNIT_CURR;
	/* max loading voltage */
	p->max_volt = (tmp_data >> UFCS_CABLE_INFO_SHIFT_MAX_VOLT) &
		UFCS_CABLE_INFO_MASK_MAX_VOLT;
	p->max_volt *= UFCS_CABLE_INFO_UNIT_VOLT;
	/* cable resistance */
	p->resistance = (tmp_data >> UFCS_CABLE_INFO_SHIFT_RESISTANCE) &
		UFCS_CABLE_INFO_MASK_RESISTANCE;
	p->resistance *= UFCS_CABLE_INFO_UNIT_RESISTANCE;
	/* cable electronic lable vendor id */
	p->elable_vid = (tmp_data >> UFCS_CABLE_INFO_SHIFT_ELABLE_VID) &
		UFCS_CABLE_INFO_MASK_ELABLE_VID;
	/* cable vendor id */
	p->vid = (tmp_data >> UFCS_CABLE_INFO_SHIFT_VID) &
		UFCS_CABLE_INFO_MASK_VID;

	hwlog_info("cable_info=%lx %xmA %xmV %xmO %x\n", tmp_data,
		p->max_curr, p->max_volt, p->resistance, p->elable_vid, p->vid);
	return 0;
}
#endif /* POWER_MODULE_DEBUG_FUNCTION */

/* data message from source to sink: 0x06 device_information */
static int ufcs_protocol_receive_dev_info_data_msg(
	struct ufcs_protocol_dev_info_data *p)
{
	u64 data = 0;
	u64 tmp_data;
	u8 len = sizeof(u64);
	u8 tmp_len = 0;
	int ret;

	ret = ufcs_protocol_receive_data_msg(UFCS_DATA_MSG_DEVICE_INFO,
		(u8 *)&data, len, &tmp_len);
	if (ret)
		return -EPERM;

	if (len != tmp_len) {
		hwlog_err("dev_info length=%u,%u invalid\n", len, tmp_len);
		return -EPERM;
	}

	tmp_data = cpu_to_be64(data);
	/* software version */
	p->sw_ver = (tmp_data >> UFCS_DEV_INFO_SHIFT_SW_VER) &
		UFCS_DEV_INFO_MASK_SW_VER;
	/* hardware version */
	p->hw_ver = (tmp_data >> UFCS_DEV_INFO_SHIFT_HW_VER) &
		UFCS_DEV_INFO_MASK_HW_VER;
	/* protocol chip vendor id */
	p->chip_vid = (tmp_data >> UFCS_DEV_INFO_SHIFT_CHIP_VID) &
		UFCS_DEV_INFO_MASK_CHIP_VID;
	/* manufacture vendor id */
	p->manu_vid = (tmp_data >> UFCS_DEV_INFO_SHIFT_MANU_VID) &
		UFCS_DEV_INFO_MASK_MANU_VID;

	hwlog_info("dev_info=%lx %x %x %x %x\n", tmp_data,
		p->sw_ver, p->hw_ver, p->chip_vid, p->manu_vid);
	return 0;
}

#ifdef POWER_MODULE_DEBUG_FUNCTION
/* data message from source to sink: 0x07 error_information */
static int ufcs_protocol_receive_error_info_data_msg(
	struct ufcs_protocol_error_info_data *p)
{
	u64 data = 0;
	u64 tmp_data;
	u8 len = sizeof(u64);
	u8 tmp_len = 0;
	int ret;

	ret = ufcs_protocol_receive_data_msg(UFCS_DATA_MSG_ERROR_INFO,
		(u8 *)&data, len, &tmp_len);
	if (ret)
		return -EPERM;

	if (len != tmp_len) {
		hwlog_err("error_info length=%u,%u invalid\n", len, tmp_len);
		return -EPERM;
	}

	tmp_data = cpu_to_be64(data);
	/* output ovp */
	p->output_ovp = (tmp_data >> UFCS_ERROR_INFO_SHIFT_OUTPUT_OVP) &
		UFCS_ERROR_INFO_MASK_OUTPUT_OVP;
	/* output uvp */
	p->output_uvp = (tmp_data >> UFCS_ERROR_INFO_SHIFT_OUTPUT_UVP) &
		UFCS_ERROR_INFO_MASK_OUTPUT_UVP;
	/* output ocp */
	p->output_ocp = (tmp_data >> UFCS_ERROR_INFO_SHIFT_OUTPUT_OCP) &
		UFCS_ERROR_INFO_MASK_OUTPUT_OCP;
	/* output scp */
	p->output_scp = (tmp_data >> UFCS_ERROR_INFO_SHIFT_OUTPUT_SCP) &
		UFCS_ERROR_INFO_MASK_OUTPUT_SCP;
	/* usb otp */
	p->usb_otp = (tmp_data >> UFCS_ERROR_INFO_SHIFT_USB_OTP) &
		UFCS_ERROR_INFO_MASK_USB_OTP;
	/* device otp */
	p->device_otp = (tmp_data >> UFCS_ERROR_INFO_SHIFT_DEVICE_OTP) &
		UFCS_ERROR_INFO_MASK_DEVICE_OTP;
	/* cc ovp */
	p->cc_ovp = (tmp_data >> UFCS_ERROR_INFO_SHIFT_CC_OVP) &
		UFCS_ERROR_INFO_MASK_CC_OVP;
	/* d- ovp */
	p->dminus_ovp = (tmp_data >> UFCS_ERROR_INFO_SHIFT_DMINUS_OVP) &
		UFCS_ERROR_INFO_MASK_DMINUS_OVP;
	/* d+ ovp */
	p->dplus_ovp = (tmp_data >> UFCS_ERROR_INFO_SHIFT_DPLUS_OVP) &
		UFCS_ERROR_INFO_MASK_DPLUS_OVP;
	/* input ovp */
	p->input_ovp = (tmp_data >> UFCS_ERROR_INFO_SHIFT_INPUT_OVP) &
		UFCS_ERROR_INFO_MASK_INPUT_OVP;
	/* input uvp */
	p->input_uvp = (tmp_data >> UFCS_ERROR_INFO_SHIFT_INPUT_UVP) &
		UFCS_ERROR_INFO_MASK_INPUT_UVP;
	/* over leakage current */
	p->over_leakage = (tmp_data >> UFCS_ERROR_INFO_SHIFT_OVER_LEAKAGE) &
		UFCS_ERROR_INFO_MASK_OVER_LEAKAGE;
	/* input drop */
	p->input_drop = (tmp_data >> UFCS_ERROR_INFO_SHIFT_INPUT_DROP) &
		UFCS_ERROR_INFO_MASK_INPUT_DROP;
	/* crc error */
	p->crc_error = (tmp_data >> UFCS_ERROR_INFO_SHIFT_CRC_ERROR) &
		UFCS_ERROR_INFO_MASK_CRC_ERROR;
	/* watchdog overflow */
	p->wtg_overflow = (tmp_data >> UFCS_ERROR_INFO_SHIFT_WTG_OVERFLOW) &
		UFCS_ERROR_INFO_MASK_WTG_OVERFLOW;

	hwlog_info("error_info=%lx\n", tmp_data);
	return 0;
}
#endif /* POWER_MODULE_DEBUG_FUNCTION */

/* data message from source to sink: 0x09 refuse */
static int ufcs_protocol_receive_refuse_data_msg(
	struct ufcs_protocol_refuse_data *p)
{
	u32 data = 0;
	u32 tmp_data;
	u8 len = sizeof(u32);
	u8 tmp_len = 0;
	int ret;

	ret = ufcs_protocol_receive_data_msg(UFCS_DATA_MSG_REFUSE,
		(u8 *)&data, len, &tmp_len);
	if (ret)
		return -EPERM;

	if (len != tmp_len) {
		hwlog_err("refuse length=%u,%u invalid\n", len, tmp_len);
		return -EPERM;
	}

	tmp_data = cpu_to_be32(data);
	/* reason */
	p->reason = (tmp_data >> UFCS_REFUSE_SHIFT_REASON) &
		UFCS_REFUSE_MASK_REASON;
	/* command number */
	p->cmd_number = (tmp_data >> UFCS_REFUSE_SHIFT_CMD_NUMBER) &
		UFCS_REFUSE_MASK_CMD_NUMBER;
	/* message type */
	p->msg_type = (tmp_data >> UFCS_REFUSE_SHIFT_MSG_TYPE) &
		UFCS_REFUSE_MASK_MSG_TYPE;
	/* message number */
	p->msg_number = (tmp_data >> UFCS_REFUSE_SHIFT_MSG_NUMBER) &
		UFCS_REFUSE_MASK_MSG_NUMBER;

	hwlog_info("refuse=%lx %x %x %x %x\n", tmp_data,
		p->reason, p->cmd_number, p->msg_type, p->msg_number);
	return 0;
}

#ifdef POWER_MODULE_DEBUG_FUNCTION
/* data message from source to sink: 0x0b verify_response */
static int ufcs_protocol_receive_verify_response_data_msg(
	struct ufcs_protocol_verify_response_data *p)
{
	u8 len = UFCS_VERIFY_RSP_ENCRYPT_SIZE + UFCS_VERIFY_RSP_RANDOM_SIZE;
	u8 tmp_len = 0;
	int ret, i;

	ret = ufcs_protocol_receive_data_msg(UFCS_DATA_MSG_VERIFY_RESPONSE,
		(u8 *)p, len, &tmp_len);
	if (ret)
		return -EPERM;

	if (len != tmp_len) {
		hwlog_err("verify_response length=%u,%u invalid\n", len, tmp_len);
		return -EPERM;
	}

	for (i = 0; i < UFCS_VERIFY_RSP_ENCRYPT_SIZE; i++)
		hwlog_info("encrypt[%u]=%02x\n", i, p->encrypt[i]);
	for (i = 0; i < UFCS_VERIFY_RSP_RANDOM_SIZE; i++)
		hwlog_info("random[%u]=%02x\n", i, p->encrypt[i]);
	return 0;
}
#endif /* POWER_MODULE_DEBUG_FUNCTION */

static int ufcs_protocol_get_output_capabilities(void)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();
	int ret;

	if (!l_dev)
		return -EPERM;

	if (l_dev->info.outout_capabilities_rd_flag == HAS_READ_FLAG)
		return 0;

	ret = ufcs_protocol_send_get_output_capabilities_ctrl_msg();
	if (ret)
		return -EPERM;

	l_dev->info.output_mode = 0;
	ret = ufcs_protocol_receive_output_capabilities_data_msg(
		&l_dev->info.cap[0], &l_dev->info.output_mode);
	if (ret)
		return -EPERM;

	l_dev->info.outout_capabilities_rd_flag = HAS_READ_FLAG;

	/* init output_mode & volt & curr */
	l_dev->info.output_mode = 1;
	l_dev->info.output_volt = l_dev->info.cap[0].max_volt;
	l_dev->info.output_curr = l_dev->info.cap[0].max_curr;

	return 0;
}

static int ufcs_protocol_get_source_info(struct ufcs_protocol_source_info_data *p)
{
	int ret;

	ret = ufcs_protocol_send_get_source_info_ctrl_msg();
	if (ret)
		return -EPERM;

	ret = ufcs_protocol_receive_source_info_data_msg(p);
	if (ret)
		return -EPERM;

	return 0;
}

static int ufcs_protocol_get_dev_info(void)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();
	int ret;

	if (!l_dev)
		return -EPERM;

	if (l_dev->info.dev_info_rd_flag == HAS_READ_FLAG)
		return 0;

	ret = ufcs_protocol_send_get_dev_info_ctrl_msg();
	if (ret)
		return -EPERM;

	ret = ufcs_protocol_receive_dev_info_data_msg(&l_dev->info.dev_info);
	if (ret)
		return -EPERM;

	l_dev->info.dev_info_rd_flag = HAS_READ_FLAG;

	return 0;
}

static int ufcs_protocol_config_watchdog(struct ufcs_protocol_wtg_data *p)
{
	struct ufcs_protocol_refuse_data refuse;
	int ret;

	ret = ufcs_protocol_send_config_watchdog_data_msg(p);
	if (ret)
		return -EPERM;

	ret = ufcs_protocol_receive_accept_ctrl_msg();
	if (!ret)
		return 0;

	if (ret == -UFCS_MSG_NOT_MATCH)
		return ufcs_protocol_receive_refuse_data_msg(&refuse);

	return -EPERM;
}

static int ufcs_protocol_set_default_state(void)
{
	return ufcs_protocol_soft_reset_master();
}

static int ufcs_protocol_set_default_param(void)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();

	if (!l_dev)
		return -EPERM;

	memset(&l_dev->info, 0, sizeof(l_dev->info));
	return 0;
}

static int ufcs_protocol_detect_adapter_support_mode(int *mode)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();
	int ret;

	if (!l_dev || !mode)
		return ADAPTER_DETECT_FAIL;

	/* set all parameter to default state */
	ufcs_protocol_set_default_param();
	l_dev->info.detect_finish_flag = 1; /* has detect adapter */
	l_dev->info.support_mode = ADAPTER_SUPPORT_UNDEFINED;

	/* protocol handshark: detect ufcs adapter */
	ret = ufcs_protocol_detect_adapter();
	if (ret == UFCS_DETECT_FAIL) {
		hwlog_err("ufcs adapter detect fail\n");
		return ADAPTER_DETECT_FAIL;
	}

	ret = ufcs_protocol_send_ping_ctrl_msg();
	if (ret)
		return ADAPTER_DETECT_FAIL;

	hwlog_info("ufcs adapter ping succ\n");
	*mode = ADAPTER_SUPPORT_UFCS;
	l_dev->info.support_mode = ADAPTER_SUPPORT_UFCS;
	return ADAPTER_DETECT_SUCC;
}

static int ufcs_protocol_get_support_mode(int *mode)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();

	if (!l_dev || !mode)
		return -EPERM;

	if (l_dev->info.detect_finish_flag)
		*mode = l_dev->info.support_mode;
	else
		ufcs_protocol_detect_adapter_support_mode(mode);

	hwlog_info("support_mode: %d\n", *mode);
	return 0;
}

static int ufcs_protocol_set_init_data(struct adapter_init_data *data)
{
	struct ufcs_protocol_wtg_data wtg;

	wtg.time = data->watchdog_timer * UFCS_WTG_UNIT_TIME;
	if (ufcs_protocol_config_watchdog(&wtg))
		return -EPERM;

	hwlog_info("set_init_data\n");
	return 0;
}

static int ufcs_protocol_soft_reset_slave(void)
{
	hwlog_info("soft_reset_slave\n");
	return 0;
}

static int ufcs_protocol_get_inside_temp(int *temp)
{
	struct ufcs_protocol_source_info_data data;

	if (!temp)
		return -EPERM;

	if (ufcs_protocol_get_source_info(&data))
		return -EPERM;

	*temp = data.dev_temp;

	hwlog_info("get_inside_temp: %d\n", *temp);
	return 0;
}

static int ufcs_protocol_get_port_temp(int *temp)
{
	struct ufcs_protocol_source_info_data data;

	if (!temp)
		return -EPERM;

	if (ufcs_protocol_get_source_info(&data))
		return -EPERM;

	*temp = data.port_temp;

	hwlog_info("get_port_temp: %d\n", *temp);
	return 0;
}

static int ufcs_protocol_get_chip_vendor_id(int *id)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();

	if (!l_dev || !id)
		return -EPERM;

	if (ufcs_protocol_get_dev_info())
		return -EPERM;

	*id = l_dev->info.dev_info.chip_vid;

	hwlog_info("get_chip_vendor_id: %d\n", *id);
	return 0;
}

static int ufcs_protocol_get_chip_id(int *id)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();

	if (!l_dev || !id)
		return -EPERM;

	if (ufcs_protocol_get_dev_info())
		return -EPERM;

	*id = l_dev->info.dev_info.manu_vid;

	hwlog_info("get_chip_id_f: 0x%x\n", *id);
	return 0;
}

static int ufcs_protocol_get_hw_version_id(int *id)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();

	if (!l_dev || !id)
		return -EPERM;

	if (ufcs_protocol_get_dev_info())
		return -EPERM;

	*id = l_dev->info.dev_info.hw_ver;

	hwlog_info("get_hw_version_id_f: 0x%x\n", *id);
	return 0;
}

static int ufcs_protocol_get_sw_version_id(int *id)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();

	if (!l_dev || !id)
		return -EPERM;

	if (ufcs_protocol_get_dev_info())
		return -EPERM;

	*id = l_dev->info.dev_info.sw_ver;

	hwlog_info("get_sw_version_id_f: 0x%x\n", *id);
	return 0;
}


static int ufcs_protocol_check_output_mode(u8 mode)
{
	if ((mode < UFCS_REQ_MIN_OUTPUT_MODE) ||
		(mode > UFCS_REQ_MAX_OUTPUT_MODE)) {
		hwlog_err("output_mode=%u invalid\n", mode);
		return -EPERM;
	}

	return 0;
}

static int ufcs_protocol_set_output_voltage(int volt)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();
	struct ufcs_protocol_request_data req;
	struct ufcs_protocol_refuse_data refuse;
	u8 cap_index;
	int ret, i;

	if (!l_dev)
		return -EPERM;

	ret = ufcs_protocol_check_output_mode(l_dev->info.output_mode);
	if (ret)
		return -EPERM;

	/* save current output voltage */
	l_dev->info.output_volt = volt;

	cap_index = l_dev->info.output_mode - UFCS_REQ_BASE_OUTPUT_MODE;
	req.output_mode = l_dev->info.output_mode;
	req.output_curr = l_dev->info.output_curr;
	req.output_volt = volt;
	ret = ufcs_protocol_send_request_data_msg(&req);
	if (ret)
		return -EPERM;

	ret = ufcs_protocol_receive_accept_ctrl_msg();
	if (!ret) {
		for (i = 0; i < UFCS_POWER_READY_RETRY; i++) {
			ret = ufcs_protocol_receive_power_ready_ctrl_msg();
			if (!ret) {
				hwlog_info("set_output_voltage: %d\n", volt);
				break;
			}
		}
		return ret;
	}

	if (ret == -UFCS_MSG_NOT_MATCH)
		return ufcs_protocol_receive_refuse_data_msg(&refuse);

	return -EPERM;
}

static int ufcs_protocol_set_output_current(int cur)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();
	struct ufcs_protocol_request_data req;
	struct ufcs_protocol_refuse_data refuse;
	u8 cap_index;
	int ret, i;

	if (!l_dev)
		return -EPERM;

	ret = ufcs_protocol_check_output_mode(l_dev->info.output_mode);
	if (ret)
		return -EPERM;

	/* save current output current */
	l_dev->info.output_curr = cur;

	cap_index = l_dev->info.output_mode - UFCS_REQ_BASE_OUTPUT_MODE;
	req.output_mode = l_dev->info.output_mode;
	req.output_curr = cur;
	req.output_volt = l_dev->info.output_volt;
	ret = ufcs_protocol_send_request_data_msg(&req);
	if (ret)
		return -EPERM;

	ret = ufcs_protocol_receive_accept_ctrl_msg();
	if (!ret) {
		for (i = 0; i < UFCS_POWER_READY_RETRY; i++) {
			ret = ufcs_protocol_receive_power_ready_ctrl_msg();
			if (!ret) {
				hwlog_info("set_output_current: %d\n", cur);
				break;
			}
		}
		return ret;
	}

	if (ret == -UFCS_MSG_NOT_MATCH)
		return ufcs_protocol_receive_refuse_data_msg(&refuse);

	return -EPERM;
}

static int ufcs_protocol_get_output_voltage(int *volt)
{
	struct ufcs_protocol_source_info_data data;

	if (!volt)
		return -EPERM;

	if (ufcs_protocol_get_source_info(&data))
		return -EPERM;

	*volt = data.output_volt;

	hwlog_info("get_output_voltage: %d\n", *volt);
	return 0;
}

static int ufcs_protocol_get_output_current(int *cur)
{
	struct ufcs_protocol_source_info_data data;

	if (!cur)
		return -EPERM;

	if (ufcs_protocol_get_source_info(&data))
		return -EPERM;

	*cur = data.output_curr;

	hwlog_info("get_output_current: %d\n", *cur);
	return 0;
}

static int ufcs_protocol_get_output_current_set(int *cur)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();

	if (!l_dev || !cur)
		return -EPERM;

	*cur = l_dev->info.output_curr;

	hwlog_info("get_output_current_set: %d\n", *cur);
	return 0;
}

static int ufcs_protocol_get_min_voltage(int *volt)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();
	u8 cap_index;

	if (!l_dev || !volt)
		return -EPERM;

	if (ufcs_protocol_get_output_capabilities())
		return -EPERM;

	if (ufcs_protocol_check_output_mode(l_dev->info.output_mode))
		return -EPERM;

	cap_index = l_dev->info.output_mode - UFCS_REQ_BASE_OUTPUT_MODE;
	*volt = l_dev->info.cap[cap_index].min_volt;

	hwlog_info("get_min_voltage: %u,%d\n", cap_index, *volt);
	return 0;
}

static int ufcs_protocol_get_max_voltage(int *volt)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();
	u8 cap_index;

	if (!l_dev || !volt)
		return -EPERM;

	if (ufcs_protocol_get_output_capabilities())
		return -EPERM;

	if (ufcs_protocol_check_output_mode(l_dev->info.output_mode))
		return -EPERM;

	cap_index = l_dev->info.output_mode - UFCS_REQ_BASE_OUTPUT_MODE;
	*volt = l_dev->info.cap[cap_index].max_volt;

	hwlog_info("get_max_voltage: %u,%d\n", cap_index, *volt);
	return 0;
}

static int ufcs_protocol_get_min_current(int *cur)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();
	u8 cap_index;

	if (!l_dev || !cur)
		return -EPERM;

	if (ufcs_protocol_get_output_capabilities())
		return -EPERM;

	if (ufcs_protocol_check_output_mode(l_dev->info.output_mode))
		return -EPERM;

	cap_index = l_dev->info.output_mode - UFCS_REQ_BASE_OUTPUT_MODE;
	*cur = l_dev->info.cap[cap_index].min_curr;

	hwlog_info("get_min_current: %u,%d\n", cap_index, *cur);
	return 0;
}

static int ufcs_protocol_get_max_current(int *cur)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();
	u8 cap_index;

	if (!l_dev || !cur)
		return -EPERM;

	if (ufcs_protocol_get_output_capabilities())
		return -EPERM;

	if (ufcs_protocol_check_output_mode(l_dev->info.output_mode))
		return -EPERM;

	cap_index = l_dev->info.output_mode - UFCS_REQ_BASE_OUTPUT_MODE;
	*cur = l_dev->info.cap[cap_index].max_curr;

	hwlog_info("get_max_current: %u,%d\n", cap_index, *cur);
	return 0;
}

static int ufcs_protocol_get_power_drop_current(int *cur)
{
	return 0;
}

static int ufcs_protocol_get_device_info(struct adapter_device_info *info)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();

	if (!l_dev || !info)
		return -EPERM;

	if (ufcs_protocol_get_chip_id(&info->chip_id))
		return -EPERM;

	if (ufcs_protocol_get_hw_version_id(&info->hwver))
		return -EPERM;

	if (ufcs_protocol_get_sw_version_id(&info->fwver))
		return -EPERM;

	if (ufcs_protocol_get_min_voltage(&info->min_volt))
		return -EPERM;

	if (ufcs_protocol_get_max_voltage(&info->max_volt))
		return -EPERM;

	if (ufcs_protocol_get_min_current(&info->min_cur))
		return -EPERM;

	if (ufcs_protocol_get_max_current(&info->max_cur))
		return -EPERM;

	info->volt_step = l_dev->info.cap[0].volt_step;
	info->curr_step = l_dev->info.cap[0].curr_step;
	info->output_mode = l_dev->info.cap[0].output_mode;

	hwlog_info("get_device_info\n");
	return 0;
}

static int ufcs_protocol_get_protocol_register_state(void)
{
	struct ufcs_protocol_dev *l_dev = ufcs_protocol_get_dev();

	if (!l_dev)
		return -EPERM;

	if ((l_dev->dev_id >= PROTOCOL_DEVICE_ID_BEGIN) &&
		(l_dev->dev_id < PROTOCOL_DEVICE_ID_END))
		return 0;

	hwlog_info("get_protocol_register_state fail\n");
	return -EPERM;
}

static struct adapter_protocol_ops adapter_protocol_ufcs_ops = {
	.type_name = "hw_ufcs",
	.detect_adapter_support_mode = ufcs_protocol_detect_adapter_support_mode,
	.get_support_mode = ufcs_protocol_get_support_mode,
	.set_default_state = ufcs_protocol_set_default_state,
	.set_default_param = ufcs_protocol_set_default_param,
	.set_init_data = ufcs_protocol_set_init_data,
	.soft_reset_master = ufcs_protocol_soft_reset_master,
	.soft_reset_slave = ufcs_protocol_soft_reset_slave,
	.get_chip_vendor_id = ufcs_protocol_get_chip_vendor_id,
	.get_inside_temp = ufcs_protocol_get_inside_temp,
	.get_port_temp = ufcs_protocol_get_port_temp,
	.set_output_voltage = ufcs_protocol_set_output_voltage,
	.get_output_voltage = ufcs_protocol_get_output_voltage,
	.set_output_current = ufcs_protocol_set_output_current,
	.get_output_current = ufcs_protocol_get_output_current,
	.get_output_current_set = ufcs_protocol_get_output_current_set,
	.get_min_voltage = ufcs_protocol_get_min_voltage,
	.get_max_voltage = ufcs_protocol_get_max_voltage,
	.get_min_current = ufcs_protocol_get_min_current,
	.get_max_current = ufcs_protocol_get_max_current,
	.get_power_drop_current = ufcs_protocol_get_power_drop_current,
	.get_device_info = ufcs_protocol_get_device_info,
	.get_protocol_register_state = ufcs_protocol_get_protocol_register_state,
};

static int __init ufcs_protocol_init(void)
{
	int ret;
	struct ufcs_protocol_dev *l_dev = NULL;

	l_dev = kzalloc(sizeof(*l_dev), GFP_KERNEL);
	if (!l_dev)
		return -ENOMEM;

	g_ufcs_protocol_dev = l_dev;
	l_dev->dev_id = PROTOCOL_DEVICE_ID_END;

	ret = adapter_protocol_ops_register(&adapter_protocol_ufcs_ops);
	if (ret)
		goto fail_register_ops;

	mutex_init(&l_dev->msg_number_lock);
	return 0;

fail_register_ops:
	kfree(l_dev);
	g_ufcs_protocol_dev = NULL;
	return ret;
}

static void __exit ufcs_protocol_exit(void)
{
	if (!g_ufcs_protocol_dev)
		return;

	mutex_destroy(&g_ufcs_protocol_dev->msg_number_lock);
	kfree(g_ufcs_protocol_dev);
	g_ufcs_protocol_dev = NULL;
}

subsys_initcall_sync(ufcs_protocol_init);
module_exit(ufcs_protocol_exit);

MODULE_LICENSE("GPL v2");
MODULE_DESCRIPTION("ufcs protocol driver");
MODULE_AUTHOR("Huawei Technologies Co., Ltd.");
