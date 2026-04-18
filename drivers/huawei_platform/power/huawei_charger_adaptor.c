/*
 * huawei_charger_adaaptor.c
 *
 * huawei charger adaaptor for power module
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

#include <huawei_platform/power/huawei_charger_adaptor.h>
#include <linux/kernel.h>
#include <linux/power/huawei_charger.h>
#include <linux/power/huawei_battery.h>
#include <linux/power/charger-manager.h>
#include <linux/notifier.h>
#include <huawei_platform/log/hw_log.h>
#include <chipset_common/hwpower/common_module/power_algorithm.h>
#include <chipset_common/hwpower/common_module/power_common_macro.h>
#include <chipset_common/hwpower/common_module/power_icon.h>
#include <chipset_common/hwpower/common_module/power_ui_ne.h>
#include <chipset_common/hwpower/common_module/power_event_ne.h>
#include <chipset_common/hwpower/common_module/power_supply_interface.h>
#include <chipset_common/hwpower/common_module/power_delay.h>
#if IS_ENABLED(CONFIG_QTI_PMIC_GLINK)
#include <huawei_platform/hwpower/common_module/power_glink.h>
#endif /* IS_ENABLED(CONFIG_QTI_PMIC_GLINK) */

#define HWLOG_TAG huawei_charger_adaptor
HWLOG_REGIST();

#define DEFAULT_CAP              50

/* qcom platform type to common charge type */
struct convert_data qcom_charger_type[] = {
	{ POWER_SUPPLY_TYPE_UNKNOWN, CHARGER_REMOVED },
	{ POWER_SUPPLY_TYPE_BATTERY, CHARGER_TYPE_BATTERY },
	{ POWER_SUPPLY_TYPE_UPS, CHARGER_TYPE_UPS },
	{ POWER_SUPPLY_TYPE_MAINS, CHARGER_TYPE_MAINS },
	{ POWER_SUPPLY_TYPE_USB, CHARGER_TYPE_USB },
	{ POWER_SUPPLY_TYPE_USB_DCP, CHARGER_TYPE_STANDARD },
	{ POWER_SUPPLY_TYPE_USB_CDP, CHARGER_TYPE_BC_USB },
	{ POWER_SUPPLY_TYPE_USB_ACA, CHARGER_TYPE_ACA },
	{ POWER_SUPPLY_TYPE_USB_TYPE_C, CHARGER_TYPE_TYPEC },
	{ POWER_SUPPLY_TYPE_USB_PD, CHARGER_TYPE_PD },
	{ POWER_SUPPLY_TYPE_USB_PD_DRP, CHARGER_TYPE_PD_DRP },
	{ POWER_SUPPLY_TYPE_APPLE_BRICK_ID, CHARGER_TYPE_APPLE_BRICK_ID },
	{ POWER_SUPPLY_TYPE_USB_HVDCP, CHARGER_TYPE_HVDCP },
	{ POWER_SUPPLY_TYPE_USB_HVDCP_3, CHARGER_TYPE_HVDCP_3 },
	{ POWER_SUPPLY_TYPE_WIRELESS, CHARGER_TYPE_WIRELESS },
	{ POWER_SUPPLY_TYPE_USB_FLOAT, CHARGER_TYPE_NON_STANDARD },
	{ POWER_SUPPLY_TYPE_BMS, CHARGER_TYPE_BMS },
	{ POWER_SUPPLY_TYPE_PARALLEL, CHARGER_TYPE_PARALLEL },
	{ POWER_SUPPLY_TYPE_MAIN, CHARGER_TYPE_MAIN },
	{ POWER_SUPPLY_TYPE_UFP, CHARGER_TYPE_UFP },
	{ POWER_SUPPLY_TYPE_DFP, CHARGER_TYPE_DFP },
	{ POWER_SUPPLY_TYPE_CHARGE_PUMP, CHARGER_TYPE_CHARGE_PUMP },
#ifdef CONFIG_HUAWEI_POWER_EMBEDDED_ISOLATION
	{ POWER_SUPPLY_TYPE_FCP, CHARGER_TYPE_FCP },
	{ POWER_SUPPLY_TYPE_WIRELESS, CHARGER_TYPE_WIRELESS },
#endif
};

int get_reset_adapter(void)
{
	return 0;
}

u32 get_rt_curr_th(void)
{
	return 0;
}

void set_rt_test_result(bool flag)
{
}

void charge_send_uevent(int input_events)
{
}

void charge_request_charge_monitor(void)
{
}

#if IS_ENABLED(CONFIG_QTI_PMIC_GLINK)
static unsigned int g_type = CHARGER_REMOVED;
unsigned int converse_usb_type(unsigned int type)
{
	return type;
}

unsigned int huawei_get_charger_type(void)
{
	return g_type;
}

void huawei_set_charger_type(unsigned int type)
{
	g_type = type;
}
#else
unsigned int converse_usb_type(unsigned int type)
{
	unsigned int new_type = CHARGER_REMOVED;

	power_convert_value(qcom_charger_type, ARRAY_SIZE(qcom_charger_type),
		type, &new_type);

	return new_type;
}

unsigned int huawei_get_charger_type(void)
{
	int ret;
	unsigned int type = CHARGER_REMOVED;

	ret = power_supply_get_int_property_value("usb",
		POWER_SUPPLY_PROP_REAL_TYPE, &type);
	if (ret) {
		hwlog_err("get chg type fail\n");
		return CHARGER_REMOVED;
	}

	return converse_usb_type(type);
}

void huawei_set_charger_type(unsigned int type)
{
	power_supply_set_int_property_value("usb", POWER_SUPPLY_PROP_REAL_TYPE, type);
}
#endif /* IS_ENABLED(CONFIG_QTI_PMIC_GLINK) */

int charger_manager_notifier(struct charger_manager *info, int event)
{
	return 0;
}

void wired_connect_send_icon_uevent(int icon_type)
{
	hwlog_info("%s enter,icon_type=%d\n", __func__, icon_type);

	power_icon_notify(icon_type);
}

void wired_disconnect_send_icon_uevent(void)
{
	power_icon_notify(ICON_TYPE_INVALID);
}

int charge_enable_force_sleep(bool enable)
{
	return 0;
}

#if IS_ENABLED(CONFIG_QTI_PMIC_GLINK)
int charge_set_hiz_enable(int hz_enable)
{
	int ret;
	u32 value;
	u32 id = POWER_GLINK_PROP_ID_SET_INPUT_SUSPEND;

	if (hz_enable)
		value = 1; /* Hiz enable */
	else
		value = 0;

	ret = power_glink_set_property_value(id, &value, 1); /* 1: valid buff size */
	msleep(DT_MSLEEP_200MS);
	return ret;
}
#else
int charge_set_hiz_enable(int hz_enable)
{
	int rc;
	struct charge_device_info *di = NULL;

	di = get_charger_device_info();
	if (!di) {
		hwlog_err("%s g_di is null\n", __func__);
		return 0;
	}

	if (!power_supply_check_psy_available("battery", &di->batt_psy)) {
		hwlog_err("charge_device is not ready! cannot set runningtest\n");
		return -EINVAL;
	}

	rc = power_supply_set_int_property_value_with_psy(di->batt_psy,
		POWER_SUPPLY_PROP_HIZ_MODE, hz_enable);
	if (rc < 0)
		hwlog_err("%s enable hz fail\n", __func__);
	msleep(DT_MSLEEP_250MS);
	return rc;
}
#endif /* IS_ENABLED(CONFIG_QTI_PMIC_GLINK) */

int charge_get_done_type(void)
{
	int rc;
	union power_supply_propval val = {0, };
	struct charge_device_info *di = NULL;

	di = get_charger_device_info();
	if (!di) {
		hwlog_err("%s g_di is null\n", __func__);
		return CHARGE_DONE_NON;
	}

	rc = power_supply_get_property_value_with_psy(di->batt_psy,
		POWER_SUPPLY_PROP_CHARGE_DONE, &val);
	if (rc < 0) {
		hwlog_err("%s charge done fail\n", __func__);
		return CHARGE_DONE_NON;
	}
	return val.intval;
}

static int first_check;
int get_first_insert(void)
{
	return first_check;
}

void set_first_insert(int flag)
{
	pr_info("set insert flag %d\n", flag);
	first_check = flag;
}

int charger_dev_get_chg_state(u32 *pg_state)
{
	return 0;
}

int charger_dev_get_ibus(u32 *ibus)
{
	int rc;
	union power_supply_propval val = {0, };
	struct charge_device_info *di = NULL;

	di = get_charger_device_info();
	if (!di) {
		hwlog_err("%s g_di is null\n", __func__);
		return 0;
	}

	rc = power_supply_get_property_value_with_psy(di->usb_psy,
		POWER_SUPPLY_PROP_INPUT_CURRENT_NOW, &val);
	if (rc < 0) {
		hwlog_err("%s get vbus vol fail\n", __func__);
		return -1;
	}
	*ibus = val.intval;
	return 0;
}

signed int battery_get_bat_current(void)
{
	int rc;
	union power_supply_propval val = {0, };
	struct charge_device_info *di = NULL;

	di = get_charger_device_info();
	if (!di) {
		hwlog_err("%s g_di is null\n", __func__);
		return 0;
	}

	rc = power_supply_get_property_value_with_psy(di->batt_psy,
		POWER_SUPPLY_PROP_CURRENT_NOW, &val);
	if (rc < 0) {
		hwlog_err("%s get vbus vol fail\n", __func__);
		return 0;
	}
	return val.intval;
}

int charge_get_ibus(void)
{
	u32 ibus_curr = 0;

	(void)charger_dev_get_ibus(&ibus_curr);
	return ibus_curr / POWER_UA_PER_MA;
}

int charge_get_vusb(void)
{
	return -EINVAL;
}

int charger_dev_set_mivr(u32 uv)
{
	return 0;
}

int charger_dev_set_vbus_vset(u32 uv)
{
	return 0;
}

int charge_enable_eoc(bool eoc_enable)
{
	return 0;
}

void reset_cur_delay_eoc_count(void)
{
}

void charger_detect_init(void)
{
}

void charger_detect_release(void)
{
}

static unsigned int g_charge_time;
unsigned int get_charging_time(void)
{
	return g_charge_time;
}
