/*
 * hw_pd.c
 *
 * pd dpm driver
 *
 * Copyright (c) 2016-2020 Huawei Technologies Co., Ltd.
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

#include <linux/console.h>
#include <linux/delay.h>
#include <linux/device.h>
#include <linux/gpio.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#include <linux/io.h>
#include <linux/irq.h>
#include <linux/jiffies.h>
#include <linux/module.h>
#include <linux/mutex.h>
#include <linux/notifier.h>
#include <linux/of.h>
#include <linux/of_gpio.h>
#include <linux/platform_device.h>
#include <linux/pm_wakeup.h>
#include <linux/power/huawei_charger.h>
#include <linux/slab.h>
#include <linux/usb/class-dual-role.h>
#include <linux/version.h>

#include <chipset_common/hwpower/common_module/power_cmdline.h>
#include <chipset_common/hwpower/common_module/power_event_ne.h>
#include <chipset_common/hwpower/common_module/power_interface.h>
#include <chipset_common/hwpower/common_module/power_sysfs.h>
#include <chipset_common/hwpower/hardware_monitor/water_detect.h>
#include <huawei_platform/log/hw_log.h>
#include <huawei_platform/power/direct_charger/direct_charger.h>
#include <huawei_platform/power/huawei_charger.h>
#include <huawei_platform/power/huawei_charger_adaptor.h>
#include <huawei_platform/usb/hw_pd_dev.h>
#include <huawei_platform/usb/switch/switch_fsa9685.h>
#include <huawei_platform/usb/switch/usbswitch_common.h>

#ifdef CONFIG_BOOST_5V
#include <chipset_common/hwpower/hardware_ic/boost_5v.h>
#endif /* CONFIG_BOOST_5V */
#ifdef CONFIG_WIRELESS_CHARGER
#include <huawei_platform/power/wireless/wireless_charger.h>
#endif /* CONFIG_WIRELESS_CHARGER */

#include <chipset_common/hwpower/hardware_channel/vbus_channel.h>

#include <linux/fb.h>
#ifdef CONFIG_HUAWEI_HISHOW
#include <huawei_platform/usb/hw_hishow.h>
#endif /* CONFIG_HUAWEI_HISHOW */
#include <linux/regulator/consumer.h>
#define CC_SHORT_DEBOUNCE 50 /* ms */

struct pd_dpm_info *g_pd_di;
static bool g_pd_cc_orientation;
static int g_pd_cc_orientation_factory;
#ifdef CONFIG_TYPEC_CAP_CUSTOM_SRC2
static bool g_pd_smart_holder;
int support_smart_holder;
#endif /* CONFIG_TYPEC_CAP_CUSTOM_SRC2 */
static struct device *typec_dev;
static int pd_dpm_typec_state = PD_DPM_USB_TYPEC_DETACHED;
static int pd_dpm_analog_hs_state;
static struct pd_dpm_vbus_state g_vbus_state;
static unsigned long g_charger_type_event;
struct completion pd_get_typec_state_completion;
static bool g_pd_high_power_charging_status;
static bool g_pd_high_voltage_charging_status;
static bool g_pd_optional_max_power_status;
static bool g_pd_optional_wireless_cover_status;
struct cc_check_ops* g_cc_check_ops;
static bool ignore_vbus_on_event;
static bool ignore_vbus_off_event;
static bool ignore_bc12_event_when_vbuson;
static bool ignore_bc12_event_when_vbusoff;
static enum pd_dpm_cc_voltage_type remote_rp_level = PD_DPM_CC_VOLT_OPEN;
static struct pd_dpm_ops *g_ops;
#ifdef CONFIG_TYPEC_CAP_CUSTOM_SRC2
static struct cable_vdo_ops *g_cable_vdo_ops = NULL;
#endif /* CONFIG_TYPEC_CAP_CUSTOM_SRC2 */
static void *g_client;
static int switch_manual_enable = 1;
static unsigned int abnormal_cc_detection;
static unsigned int abnormal_cc_interval = PD_DPM_CC_CHANGE_INTERVAL;
int support_dp = 1;
static int g_otg_channel;
int moisture_detection_by_cc_enable;
static unsigned int g_cc_abnormal_dmd_report_enable;
int support_analog_audio = 1;
struct mutex typec_state_lock;
struct mutex typec_wait_lock;
static int g_pd_product_type = -1;
static bool g_pd_cc_moisture_status;
static bool g_pd_cc_moisture_happened;
static int cc_moisture_status_report;
static int emark_detect_enable;
#if defined(CONFIG_TCPC_CLASS) || defined(CONFIG_HW_TCPC_CLASS)
static bool g_audio_power_no_hs_flag;
#endif
/* 0: disabled 1: only for SC; 2: for SC and LVC */
static unsigned int cc_dynamic_protect;
static struct delayed_work cc_short_work;
#ifdef CONFIG_UVDM_CHARGER
static struct work_struct g_uvdm_work;
static unsigned int g_uvdm_work_cnt;
#endif /* CONFIG_UVDM_CHARGER */

void pd_dpm_set_cc_mode(int mode);
void pd_dpm_reinit_chip(void);

#define PD_DPM_MAX_OCP_COUNT            1000
#define OCP_DELAY_TIME                  5000
#define DISABLE_INTERVAL                50
#define GET_IBUS_INTERVAL               1000
#define MMI_PD_TIMES                    3
#define MMI_PD_IBUS_MIN                 300
#define POGOPIN_OTG_CHANNEL             1

#define PD_DPM_POWER_QUICK_CHG_THR      18000000
#define PD_DPM_POWER_WIRELESS_CHG_THR   9000000
#define TCP_VBUS_CTRL_PD_DETECT         (1 << 7)
#define PD_ROLE_UFP                     0
#define PD_ROLE_DFP                     1

#ifndef HWLOG_TAG
#define HWLOG_TAG huawei_pd
HWLOG_REGIST();
#endif /* HWLOG_TAG */

static bool g_ignore_vbus_only_event;
int g_cur_usb_event = PD_DPM_USB_TYPEC_NONE;
static enum charger_event_type sink_source_type = STOP_SINK;

static struct abnomal_change_info abnomal_change[] = {
	{PD_DPM_ABNORMAL_CC_CHANGE, true, 0, 0, {0}, {0}, {0}, {0}},
	{PD_DPM_UNATTACHED_VBUS_ONLY, true, 0, 0, {0}, {0}, {0}, {0}},
};

int pd_dpm_get_emark_detect_enable(void)
{
	return emark_detect_enable;
}

static void pd_dpm_cc_moisture_flag_restore(struct work_struct *work)
{
	hwlog_err("%s %d,%d\n", __func__,
		  g_pd_cc_moisture_happened,
		  g_pd_cc_moisture_status);
	if (!g_pd_cc_moisture_happened)
		g_pd_cc_moisture_status = false;
}

static void fb_unblank_work(struct work_struct *work)
{
	unsigned int flag = WD_NON_STBY_DRY;

	hwlog_err("%s set pd to drp\n", __func__);
	pd_dpm_set_cc_mode(PD_DPM_CC_MODE_DRP);
	power_event_bnc_notify(POWER_BNT_WD, POWER_NE_WD_REPORT_UEVENT, &flag);

	if (cc_moisture_status_report == 0)
		return;

	g_pd_cc_moisture_happened = false;
	/* delay 2 minute to restore the flag */
	queue_delayed_work(g_pd_di->usb_wq,
		&g_pd_di->cc_moisture_flag_restore_work,
		msecs_to_jiffies(120000)); /* 120000: delay 120 secs */
}

static int pd_dpm_handle_fb_event(struct notifier_block *self,
	unsigned long event, void *data)
{
	struct fb_event *fb_event = data;
	int *blank = NULL;

	if (!g_pd_di || !fb_event)
		return NOTIFY_DONE;

	blank = fb_event->data;
	if (!blank)
		return NOTIFY_DONE;

	if ((event == FB_EVENT_BLANK) && (*blank == FB_BLANK_UNBLANK))
		schedule_work(&g_pd_di->fb_work);

	return NOTIFY_DONE;
}

static struct notifier_block pd_dpm_handle_fb_notifier = {
	.notifier_call = pd_dpm_handle_fb_event,
};

static void init_fb_notification(void)
{
	fb_register_client(&pd_dpm_handle_fb_notifier);
}

void pd_dpm_set_source_sink_state(enum charger_event_type type)
{
	sink_source_type = type;
}

enum charger_event_type pd_dpm_get_source_sink_state(void)
{
	return sink_source_type;
}
int pd_dpm_ops_register(struct pd_dpm_ops *ops, void *client)
{
	int ret = 0;

	if (g_ops) {
		hwlog_err("pd_dpm ops register fail! g_ops busy\n");
		return -EBUSY;
	}

	if (ops) {
		g_ops = ops;
		g_client = client;
	} else {
		hwlog_err("pd_dpm ops register fail!\n");
		ret = -EPERM;
	}
	return ret;
}

#ifdef CONFIG_TYPEC_CAP_CUSTOM_SRC2
int pd_dpm_cable_vdo_ops_register(struct cable_vdo_ops *ops)
{
	if (!ops) {
		hwlog_err("cable_vdo_ops ops register fail!\n");
		return -EPERM;
	}

	g_cable_vdo_ops = ops;
	return 0;
}
#endif /* CONFIG_TYPEC_CAP_CUSTOM_SRC2 */

void pd_dpm_detect_emark_cable(void)
{
	hwlog_err("%s\n", __func__);

	if (g_ops && g_ops->pd_dpm_detect_emark_cable)
		g_ops->pd_dpm_detect_emark_cable(g_client);
}

void pd_dpm_detect_emark_cable_finish(void)
{
	int typec_state = PD_DPM_USB_TYPEC_HOST_ATTACHED;

	pd_dpm_get_typec_state(&typec_state);
	if (typec_state != PD_DPM_USB_TYPEC_HOST_ATTACHED)
		return;
	if (!g_ops || !g_ops->data_role_swap || !g_client)
		return;
	if (!g_ops->data_role_swap(g_client)) {
		hwlog_info("emark finish data_role_swap\n");
		msleep(50); /* wait for swap complete */
	}
}

int pd_dpm_disable_pd(bool disable)
{
	hwlog_info("%s\n", __func__);

	if (!g_ops) {
		hwlog_err("%s g_ops is NULL\n", __func__);
		return -EPERM;
	}

	if (!g_ops->pd_dpm_disable_pd) {
		hwlog_err("%s pd_dpm_disable_pd is NULL\n", __func__);
		return -EPERM;
	}

	return g_ops->pd_dpm_disable_pd(g_client, disable);
}

void pd_dpm_set_cc_mode(int mode)
{
	static int cur_mode = PD_DPM_CC_MODE_DRP;

	hwlog_info("%s cur_mode = %d, new mode = %d\n",
		__func__, cur_mode, mode);
	if (!g_ops || !g_ops->pd_dpm_set_cc_mode || cur_mode == mode)
		return;

	g_ops->pd_dpm_set_cc_mode(mode);
	cur_mode = mode;
}

/*
 * bugfix: For Hi65xx
 * DRP lost Cable(without adapter) plugin during Wireless.
 */
void pd_pdm_enable_drp(void)
{
	if (g_ops && g_ops->pd_dpm_enable_drp)
		g_ops->pd_dpm_enable_drp(PD_PDM_RE_ENABLE_DRP);
}

void pd_dpm_reinit_chip(void)
{
	if (g_ops && g_ops->pd_dpm_reinit_chip)
		g_ops->pd_dpm_reinit_chip(g_client);
}

bool pd_dpm_get_hw_dock_svid_exist(void)
{
	if (g_ops && g_ops->pd_dpm_get_hw_dock_svid_exist)
		return g_ops->pd_dpm_get_hw_dock_svid_exist(g_client);

	return false;
}

int pd_dpm_notify_direct_charge_status(bool dc)
{
	hwlog_err("%s,%d", __func__, __LINE__);
	if (g_ops && g_ops->pd_dpm_notify_direct_charge_status) {
		hwlog_err("%s,%d", __func__, __LINE__);
		return g_ops->pd_dpm_notify_direct_charge_status(g_client, dc);
	}

	return false;
}

#if defined(CONFIG_TCPC_CLASS) || defined(CONFIG_HW_TCPC_CLASS)
static bool pd_dpm_get_audio_power_no_hs_state(void)
{
	return g_audio_power_no_hs_flag;
}

void pd_dpm_set_audio_power_no_hs_state(bool flag)
{
	g_audio_power_no_hs_flag = flag;
}
#endif

void pd_dpm_set_cc_voltage(int type)
{
	remote_rp_level = type;
}

enum pd_dpm_cc_voltage_type pd_dpm_get_cc_voltage(void)
{
	return remote_rp_level;
}

bool pd_dpm_ignore_vbuson_event(void)
{
	return ignore_vbus_on_event;
}

bool pd_dpm_ignore_vbusoff_event(void)
{
	return ignore_vbus_off_event;
}

void pd_dpm_set_ignore_vbuson_event(bool _ignore_vbus_on_event)
{
	ignore_vbus_on_event = _ignore_vbus_on_event;
}

void pd_dpm_set_ignore_vbusoff_event(bool _ignore_vbus_off_event)
{
	ignore_vbus_off_event = _ignore_vbus_off_event;
}

bool pd_dpm_ignore_bc12_event_when_vbuson(void)
{
	return ignore_bc12_event_when_vbuson;
}

bool pd_dpm_ignore_bc12_event_when_vbusoff(void)
{
	return ignore_bc12_event_when_vbusoff;
}

void pd_dpm_set_ignore_bc12_event_when_vbuson(bool _ignore_bc12_event)
{
	ignore_bc12_event_when_vbuson = _ignore_bc12_event;
}

void pd_dpm_set_ignore_bc12_event_when_vbusoff(bool _ignore_bc12_event)
{
	ignore_bc12_event_when_vbusoff = _ignore_bc12_event;
}

bool pd_dpm_get_high_power_charging_status()
{
	hwlog_info("%s status =%d\n", __func__, g_pd_high_power_charging_status);
	return g_pd_high_power_charging_status;
}

void pd_dpm_set_high_power_charging_status(bool status)
{
	hwlog_info("%s status =%d\n", __func__, status);
	g_pd_high_power_charging_status = status;
}

bool pd_dpm_get_high_voltage_charging_status()
{
	hwlog_info("%s status =%d\n", __func__, g_pd_high_voltage_charging_status);
	return g_pd_high_voltage_charging_status;
}

void pd_dpm_set_high_voltage_charging_status(bool status)
{
	hwlog_info("%s status =%d\n", __func__, status);
	g_pd_high_voltage_charging_status = status;
}

bool pd_dpm_get_optional_max_power_status()
{
	hwlog_info("%s status =%d\n", __func__, g_pd_optional_max_power_status);
	return g_pd_optional_max_power_status;
}

void pd_dpm_set_optional_max_power_status(bool status)
{
	hwlog_info("%s status =%d\n", __func__, status);
	g_pd_optional_max_power_status = status;
}

static bool pd_dpm_get_wireless_cover_power_status(void)
{
	hwlog_info("%s status =%d\n", __func__,
		g_pd_optional_wireless_cover_status);
	return g_pd_optional_wireless_cover_status;
}

static void pd_dpm_set_wireless_cover_power_status(bool status)
{
	hwlog_info("%s status =%d\n", __func__, status);
	g_pd_optional_wireless_cover_status = status;
}

void pd_dpm_get_charge_event(unsigned long *event, struct pd_dpm_vbus_state *state)
{
	hwlog_info("%s event =%ld\n", __func__, g_charger_type_event);

	*event = g_charger_type_event;
	memcpy(state, &g_vbus_state, sizeof(struct pd_dpm_vbus_state));
}

static void pd_dpm_set_charge_event(unsigned long event, struct pd_dpm_vbus_state *state)
{
	hwlog_info("%s event =%ld\n", __func__, event);

	if (state)
		memcpy(&g_vbus_state, state, sizeof(struct pd_dpm_vbus_state));
	g_charger_type_event = event;
}

int cc_check_ops_register(struct cc_check_ops* ops)
{
	int ret = 0;

	if (g_cc_check_ops) {
		hwlog_err("cc_check ops register fail! g_cc_check_ops busy\n");
		return -EBUSY;
	}

	if (ops) {
		g_cc_check_ops = ops;
	} else {
		hwlog_err("cc_check ops register fail\n");
		ret = -EPERM;
	}
	return ret;
}

static int direct_charge_cable_detect(void)
{
	int ret;

	if (!g_cc_check_ops)
		return -1;

	ret = g_cc_check_ops->is_cable_for_direct_charge();
	if (ret) {
		hwlog_info("%s:cc_check  fail\n", __func__);
		return -1;
	}
	return 0;
}

static struct dc_cable_ops cable_detect_ops = {
	.detect = direct_charge_cable_detect,
};

bool pd_dpm_get_cc_orientation(void)
{
	hwlog_info("%s cc_orientation =%d\n", __func__, g_pd_cc_orientation);
	return g_pd_cc_orientation;
}

void pd_dpm_set_cc_orientation(bool cc_orientation)
{
	hwlog_info("%s cc_orientation =%d\n", __func__, cc_orientation);
	g_pd_cc_orientation = cc_orientation;
}

#ifdef CONFIG_TYPEC_CAP_CUSTOM_SRC2
static bool pd_dpm_is_smart_holder(void)
{
	return g_pd_smart_holder;
}
#endif /* CONFIG_TYPEC_CAP_CUSTOM_SRC2 */

void pd_dpm_get_typec_state(int *typec_state)
{
	hwlog_info("%s pd_dpm_get_typec_state  = %d\n", __func__, pd_dpm_typec_state);

	*typec_state = pd_dpm_typec_state;
	return;
}
/* for analog audio driver polling */
int pd_dpm_get_analog_hs_state(void)
{
	hwlog_info("%s analog_hs_state  = %d\n", __func__, pd_dpm_analog_hs_state);

	return pd_dpm_analog_hs_state;
}

static void pd_dpm_set_typec_state(int typec_state)
{
	hwlog_info("%s pd_dpm_set_typec_state  = %d\n", __func__, typec_state);
	blocking_notifier_call_chain(&g_pd_di->pd_port_status_nh, typec_state, NULL);
	pd_dpm_typec_state = typec_state;

	if ((pd_dpm_typec_state == PD_DPM_USB_TYPEC_NONE) ||
		(pd_dpm_typec_state == PD_DPM_USB_TYPEC_DETACHED) ||
		(pd_dpm_typec_state == PD_DPM_USB_TYPEC_AUDIO_DETACHED))
		hwlog_info("%s report detach, stop ovp & start res detect\n", __func__);
	 else
		hwlog_info("%s report attach, stop res & satrt ovp detect\n", __func__);
}

int pd_get_product_type(void)
{
	hwlog_info("%s product type %d\n", __func__, g_pd_product_type);
	return g_pd_product_type;
}

void pd_set_product_type(int type)
{
	g_pd_product_type = type;
}

#if defined(CONFIG_TCPC_CLASS) || defined(CONFIG_HW_TCPC_CLASS)
bool pd_judge_is_cover(void)
{
	if ((pd_get_product_type() == PD_PDT_WIRELESS_COVER) ||
		(pd_get_product_type() == PD_PDT_WIRELESS_COVER_TWO))
		return true;

	return false;
}
#endif

static inline void uvdm_send_work(struct work_struct *work)
{
}

static inline void uvdm_init_work(void)
{
}

static inline void uvdm_cancel_work(void)
{
}

void pd_dpm_set_max_power(int max_power)
{
	int icon_type;

	hwlog_info("%s max_power=%d\n", __func__, max_power);
	/* wireless cover */
	if ((pd_get_product_type() == PD_PDT_WIRELESS_COVER) ||
		(pd_get_product_type() == PD_PDT_WIRELESS_COVER_TWO)) {
		if (max_power >= PD_DPM_POWER_WIRELESS_CHG_THR) {
			icon_type = ICON_TYPE_WIRELESS_QUICK;
			power_ui_event_notify(POWER_UI_NE_ICON_TYPE, &icon_type);
		}
		hwlog_info("%s wireless cover is on\n", __func__);
		return;
	}

	if (max_power >= PD_DPM_POWER_WIRELESS_CHG_THR)
		pd_dpm_set_wireless_cover_power_status(true);
	else
		pd_dpm_set_wireless_cover_power_status(false);

	/* wired */
	if (max_power >= PD_DPM_POWER_QUICK_CHG_THR) {
		pd_dpm_set_optional_max_power_status(true);
		icon_type = ICON_TYPE_QUICK;
		power_ui_event_notify(POWER_UI_NE_ICON_TYPE, &icon_type);
	} else {
		pd_dpm_set_optional_max_power_status(false);
	}
}

static void pd_send_wireless_cover_uevent(void)
{
	int cover_status = 1; /* wireless cover is ready */
	int icon_type;

	power_ui_event_notify(POWER_UI_NE_WL_COVER_STATUS, &cover_status);

	if (pd_dpm_get_wireless_cover_power_status())
		icon_type = ICON_TYPE_WIRELESS_QUICK;
	else
		icon_type = ICON_TYPE_WIRELESS_NORMAL;

	power_ui_event_notify(POWER_UI_NE_ICON_TYPE, &icon_type);
}

void pd_set_product_id_info(unsigned int vid, unsigned int pid, unsigned int bcd)
{
	int pd_product_type;

	if (bcd == PD_PID_COVER_ONE)
		pd_product_type = PD_PDT_WIRELESS_COVER;
	else if (bcd == PD_PID_COVER_TWO)
		pd_product_type = PD_PDT_WIRELESS_COVER_TWO;
	else
		return;

	pd_set_product_type(pd_product_type);
	hwlog_info("%s vid = 0x%x, pid = 0x%x, type = 0x%x, bcd = 0x%x\n",
		__func__, vid, pid, pd_product_type, bcd);

	switch (pd_product_type) {
	case PD_PDT_WIRELESS_COVER:
		if ((vid == PD_DPM_HW_VID) && (pid == PD_DPM_HW_CHARGER_PID))
			pd_send_wireless_cover_uevent();
		break;
	case PD_PDT_WIRELESS_COVER_TWO:
		if ((vid == PD_DPM_HW_VID) && (pid == PD_DPM_HW_CHARGER_PID))
			pd_send_wireless_cover_uevent();
		break;
	default:
		hwlog_err("undefined type %d\n", pd_product_type);
		break;
	}
}

static ssize_t pd_dpm_cc_orientation_show(struct device *dev, struct device_attribute *attr,
	char *buf)
{
	/* 3 means cc is abnormally grounded */
	if (g_pd_cc_orientation_factory == CC_ORIENTATION_FACTORY_SET)
		return scnprintf(buf, PAGE_SIZE, "%s\n", "3");

	return scnprintf(buf, PAGE_SIZE, "%s\n", pd_dpm_get_cc_orientation() ? "2" : "1");
}

static ssize_t pd_dpm_pd_state_show(struct device *dev,
	struct device_attribute *attr, char *buf)
{
	int retrys = 0;

	hwlog_info("%s  = %d\n", __func__, pd_dpm_get_pd_finish_flag());
	if (pd_dpm_get_pd_finish_flag()) {
		while (retrys++ < MMI_PD_TIMES) {
			hwlog_info("%s, ibus = %d\n", __func__, charge_get_ibus());
			if (charge_get_ibus() >= MMI_PD_IBUS_MIN)
				return scnprintf(buf, PAGE_SIZE, "%s\n", "0");
			msleep(GET_IBUS_INTERVAL);
		}
	}
	return scnprintf(buf, PAGE_SIZE, "%s\n", "1");
}

#ifdef CONFIG_TYPEC_CAP_CUSTOM_SRC2
static ssize_t pd_dpm_smart_holder_show(struct device *dev,
	struct device_attribute *attr, char *buf)
{
	hwlog_info("%s  = %d\n", __func__, pd_dpm_is_smart_holder());
	return scnprintf(buf, PAGE_SIZE, "%s\n", pd_dpm_is_smart_holder() ? "1" : "0");
}
#endif
static ssize_t pd_dpm_cc_state_show(struct device *dev, struct device_attribute *attr,
	char *buf)
{
	int ret;
	unsigned int cc1 = 0;
	unsigned int cc2 = 0;
	unsigned int cc = 0;

	ret = pd_dpm_get_cc_state_type(&cc1, &cc2);
	if (ret == 0)
		cc = ((cc1 & PD_DPM_CC_STATUS_MASK) |
			(cc2 << PD_DPM_CC2_STATUS_OFFSET)) &
			PD_DPM_BOTH_CC_STATUS_MASK;

	return scnprintf(buf, PAGE_SIZE, "%d\n", cc);
}

static DEVICE_ATTR(cc_orientation, S_IRUGO, pd_dpm_cc_orientation_show, NULL);
static DEVICE_ATTR(pd_state, S_IRUGO, pd_dpm_pd_state_show, NULL);
#ifdef CONFIG_TYPEC_CAP_CUSTOM_SRC2
static DEVICE_ATTR(smart_holder, S_IRUGO, pd_dpm_smart_holder_show, NULL);
#endif /* CONFIG_TYPEC_CAP_CUSTOM_SRC2 */
static DEVICE_ATTR(cc_state, S_IRUGO, pd_dpm_cc_state_show, NULL);
static struct attribute *pd_dpm_ctrl_attributes[] = {
	&dev_attr_cc_orientation.attr,
	&dev_attr_pd_state.attr,
#ifdef CONFIG_TYPEC_CAP_CUSTOM_SRC2
	&dev_attr_smart_holder.attr,
#endif /* CONFIG_TYPEC_CAP_CUSTOM_SRC2 */
	&dev_attr_cc_state.attr,
	NULL,
};

static const struct attribute_group pd_dpm_attr_group = {
	.attrs = pd_dpm_ctrl_attributes,
};

int pd_dpm_wake_unlock_notifier_call(struct pd_dpm_info *di, unsigned long event, void *data)
{
	return atomic_notifier_call_chain(&di->pd_wake_unlock_evt_nh, event, data);
}

int pd_dpm_vbus_notifier_call(struct pd_dpm_info *di, unsigned long event, void *data)
{
	if (event == CHARGER_TYPE_NONE) {
		pd_dpm_set_high_power_charging_status(false);
		pd_dpm_set_optional_max_power_status(false);
		pd_dpm_set_wireless_cover_power_status(false);
		pd_dpm_set_high_voltage_charging_status(false);
	}
	if (event != PD_DPM_VBUS_TYPE_TYPEC)
		pd_dpm_set_charge_event(event, data);
	return blocking_notifier_call_chain(&di->pd_evt_nh, event, data);
}
static int charge_wake_unlock_notifier_call(struct notifier_block *chrg_wake_unlock_nb,
	unsigned long event, void *data)
{
	if (g_pd_di)
		pd_dpm_wake_unlock_notifier_call(g_pd_di, PD_WAKE_UNLOCK, NULL);

	return NOTIFY_OK;
}
bool pd_dpm_get_ctc_cable_flag(void)
{
	if (g_pd_di)
		return g_pd_di->ctc_cable_flag;

	return false;
}

void pd_dpm_set_ctc_cable_flag(bool flag)
{
	if (g_pd_di)
		 g_pd_di->ctc_cable_flag = flag;
}

bool pd_dpm_get_pd_finish_flag(void)
{
	if (g_pd_di)
		return g_pd_di->pd_finish_flag;
	else
		return false;
}

void pd_dpm_set_pd_finish_flag(bool flag)
{
	if (g_pd_di)
		g_pd_di->pd_finish_flag = flag;
}

bool pd_dpm_get_pd_source_vbus(void)
{
	if (g_pd_di)
		return g_pd_di->pd_source_vbus;
	else
		return false;
}

bool pd_dpm_check_cc_vbus_short(void)
{
	int ret;
	unsigned int cc1 = 0;
	unsigned int cc2 = 0;

	/*
	 * Get result from chip module directly,
	 * Only for HISI_PD at present.
	 */
	if (g_ops && g_ops->pd_dpm_check_cc_vbus_short) {
		hwlog_info("Hisi PD\n");
		return g_ops->pd_dpm_check_cc_vbus_short();
	}

	ret = pd_dpm_get_cc_state_type(&cc1, &cc2);
	if (ret)
		return false;

	hwlog_info("%s: cc1:%d, cc2:%d\n", __func__, cc1, cc2);

	if ((cc1 == PD_DPM_CC_3_0) && (cc2 > PD_DPM_CC_OPEN))
		return true;

	if ((cc2 == PD_DPM_CC_3_0) && (cc1 > PD_DPM_CC_OPEN))
		return true;

	return false;
}

/*
 * Function:       pd_dpm_get_cc_state_type
 * Description:   get cc1 and cc2 state
 *                             open    56k    22k    10k
 *                     cc1    00       01     10     11
 *                     cc2    00       01     10     11
 * Input:           cc1: value of cc1  cc2: value of cc2
 * Output:         cc1: value of cc1  cc2: value of cc2
 * Return:         success: 0   fail: -1
*/
int pd_dpm_get_cc_state_type(unsigned int *cc1, unsigned int *cc2)
{
	unsigned int cc;

	if (!g_ops || !g_ops->pd_dpm_get_cc_state)
		return -1;

	cc = g_ops->pd_dpm_get_cc_state();
	*cc1 = cc & PD_DPM_CC_STATUS_MASK;
	*cc2 = (cc >> PD_DPM_CC2_STATUS_OFFSET) & PD_DPM_CC_STATUS_MASK;

	return 0;
}

void pd_dpm_report_pd_source_vconn(const void *data)
{
	if (data)
#ifdef CONFIG_BOOST_5V
		boost_5v_enable(*(int *)data, BOOST_CTRL_PD_VCONN);
#endif /* CONFIG_BOOST_5V */
	hwlog_info("%s - \n", __func__);
}
void pd_dpm_report_pd_source_vbus(struct pd_dpm_info *di, void *data)
{
	struct pd_dpm_vbus_state *vbus_state = data;

	mutex_lock(&di->sink_vbus_lock);
	ignore_bc12_event_when_vbuson = true;

	if (vbus_state->vbus_type & TCP_VBUS_CTRL_PD_DETECT) {
		di->pd_finish_flag = true;
		di->ctc_cable_flag = true;
	}

	if (vbus_state->mv == 0) {
		hwlog_info("%s : Disable\n", __func__);

		if (g_otg_channel) {
			vbus_ch_close(VBUS_CH_USER_PD,
				VBUS_CH_TYPE_BOOST_GPIO, true, false);
#ifdef CONFIG_POGO_PIN
		} else if (pogopin_is_support() && (pogopin_otg_from_buckboost() == true)) {
			vbus_ch_close(VBUS_CH_USER_PD, VBUS_CH_TYPE_POGOPIN_BOOST, true, false);
#endif /* CONFIG_POGO_PIN */
		} else {
			pd_dpm_vbus_notifier_call(g_pd_di, CHARGER_TYPE_NONE, data);
			pd_dpm_set_source_sink_state(STOP_SOURCE);
		}
	} else {
		di->pd_source_vbus = true;
		hwlog_info("%s : Source %d mV, %d mA\n", __func__, vbus_state->mv, vbus_state->ma);

		if (g_otg_channel) {
			vbus_ch_open(VBUS_CH_USER_PD, VBUS_CH_TYPE_BOOST_GPIO, true);
#ifdef CONFIG_POGO_PIN
		} else if (pogopin_is_support() && (pogopin_otg_from_buckboost() == true)) {
			vbus_ch_open(VBUS_CH_USER_PD, VBUS_CH_TYPE_POGOPIN_BOOST, true);
#endif /* CONFIG_POGO_PIN */
		} else {
			pd_dpm_vbus_notifier_call(g_pd_di, PLEASE_PROVIDE_POWER, data);
			pd_dpm_set_source_sink_state(START_SOURCE);
		}
	}
	mutex_unlock(&di->sink_vbus_lock);
}

#define VBUS_VOL_9000MV 9000
void pd_dpm_report_pd_sink_vbus(struct pd_dpm_info *di, void *data)
{
	bool high_power_charging = false;
	bool high_voltage_charging = false;
	unsigned long event;
	struct pd_dpm_vbus_state *vbus_state = data;

	mutex_lock(&di->sink_vbus_lock);
	pd_dpm_set_cc_voltage(vbus_state->remote_rp_level);

	if (vbus_state->vbus_type & TCP_VBUS_CTRL_PD_DETECT) {
		adapter_test_set_result(AT_TYPE_PD, AT_PROTOCOL_FINISH_SUCC);
		di->pd_finish_flag = true;
		di->ctc_cable_flag = true;
	}

	if (di->pd_finish_flag)
		event = PD_DPM_VBUS_TYPE_PD;
	else
		event = PD_DPM_VBUS_TYPE_TYPEC;

	vbus_state = data;

	if (vbus_state->mv == 0) {
		if (event == PD_DPM_VBUS_TYPE_PD) {
			hwlog_info("%s : Disable\n", __func__);
			pd_dpm_vbus_notifier_call(g_pd_di, CHARGER_TYPE_NONE, data);
			pd_dpm_set_source_sink_state(STOP_SINK);
		}
	} else {
		di->pd_source_vbus = false;
		hwlog_info("%s : Sink %d mV, %d mA\n", __func__, vbus_state->mv, vbus_state->ma);
		/* 18000000: 18W */
		if ((vbus_state->mv * vbus_state->ma) >= 18000000) {
			hwlog_info("%s : over 18w\n", __func__);
			high_power_charging = true;
		}

		if (vbus_state->mv >= VBUS_VOL_9000MV) {
			hwlog_info("%s : over 9V\n", __func__);
			high_voltage_charging = true;
		}

		hwlog_info("%s : %d\n", __func__, vbus_state->mv * vbus_state->ma);
		pd_dpm_set_high_power_charging_status(high_power_charging);
		pd_dpm_set_high_voltage_charging_status(high_voltage_charging);

		if (pd_dpm_typec_state != PD_DPM_USB_TYPEC_DETACHED)
			pd_dpm_set_source_sink_state(START_SINK);

		pd_dpm_vbus_notifier_call(g_pd_di, event, data);
	}

	mutex_unlock(&di->sink_vbus_lock);
}

#if defined(CONFIG_TCPC_CLASS) || defined(CONFIG_HW_TCPC_CLASS)
void pd_dpm_wakelock_ctrl(unsigned long event)
{
	if (g_pd_di)
		if ((event == PD_WAKE_LOCK) || (event == PD_WAKE_UNLOCK))
			pd_dpm_wake_unlock_notifier_call(g_pd_di, event, NULL);
}
#endif

#ifdef CONFIG_WIRELESS_CHARGER
static void pd_dpm_vbus_ch_open(struct pd_dpm_info *di)
{
	if (g_otg_channel) {
		pd_dpm_set_ignore_vbuson_event(false);
		vbus_ch_open(VBUS_CH_USER_PD, VBUS_CH_TYPE_BOOST_GPIO, false);
	} else {
		pd_dpm_set_ignore_vbuson_event(true);
#ifdef CONFIG_POGO_PIN
		if (pogopin_is_support() && pogopin_otg_from_buckboost())
			vbus_ch_open(VBUS_CH_USER_PD, VBUS_CH_TYPE_POGOPIN_BOOST, true);
		else
#endif
			pd_dpm_set_source_sink_state(START_SOURCE);
		pd_dpm_vbus_notifier_call(di, PLEASE_PROVIDE_POWER, NULL);
	}
}

static void pd_dpm_vbus_ch_close(struct pd_dpm_info *di)
{
	if (g_otg_channel) {
		pd_dpm_set_ignore_vbusoff_event(false);
		vbus_ch_close(VBUS_CH_USER_PD, VBUS_CH_TYPE_BOOST_GPIO,
			false, false);
	} else {
		pd_dpm_set_ignore_vbusoff_event(true);
#ifdef CONFIG_POGO_PIN
		if (pogopin_is_support() && pogopin_otg_from_buckboost())
			vbus_ch_close(VBUS_CH_USER_PD,
				VBUS_CH_TYPE_POGOPIN_BOOST, true, false);
		else
#endif
			pd_dpm_set_source_sink_state(STOP_SOURCE);
		pd_dpm_vbus_notifier_call(di, CHARGER_TYPE_NONE, NULL);
	}
}
#else
static void pd_dpm_vbus_ch_open(struct pd_dpm_info *di)
{
#ifdef CONFIG_POGO_PIN
	if (pogopin_is_support() && pogopin_otg_from_buckboost()) {
		vbus_ch_open(VBUS_CH_USER_PD, VBUS_CH_TYPE_POGOPIN_BOOST, true);
	} else {
		pd_dpm_set_ignore_vbuson_event(true);
		pd_dpm_set_source_sink_state(START_SOURCE);
	}
#else
	pd_dpm_set_ignore_vbuson_event(true);
	pd_dpm_set_source_sink_state(START_SOURCE);
#endif
	pd_dpm_vbus_notifier_call(di, PLEASE_PROVIDE_POWER, NULL);
}

static void pd_dpm_vbus_ch_close(struct pd_dpm_info *di)
{
#ifdef CONFIG_POGO_PIN
	if (pogopin_is_support() && pogopin_otg_from_buckboost()) {
		vbus_ch_close(VBUS_CH_USER_PD, VBUS_CH_TYPE_POGOPIN_BOOST,
			true, false);
	} else {
		pd_dpm_set_ignore_vbusoff_event(true);
		pd_dpm_set_source_sink_state(STOP_SOURCE);
	}
#else
	pd_dpm_set_ignore_vbusoff_event(true);
	pd_dpm_set_source_sink_state(STOP_SOURCE);
#endif
	pd_dpm_vbus_notifier_call(di, CHARGER_TYPE_NONE, NULL);
}
#endif /* CONFIG_WIRELESS_CHARGER */

/* fix the problem of OTG output still valid when OTG is pluging out */
#if defined(CONFIG_TCPC_CLASS) || defined(CONFIG_HW_TCPC_CLASS)
static void pd_dpm_vbus_ctrl_detached(struct pd_dpm_info *di,
	unsigned long event)
{
	int typec_state = PD_DPM_USB_TYPEC_DETACHED;

	if (!di)
		return;

	pd_dpm_get_typec_state(&typec_state);
	if ((event != PLEASE_PROVIDE_POWER) ||
		(typec_state != PD_DPM_USB_TYPEC_DETACHED) ||
		pd_dpm_get_audio_power_no_hs_state())
		return;

	hwlog_err("typec is detached, should cut off otg output\n");
	pd_dpm_vbus_ch_close(di);
}

/* event: CHARGER_TYPE_NONE, PLEASE_PROVIDE_POWER */
void pd_dpm_vbus_ctrl(unsigned long event)
{
	struct pd_dpm_info *di = g_pd_di;
	int typec_state = PD_DPM_USB_TYPEC_DETACHED;

	if (!di) {
		hwlog_err("di is null\n");
		return;
	}

	pd_dpm_get_typec_state(&typec_state);
	if ((typec_state == PD_DPM_USB_TYPEC_DETACHED) &&
		!pd_dpm_get_audio_power_no_hs_state()) {
		hwlog_info("%s typec unattached\n", __func__);
		return;
	}

	if (event == PLEASE_PROVIDE_POWER)
		pd_dpm_vbus_ch_open(di);
	else
		pd_dpm_vbus_ch_close(di);

	pd_dpm_vbus_ctrl_detached(di, event);
	hwlog_info("%s event = %ld\n", __func__, event);
}
#endif

int pd_dpm_ocp_nb_call(struct notifier_block *ocp_nb,
	unsigned long event, void *data)
{
	struct pd_dpm_info *di =
		container_of(ocp_nb, struct pd_dpm_info, ocp_nb);
	static unsigned int count;

	if (!di || !data || !di->pd_reinit_enable)
		return 0;

	if (strncmp(di->ldo_name, (char *)data, LDO_NAME_SIZE - 1))
		return 0;

	if (count > di->max_ocp_count)
		return 0;

	count++;

	if (!di->vdd_ocp_lock.active)
		__pm_stay_awake(&di->vdd_ocp_lock);

	schedule_delayed_work(&di->reinit_pd_work, msecs_to_jiffies(di->ocp_delay_time));
	return 0;
}

int register_pd_wake_unlock_notifier(struct notifier_block *nb)
{
	int ret;

	if (!nb)
		return -EINVAL;

	if (!g_pd_di)
		return 0;

	ret = atomic_notifier_chain_register(&g_pd_di->pd_wake_unlock_evt_nh, nb);
	if (ret != 0)
		return ret;

	return ret;
}
EXPORT_SYMBOL(register_pd_wake_unlock_notifier);

int unregister_pd_wake_unlock_notifier(struct notifier_block *nb)
{
	return atomic_notifier_chain_unregister(&g_pd_di->pd_wake_unlock_evt_nh, nb);
}
EXPORT_SYMBOL(unregister_pd_wake_unlock_notifier);

int register_pd_dpm_notifier(struct notifier_block *nb)
{
	int ret;

	if (!nb)
		return -EINVAL;

	if (!g_pd_di)
		return 0;

	ret = blocking_notifier_chain_register(&g_pd_di->pd_evt_nh, nb);
	if (ret != 0)
		return ret;

	return ret;
}
EXPORT_SYMBOL(register_pd_dpm_notifier);

int unregister_pd_dpm_notifier(struct notifier_block *nb)
{
	return blocking_notifier_chain_unregister(&g_pd_di->pd_evt_nh, nb);
}
EXPORT_SYMBOL(unregister_pd_dpm_notifier);

int register_pd_dpm_portstatus_notifier(struct notifier_block *nb)
{
	int ret = -1;

	if (!nb)
		return -EINVAL;

	if (!g_pd_di)
		return ret;

	ret = blocking_notifier_chain_register(&g_pd_di->pd_port_status_nh, nb);
	if (ret != 0)
		return ret;

	return ret;
}
EXPORT_SYMBOL(register_pd_dpm_portstatus_notifier);

int unregister_pd_dpm_portstatus_notifier(struct notifier_block *nb)
{
	return blocking_notifier_chain_unregister(&g_pd_di->pd_port_status_nh, nb);
}
EXPORT_SYMBOL(unregister_pd_dpm_portstatus_notifier);

static inline void pd_dpm_report_device_attach(void)
{
	hwlog_info("%s \r\n", __func__);
}

static inline void pd_dpm_report_host_attach(void)
{
	hwlog_info("%s \r\n", __func__);

#ifdef CONFIG_SWITCH_FSA9685
	if (switch_manual_enable) {
		usbswitch_common_dcd_timeout_enable(true);
		usbswitch_common_manual_sw(FSA9685_USB1_ID_TO_IDBYPASS);
	}
#endif /* CONFIG_SWITCH_FSA9685 */

	uvdm_init_work();
}

static inline void pd_dpm_report_device_detach(void)
{
	hwlog_info("%s \r\n", __func__);
}

static inline void pd_dpm_report_host_detach(void)
{
	hwlog_info("%s \r\n", __func__);

#ifdef CONFIG_SWITCH_FSA9685
	usbswitch_common_dcd_timeout_enable(false);
#endif /* CONFIG_SWITCH_FSA9685 */

	uvdm_cancel_work();
}

static void pd_dpm_report_attach(int new_state)
{
	switch (new_state) {
	case PD_DPM_USB_TYPEC_DEVICE_ATTACHED:
		pd_dpm_report_device_attach();
		break;
	case PD_DPM_USB_TYPEC_HOST_ATTACHED:
		pd_dpm_report_host_attach();
		break;
	default:
		break;
	}
}

static void pd_dpm_report_detach(int last_state)
{
	switch (last_state) {
	case PD_DPM_USB_TYPEC_DEVICE_ATTACHED:
		pd_dpm_report_device_detach();
		break;
	case PD_DPM_USB_TYPEC_HOST_ATTACHED:
		pd_dpm_report_host_detach();
		break;
	default:
		break;
	}
}

static void pd_dpm_usb_update_state(struct work_struct *work)
{
	int new_ev, last_ev;
	struct pd_dpm_info *usb_cb_data = container_of(to_delayed_work(work),
		struct pd_dpm_info, usb_state_update_work);

	mutex_lock(&usb_cb_data->usb_lock);
	new_ev = usb_cb_data->pending_usb_event;
	mutex_unlock(&usb_cb_data->usb_lock);
	last_ev = usb_cb_data->last_usb_event;
	if (last_ev == new_ev)
		return;

	switch (new_ev) {
	case PD_DPM_USB_TYPEC_DETACHED:
		pd_dpm_report_detach(last_ev);
		break;
	case PD_DPM_USB_TYPEC_DEVICE_ATTACHED:
	case PD_DPM_USB_TYPEC_HOST_ATTACHED:
		if (last_ev != PD_DPM_USB_TYPEC_DETACHED)
			pd_dpm_report_detach(last_ev);
		pd_dpm_report_attach(new_ev);
		break;
	default:
		return;
	}

	usb_cb_data->last_usb_event = new_ev;
}
int pd_dpm_get_cur_usb_event(void)
{
	if (g_pd_di)
		return g_pd_di->cur_usb_event;

	return 0;
}

bool pd_dpm_get_cc_moisture_status(void)
{
	return g_pd_cc_moisture_status;
}

void pd_dpm_handle_abnomal_change(int event)
{
	int i;
	char dsm_buf[PD_DPM_CC_DMD_BUF_SIZE] = {0};
	int time_diff;
	unsigned int time_diff_index;
	unsigned int flag;
	struct timespec64 ts64_interval;
	struct timespec64 ts64_now;
	struct timespec64 ts64_sum;

	struct timespec64 ts64_dmd_interval;
	struct timespec64 ts64_dmd_now;
	struct timespec64 ts64_dmd_sum;

	int* change_counter = &abnomal_change[event].change_counter;
	int change_counter_threshold = PD_DPM_CC_CHANGE_COUNTER_THRESHOLD;
	int* dmd_counter = &abnomal_change[event].dmd_counter;
	int dmd_counter_threshold = PD_DPM_CC_DMD_COUNTER_THRESHOLD;
	ts64_interval.tv_sec = 0;
	ts64_interval.tv_nsec = abnormal_cc_interval * NSEC_PER_MSEC;
	ts64_dmd_interval.tv_sec = PD_DPM_CC_DMD_INTERVAL;
	ts64_dmd_interval.tv_nsec = 0;

	ts64_now = current_kernel_time64();
	if (abnomal_change[event].first_enter) {
		abnomal_change[event].first_enter = false;
	} else {
		ts64_sum = timespec64_add_safe(abnomal_change[event].ts64_last, ts64_interval);
		if (ts64_sum.tv_sec == TIME_T_MAX) {
			hwlog_err("%s time overflow happend\n", __func__);
			*change_counter = 0;
		} else if (timespec64_compare(&ts64_sum, &ts64_now) >= 0) {
			++*change_counter;
			hwlog_info("%s change_counter = %d\n", __func__, *change_counter);

			time_diff = (ts64_now.tv_sec - abnomal_change[event].ts64_last.tv_sec) *
				PD_DPM_CC_CHANGE_MSEC +
				(ts64_now.tv_nsec - abnomal_change[event].ts64_last.tv_nsec) /
				NSEC_PER_MSEC;
			time_diff_index = time_diff / (PD_DPM_CC_CHANGE_INTERVAL /
				PD_DPM_CC_CHANGE_BUF_SIZE);
			if (time_diff_index >= PD_DPM_CC_CHANGE_BUF_SIZE)
				time_diff_index = PD_DPM_CC_CHANGE_BUF_SIZE - 1;
			++abnomal_change[event].change_data[time_diff_index];
		} else {
			*change_counter = 0;
			memset(abnomal_change[event].change_data, 0, PD_DPM_CC_CHANGE_BUF_SIZE);
		}
	}

	if (*change_counter >= change_counter_threshold) {
		hwlog_err("%s change_counter hit\n", __func__);

		if (cc_moisture_status_report) {
			g_pd_cc_moisture_happened = true;
			g_pd_cc_moisture_status = true;
		}

		pd_dpm_set_cc_mode(PD_DPM_CC_MODE_UFP);

		for (i = 0; i < PD_DPM_CC_CHANGE_BUF_SIZE; i++)
			abnomal_change[event].dmd_data[i] += abnomal_change[event].change_data[i];

		*change_counter = 0;
		memset(abnomal_change[event].change_data, 0, PD_DPM_CC_CHANGE_BUF_SIZE);
		++*dmd_counter;

		if (moisture_detection_by_cc_enable) {
			hwlog_err("%s moisture_detected\n", __func__);
			flag = WD_NON_STBY_MOIST;
			power_event_bnc_notify(POWER_BNT_WD, POWER_NE_WD_REPORT_UEVENT, &flag);
		}
	}

	if ((*dmd_counter >= dmd_counter_threshold) && g_cc_abnormal_dmd_report_enable) {
		*dmd_counter = 0;

		ts64_dmd_now = current_kernel_time64();
		ts64_dmd_sum = timespec64_add_safe(abnomal_change[event].ts64_dmd_last,
			ts64_dmd_interval);
		if (ts64_dmd_sum.tv_sec == TIME_T_MAX) {
			hwlog_err("%s time overflow happend when add 24 hours\n", __func__);
		} else if (timespec64_compare(&ts64_dmd_sum, &ts64_dmd_now) < 0) {
			snprintf(dsm_buf, PD_DPM_CC_DMD_BUF_SIZE - 1, "cc abnormal is triggered:");
			for (i = 0; i < PD_DPM_CC_CHANGE_BUF_SIZE; i++)
				snprintf(dsm_buf + strlen(dsm_buf), PD_DPM_CC_DMD_BUF_SIZE - 1,
					" %d", abnomal_change[event].dmd_data[i]);

			snprintf(dsm_buf + strlen(dsm_buf), PD_DPM_CC_DMD_BUF_SIZE - 1, "\n");

			power_dsm_report_dmd(POWER_DSM_BATTERY,
				ERROR_NO_WATER_CHECK_IN_USB, dsm_buf);

			abnomal_change[event].ts64_dmd_last = ts64_dmd_now;
		} else {
			hwlog_info("error: cc abnormal happend within 24 hour, do not report\n");
		}
	}

	abnomal_change[event].ts64_last =  ts64_now;
}
void pd_dpm_ignore_vbus_only_event(bool flag)
{
	g_ignore_vbus_only_event = flag;
}

enum cur_cap pd_dpm_get_cvdo_cur_cap(void)
{
	enum cur_cap cap;

	cap = (g_pd_di->cable_vdo & CABLE_CUR_CAP_MASK) >> CABLE_CUR_CAP_SHIFT;
	hwlog_info("%s, cur_cap = %d\n", __func__, cap);

	return cap;
}

static bool pd_dpm_is_cc_protection(void)
{
	/* cc_dynamic_protect-0: disabled 1: only SC; 2: for SC and LVC */
	if (!cc_dynamic_protect)
		return false;

#ifdef CONFIG_DIRECT_CHARGER
	if (direct_charge_in_charging_stage() != DC_IN_CHARGING_STAGE)
		return false;
#endif /* CONFIG_DIRECT_CHARGER */

	if (!pd_dpm_check_cc_vbus_short())
		return false;

	hwlog_info("cc short\n");
	return true;
}

static void pd_dpm_cc_short_action(void)
{
#ifdef CONFIG_DIRECT_CHARGER
	int mode = direct_charge_get_working_mode();

	/* cc_dynamic_protect-0: disabled 1: only SC; 2: for SC and LVC */
	if (mode == SC4_MODE)
		power_event_anc_notify(POWER_ANT_SC4_FAULT, POWER_NE_DC_FAULT_CC_SHORT, NULL);
	else if (mode == SC_MODE)
		power_event_anc_notify(POWER_ANT_SC_FAULT, POWER_NE_DC_FAULT_CC_SHORT, NULL);
	else if (mode == LVC_MODE && cc_dynamic_protect == 2)
		power_event_anc_notify(POWER_ANT_LVC_FAULT, POWER_NE_DC_FAULT_CC_SHORT, NULL);
#endif /* CONFIG_DIRECT_CHARGER */
	hwlog_info("cc_short_action\n");
}

static void pd_dpm_reinit_pd_work(struct work_struct *work)
{
	struct pd_dpm_info *di =
		container_of(work, struct pd_dpm_info, reinit_pd_work.work);

	if (!di)
		return;
	hwlog_info("pd_dpm_reinit_pd_work start\n");

	di->is_ocp = true;
	if (di->vdd_ocp_lock.active)
		__pm_relax(&di->vdd_ocp_lock);

	(void)regulator_disable(di->pd_vdd_ldo);
	msleep(DISABLE_INTERVAL);
	(void)regulator_enable(di->pd_vdd_ldo);
	pd_dpm_reinit_chip();
	di->is_ocp = false;
	hwlog_info("pd_dpm_reinit_pd_work end\n");
}

static void pd_dpm_cc_short_work(struct work_struct *work)
{
	hwlog_info("cc_short_work\n");
	if (!pd_dpm_is_cc_protection())
		return;

	pd_dpm_cc_short_action();
}

static void pd_dpm_otg_restore_work(struct work_struct *work)
{
	struct pd_dpm_info *di = g_pd_di;

	if (!di)
		return;

	pd_dpm_vbus_ch_close(di);
}

void pd_dpm_cc_dynamic_protect(void)
{
	if (!pd_dpm_is_cc_protection())
		return;

	mod_delayed_work(system_wq, &cc_short_work,
		msecs_to_jiffies(CC_SHORT_DEBOUNCE));
}

#ifdef CONFIG_POGO_PIN
bool pogo_charger_ignore_typec_event(unsigned long event)
{
	return ((pogopin_5pin_get_pogo_status() == POGO_CHARGER) &&
		((event != PD_DPM_PE_EVT_TYPEC_STATE) &&
		(event != PD_DPM_PE_ABNORMAL_CC_CHANGE_HANDLER))) ?
		true : false;
}

bool pogo_otg_ignore_typec_event(unsigned long event)
{
	return ((event == PD_DPM_PE_EVT_SOURCE_VBUS) ||
		(event == PD_DPM_PE_EVT_SOURCE_VCONN) ||
		(event == PD_DPM_PE_EVT_DR_SWAP) ||
		(event == PD_DPM_PE_EVT_PR_SWAP) ||
		(event == PD_DPM_PE_CABLE_VDO)) ? true : false;
}

bool ana_audio_event(struct pd_dpm_typec_state *typec_state)
{
	if (!typec_state)
		return false;

	return ((typec_state->new_state == PD_DPM_TYPEC_ATTACHED_AUDIO) ||
		((typec_state->new_state == PD_DPM_TYPEC_UNATTACHED) &&
		(g_pd_di->cur_usb_event == PD_DPM_TYPEC_ATTACHED_AUDIO))) ?
		true : false;
}

bool pogo_otg_typec_snk_event(struct pd_dpm_typec_state *typec_state)
{
	if (!typec_state)
		return false;

	return (((typec_state->new_state == PD_DPM_TYPEC_ATTACHED_SNK) ||
		((typec_state->new_state == PD_DPM_TYPEC_UNATTACHED) &&
		(g_pd_di->cur_usb_event == PD_DPM_TYPEC_ATTACHED_SNK))) &&
		(pogopin_5pin_get_pogo_status() == POGO_OTG)) ? true : false;
}

bool pogopin_ignore_typec_event(unsigned long event, void *data)
{
	struct pd_dpm_typec_state *typec_state = NULL;

	if (!pogopin_typec_chg_ana_audio_suport() ||
		(pogopin_5pin_get_pogo_status() == POGO_NONE) ||
		!data)
		return false;

	if (pogo_charger_ignore_typec_event(event)) {
		return true;
	} else if ((pogopin_5pin_get_pogo_status() == POGO_OTG) &&
		(event != PD_DPM_PE_EVT_TYPEC_STATE)) {
		if (pogo_otg_ignore_typec_event(event))
			return true;
		else
			return false;
	}

	typec_state = data;

	return (ana_audio_event(typec_state) ||
		pogo_otg_typec_snk_event(typec_state)) ? false : true;
}
#endif

int pd_dpm_handle_pe_event(unsigned long event, void *data)
{
	int usb_event = PD_DPM_USB_TYPEC_NONE;
	struct pd_dpm_typec_state *typec_state = NULL;
	bool notify_audio = false;
	struct pd_dpm_swap_state *swap_state = data;

	if (!g_pd_di) {
		hwlog_err("%s g_pd_di is null\n", __func__);
		return -1;
	}

#ifdef CONFIG_POGO_PIN
	if (pogopin_ignore_typec_event(event, data)) {
		hwlog_info("pogo inset device ignore typec event:%d", event);
		return 0;
	}
#endif

	switch (event) {
	case PD_DPM_PE_ABNORMAL_CC_CHANGE_HANDLER:
		if (abnormal_cc_detection &&
			(direct_charge_get_stage_status() < DC_STAGE_CHARGE_INIT))
			pd_dpm_handle_abnomal_change(PD_DPM_ABNORMAL_CC_CHANGE);

		return 0;
	case PD_DPM_PE_EVT_TYPEC_STATE:
		{
			if (!data || !g_pd_di) {
				hwlog_info("%s data is null\r\n", __func__);
				return -1;
			}

			typec_state = data;
			if (!support_analog_audio && (typec_state->new_state == PD_DPM_TYPEC_ATTACHED_AUDIO)) {
				hwlog_err("%s does not support analog audio\n", __func__);
				return -1;
			}
			g_pd_di->cur_usb_event = typec_state->new_state;
			g_pd_cc_orientation_factory =
				CC_ORIENTATION_FACTORY_UNSET;
			switch (typec_state->new_state) {
			case PD_DPM_TYPEC_ATTACHED_SNK:
				usb_event = PD_DPM_USB_TYPEC_DEVICE_ATTACHED;
				hwlog_info("%s ATTACHED_SINK\r\n", __func__);
				pd_dpm_set_source_sink_state(START_SINK);
				break;
			case PD_DPM_TYPEC_ATTACHED_SRC:
				usb_event = PD_DPM_USB_TYPEC_HOST_ATTACHED;
				hwlog_info("%s ATTACHED_SOURCE\r\n", __func__);
				break;
			case PD_DPM_TYPEC_UNATTACHED:
				g_pd_di->ctc_cable_flag = false;
				pd_dpm_set_optional_max_power_status(false);
				/* the sequence can not change, would affect sink_vbus command */
				if (pd_dpm_analog_hs_state == 1) {
					usb_event = PD_DPM_USB_TYPEC_AUDIO_DETACHED;
					notify_audio = true;
					pd_dpm_analog_hs_state = 0;
					if (g_pd_di->pd_reinit_enable &&
						g_pd_di->is_ocp &&
						g_pd_di->pd_vdd_ldo)
						notify_audio = false;
					hwlog_info("%s AUDIO UNATTACHED\r\n", __func__);
				} else {
					usb_event = PD_DPM_USB_TYPEC_DETACHED;
					if (sink_source_type == START_SINK)
						pd_dpm_set_source_sink_state(STOP_SINK);

					hwlog_info("%s UNATTACHED\r\n", __func__);
				}
#ifdef CONFIG_TYPEC_CAP_CUSTOM_SRC2
				if (support_smart_holder)
					g_pd_smart_holder = false;
#endif /* CONFIG_TYPEC_CAP_CUSTOM_SRC2 */
				g_pd_cc_orientation_factory = CC_ORIENTATION_FACTORY_SET;
				pd_set_product_type(PD_DPM_INVALID_VAL);
				g_pd_di->cable_vdo = 0;
				break;
			case PD_DPM_TYPEC_ATTACHED_AUDIO:
				notify_audio = true;
				pd_dpm_analog_hs_state = 1;
				usb_event = PD_DPM_USB_TYPEC_AUDIO_ATTACHED;
				hwlog_info("%s ATTACHED_AUDIO\r\n", __func__);
				break;
			case PD_DPM_TYPEC_ATTACHED_DBGACC_SNK:
			case PD_DPM_TYPEC_ATTACHED_CUSTOM_SRC:
				usb_event = PD_DPM_USB_TYPEC_DEVICE_ATTACHED;
				pd_dpm_set_source_sink_state(START_SINK);
				pd_dpm_set_cc_voltage(PD_DPM_CC_VOLT_SNK_DFT);
				hwlog_info("%s ATTACHED_CUSTOM_SRC\r\n", __func__);
				break;
#ifdef CONFIG_TYPEC_CAP_CUSTOM_SRC2
			case PD_DPM_TYPEC_ATTACHED_CUSTOM_SRC2:
				if (support_smart_holder) {
					usb_event = PD_DPM_USB_TYPEC_DEVICE_ATTACHED;
					hwlog_info("%s ATTACHED_CUSTOM_SRC2\r\n", __func__);
					if (g_cable_vdo_ops && g_cable_vdo_ops->is_cust_src2_cable()) {
						if (!g_pd_smart_holder)
							hishow_notify_android_uevent(HISHOW_DEVICE_ONLINE,
								HISHOW_USB_DEVICE);

						g_pd_smart_holder = true;
					}
				}
				break;
#endif /* CONFIG_TYPEC_CAP_CUSTOM_SRC2 */
			case PD_DPM_TYPEC_ATTACHED_DEBUG:
				pd_dpm_set_cc_voltage(PD_DPM_CC_VOLT_SNK_DFT);
				break;
			case PD_DPM_TYPEC_ATTACHED_VBUS_ONLY:
				g_pd_cc_orientation_factory =
					CC_ORIENTATION_FACTORY_SET;
				if (g_ignore_vbus_only_event) {
					hwlog_err("%s: ignore ATTACHED_VBUS_ONLY\n", __func__);
					return 0;
				}
				pd_dpm_set_source_sink_state(START_SINK);
				usb_event = PD_DPM_USB_TYPEC_DEVICE_ATTACHED;
				hwlog_info("%s ATTACHED_VBUS_ONLY\r\n", __func__);
				break;
			case PD_DPM_TYPEC_UNATTACHED_VBUS_ONLY:
				g_pd_cc_orientation_factory =
					CC_ORIENTATION_FACTORY_SET;
				hwlog_info("%s UNATTACHED_VBUS_ONLY\r\n", __func__);
				pd_dpm_handle_abnomal_change(PD_DPM_UNATTACHED_VBUS_ONLY);
				usb_event = PD_DPM_USB_TYPEC_DETACHED;
				pd_dpm_set_source_sink_state(STOP_SINK);
				break;
			default:
				hwlog_info("%s can not detect typec state\r\n", __func__);
				break;
			}
			pd_dpm_set_typec_state(usb_event);

			if (typec_state->polarity)
				pd_dpm_set_cc_orientation(true);
			else
				pd_dpm_set_cc_orientation(false);
		}
		break;
	case PD_DPM_PE_EVT_PD_STATE:
		{
			struct pd_dpm_pd_state *pd_state = data;
			switch (pd_state->connected) {
			case PD_CONNECT_PE_READY_SNK:
			case PD_CONNECT_PE_READY_SRC:
				break;
			default:
				break;
			}
		}
		break;
	case PD_DPM_PE_EVT_DIS_VBUS_CTRL:
		hwlog_info("%s : Disable VBUS Control  first \n", __func__);

		if (g_pd_di->pd_finish_flag == true || pd_dpm_get_pd_source_vbus()) {
			struct pd_dpm_vbus_state vbus_state;
			hwlog_info("%s : Disable VBUS Control\n", __func__);
			vbus_state.mv = 0;
			vbus_state.ma = 0;
			if (g_otg_channel && g_pd_di->pd_source_vbus) {
				vbus_ch_close(VBUS_CH_USER_PD,
					VBUS_CH_TYPE_BOOST_GPIO, true, false);
#ifdef CONFIG_POGO_PIN
			} else if (pogopin_is_support() &&
				(pogopin_otg_from_buckboost() == true) &&
				g_pd_di->pd_source_vbus) {
				vbus_ch_close(VBUS_CH_USER_PD,
					VBUS_CH_TYPE_POGOPIN_BOOST, true, false);
#endif /* CONFIG_POGO_PIN */
			} else {
				pd_dpm_vbus_notifier_call(g_pd_di,
					CHARGER_TYPE_NONE, &vbus_state);
				if (g_pd_di->pd_source_vbus)
					pd_dpm_set_source_sink_state(STOP_SOURCE);
				else
					pd_dpm_set_source_sink_state(STOP_SINK);
			}

			mutex_lock(&g_pd_di->sink_vbus_lock);
			if (g_pd_di->bc12_event != CHARGER_TYPE_NONE)
				ignore_bc12_event_when_vbusoff = true;

			ignore_bc12_event_when_vbuson = false;
			g_pd_di->pd_source_vbus = false;
			g_pd_di->pd_finish_flag = false;
			mutex_unlock(&g_pd_di->sink_vbus_lock);
		}
		break;
	case PD_DPM_PE_EVT_SINK_VBUS:
		pd_dpm_report_pd_sink_vbus(g_pd_di, data);
		break;
	case PD_DPM_PE_EVT_SOURCE_VBUS:
		pd_dpm_report_pd_source_vbus(g_pd_di, data);
		break;
	case PD_DPM_PE_EVT_SOURCE_VCONN:
		pd_dpm_report_pd_source_vconn(data);
		break;
	case PD_DPM_PE_EVT_DR_SWAP:
		if (swap_state->new_role == PD_ROLE_DFP)
			usb_event = PD_DPM_USB_TYPEC_HOST_ATTACHED;
		else
			usb_event = PD_DPM_USB_TYPEC_DEVICE_ATTACHED;
		pd_dpm_set_typec_state(usb_event);
		break;
	case PD_DPM_PE_EVT_PR_SWAP:
		break;
	case PD_DPM_PE_CABLE_VDO:
		if (!data)
			return 0;

		memcpy(&g_pd_di->cable_vdo, data, sizeof(g_pd_di->cable_vdo));
		hwlog_info("%s cable_vdo=%u\n", __func__, g_pd_di->cable_vdo);
		break;
	default:
		hwlog_info("%s  unkonw event \r\n", __func__);
		break;
	};

	if (usb_event != PD_DPM_USB_TYPEC_NONE) {
		mutex_lock(&g_pd_di->usb_lock);
		if (g_pd_di->pending_usb_event != usb_event) {
			cancel_delayed_work(&g_pd_di->usb_state_update_work);
			g_pd_di->pending_usb_event = usb_event;
			queue_delayed_work(g_pd_di->usb_wq, &g_pd_di->usb_state_update_work,
				msecs_to_jiffies(0));
		} else {
			pr_info("Pending event is same --> ignore this event %d\n", usb_event);
		}
		mutex_unlock(&g_pd_di->usb_lock);
	}

	return 0;
}
EXPORT_SYMBOL_GPL(pd_dpm_handle_pe_event);

int pd_dpm_get_otg_channel(void)
{
#ifdef CONFIG_POGO_PIN
	if (pogopin_is_support() &&
		(pogopin_otg_from_buckboost() == true))
		return POGOPIN_OTG_CHANNEL;
#endif

	return g_otg_channel;
}

static void pd_cc_protection_dts_parser(struct pd_dpm_info *di, struct device_node *np)
{
	(void)power_dts_read_u32(power_dts_tag(HWLOG_TAG), np,
		"abnormal_cc_detection", &abnormal_cc_detection, 0);
	(void)power_dts_read_u32(power_dts_tag(HWLOG_TAG), np,
		"cc_dynamic_protect", &cc_dynamic_protect, 0);
	(void)power_dts_read_u32(power_dts_tag(HWLOG_TAG), np,
		"abnormal_cc_interval", &abnormal_cc_interval, PD_DPM_CC_CHANGE_INTERVAL);
	(void)power_dts_read_u32(power_dts_tag(HWLOG_TAG), np,
		"moisture_detection_by_cc_enable", &moisture_detection_by_cc_enable, 0);
	(void)power_dts_read_u32(power_dts_tag(HWLOG_TAG), np,
		"cc_moisture_status_report", &cc_moisture_status_report, 0);
	(void)power_dts_read_u32(power_dts_tag(HWLOG_TAG), np,
		"cc_abnormal_dmd_report_enable", &g_cc_abnormal_dmd_report_enable, 1);
}

static void pd_misc_dts_parser(struct pd_dpm_info *di, struct device_node *np)
{
	(void)power_dts_read_u32(power_dts_tag(HWLOG_TAG), np,
		"switch_manual_enable", &switch_manual_enable, 1);
	(void)power_dts_read_u32(power_dts_tag(HWLOG_TAG), np,
		"support_dp", &support_dp, 1);
	(void)power_dts_read_u32(power_dts_tag(HWLOG_TAG), np,
		"otg_channel", &g_otg_channel, 0);
}

static void pd_accessory_dts_parser(struct pd_dpm_info *di, struct device_node *np)
{
#ifdef CONFIG_TYPEC_CAP_CUSTOM_SRC2
	(void)power_dts_read_u32(power_dts_tag(HWLOG_TAG), np,
		"support_smart_holder", &support_smart_holder, 0);
#endif /* CONFIG_TYPEC_CAP_CUSTOM_SRC2 */
	(void)power_dts_read_u32(power_dts_tag(HWLOG_TAG), np,
		"support_analog_audio", &support_analog_audio, 1);
	(void)power_dts_read_u32(power_dts_tag(HWLOG_TAG), np,
		"emark_detect_enable", &emark_detect_enable, 1);
	if (power_dts_read_string(power_dts_tag(HWLOG_TAG), np, "tcp_name", &di->tcpc_name))
		di->tcpc_name = "type_c_port0";
}

static int pd_reinit_dts_parser(struct pd_dpm_info *di, struct device_node *np)
{
	if (power_dts_read_u32(power_dts_tag(HWLOG_TAG), np,
		"pd_reinit_enable", &di->pd_reinit_enable, 0))
		return -EINVAL;

	if (!di->pd_reinit_enable) {
		hwlog_err("pd reinit not enable\n");
		return -EINVAL;
	}

	if (power_dts_read_string(power_dts_tag(HWLOG_TAG), np, "ldo_name", &di->ldo_name))
		return -EINVAL;

	(void)power_dts_read_u32(power_dts_tag(HWLOG_TAG), np,
		"max_ocp_count", &di->max_ocp_count, PD_DPM_MAX_OCP_COUNT);
	(void)power_dts_read_u32(power_dts_tag(HWLOG_TAG), np,
		"ocp_delay_time", &di->ocp_delay_time, OCP_DELAY_TIME);

	return 0;
}

static void pd_dpm_parse_dts(struct pd_dpm_info *di, struct device_node *np)
{
	if (!di || !np) {
		hwlog_err("di or np is null\n");
		return;
	}

	pd_cc_protection_dts_parser(di, np);
	pd_misc_dts_parser(di, np);
	pd_accessory_dts_parser(di, np);
	hwlog_info("parse_dts success\n");
}

static void pd_reinit_process(struct pd_dpm_info *di, struct device_node *np)
{
	if (pd_reinit_dts_parser(di, np))
		return;

	di->pd_vdd_ldo = devm_regulator_get(di->dev, "pd_vdd");
	if (IS_ERR(di->pd_vdd_ldo)) {
		hwlog_err("get pd vdd ldo failed\n");
		return;
	}

	(void)regulator_enable(di->pd_vdd_ldo);
	wakeup_source_init(&di->vdd_ocp_lock, "vdd_ocp_lock");
	INIT_DELAYED_WORK(&di->reinit_pd_work, pd_dpm_reinit_pd_work);
	di->ocp_nb.notifier_call = pd_dpm_ocp_nb_call;
}

static void pd_dpm_init_default_value(struct pd_dpm_info *di)
{
	di->last_usb_event = PD_DPM_USB_TYPEC_NONE;
	di->pending_usb_event = PD_DPM_USB_TYPEC_NONE;
}

static void pd_dpm_init_resource(struct pd_dpm_info *di)
{

	mutex_init(&di->sink_vbus_lock);
	mutex_init(&di->usb_lock);
	mutex_init(&typec_state_lock);
	mutex_init(&typec_wait_lock);

	BLOCKING_INIT_NOTIFIER_HEAD(&di->pd_evt_nh);
	BLOCKING_INIT_NOTIFIER_HEAD(&di->pd_port_status_nh);
	ATOMIC_INIT_NOTIFIER_HEAD(&di->pd_wake_unlock_evt_nh);

	di->chrg_wake_unlock_nb.notifier_call = charge_wake_unlock_notifier_call;
#ifdef CONFIG_HUAWEI_CHARGER_AP
	int ret;
	ret = blocking_notifier_chain_register(&charge_wake_unlock_list, &di->chrg_wake_unlock_nb);
	if (ret < 0)
		hwlog_err("charge_wake_unlock_register_notifier failed\n");
#endif
	typec_dev = power_sysfs_create_group("hw_typec", "typec", &pd_dpm_attr_group);

	di->usb_wq = create_workqueue("pd_dpm_usb_wq");
	INIT_DELAYED_WORK(&di->usb_state_update_work, pd_dpm_usb_update_state);
	INIT_DELAYED_WORK(&di->cc_moisture_flag_restore_work, pd_dpm_cc_moisture_flag_restore);
	INIT_DELAYED_WORK(&cc_short_work, pd_dpm_cc_short_work);
	init_completion(&pd_get_typec_state_completion);
	/* use for board rt test */
	INIT_DELAYED_WORK(&di->otg_restore_work, pd_dpm_otg_restore_work);
	INIT_WORK(&g_pd_di->fb_work, fb_unblank_work);

	if (abnormal_cc_detection)
		init_fb_notification();
}

static int pd_set_rtb_success(unsigned int val)
{
	struct pd_dpm_info *di = g_pd_di;
	int typec_state = PD_DPM_USB_TYPEC_NONE;

	/* 1:set board running test result success */
	if (!di || (val <= 0))
		return -1;

	if (!power_cmdline_is_factory_mode())
		return 0;

	pd_dpm_get_typec_state(&typec_state);
	if (typec_state == PD_DPM_USB_TYPEC_HOST_ATTACHED ||
		typec_state == PD_DPM_USB_TYPEC_DEVICE_ATTACHED ||
		typec_state == PD_DPM_USB_TYPEC_AUDIO_ATTACHED) {
		hwlog_err("typec port is attached, can not open vbus\n");
		return -1;
	}

	pd_dpm_vbus_ch_open(di);
	cancel_delayed_work_sync(&di->otg_restore_work);
	/* 1000: delay val*1000 ms */
	schedule_delayed_work(&di->otg_restore_work,
		msecs_to_jiffies(val * 1000));
	return 0;
}

static struct power_if_ops pd_if_ops = {
	.set_rtb_success = pd_set_rtb_success,
	.type_name = "pd",
};

static int pd_dpm_probe(struct platform_device *pdev)
{
	struct pd_dpm_info *di = NULL;
	struct device_node *np = NULL;
	enum hisi_charger_type type;

	hwlog_info("%s begin\n", __func__);
	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
	if (!di)
		return -ENOMEM;

	di->dev = &pdev->dev;
	np = di->dev->of_node;
	g_pd_di = di;

	platform_set_drvdata(pdev, di);
	pd_dpm_init_default_value(di);
	pd_dpm_parse_dts(di, np);
	pd_dpm_init_resource(di);
	di->bc12_event = type;
	dc_cable_ops_register(&cable_detect_ops);
	pd_reinit_process(di, np);
	power_if_ops_register(&pd_if_ops);

	hwlog_info("%s end\n", __func__);
	return 0;
}

static const struct of_device_id pd_dpm_callback_match_table[] = {
	{
		.compatible = "huawei,pd_dpm",
		.data = NULL,
	},
	{},
};

static struct platform_driver pd_dpm_callback_driver = {
	.probe = pd_dpm_probe,
	.remove = NULL,
	.driver = {
		.name = "huawei,pd_dpm",
		.owner = THIS_MODULE,
		.of_match_table = pd_dpm_callback_match_table,
	}
};

static int __init pd_dpm_init(void)
{
	return platform_driver_register(&pd_dpm_callback_driver);
}

static void __exit pd_dpm_exit(void)
{
	platform_driver_unregister(&pd_dpm_callback_driver);
}

module_init(pd_dpm_init);
module_exit(pd_dpm_exit);

MODULE_LICENSE("GPL v2");
MODULE_DESCRIPTION("pd dpm logic driver");
MODULE_AUTHOR("Huawei Technologies Co., Ltd.");
