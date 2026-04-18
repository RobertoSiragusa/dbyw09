

#include <linux/input.h>
#include <linux/device.h>
#include <linux/of.h>
#include <chipset_common/hwpower/common_module/power_event_ne.h>
#include <misc/app_info.h>
#include "../sensors_class.h"

#ifdef LOG_TAG
#undef LOG_TAG
#endif

#define LOG_TAG "HALL_LOG"

#define log_info(fmt, args...)  pr_info(LOG_TAG " %s: " fmt, __func__, ##args)
#define log_debug(fmt, args...) pr_debug(LOG_TAG " %s: " fmt, __func__, ##args)
#define log_err(fmt, args...)   pr_err(LOG_TAG " %s: " fmt, __func__, ##args)
static unsigned int support_coil_switch;
static unsigned int is_support_hall_keyboard; // default no supply
static unsigned int kb_hall_value = 0x04;     // default: 0000 0100b

static unsigned int is_support_hall_pen;      // default no supply
static unsigned int pen_hall_value = 0x10;    // default: 0001 0000b

static struct input_dev *hall_input = NULL;

static struct sensors_classdev hall_cdev = {
	.name = "ak8789-hall",
	.vendor = "AKMMicroelectronics",
	.version = 1,
	.handle = SENSORS_HALL_HANDLE,
	.type = SENSOR_TYPE_HALL,
	.max_range = "3",
	.resolution = "1",
	.sensor_power = "0.002",
	.min_delay = 0,
	.delay_msec = 200,
	.fifo_reserved_event_count = 0,
	.fifo_max_event_count = 0,
	.enabled = 0,
	.sensors_enable = NULL,
	.sensors_poll_delay = NULL,
};

void get_hall_fature_config(struct device_node *node)
{
	unsigned int tmp;

	log_info("enter\n");
	if (!of_property_read_u32(node, "support_coil_switch", &tmp)) {
		support_coil_switch = tmp;
		log_info("support_coil_switch = %d\n", support_coil_switch);
	}
	if (!of_property_read_u32(node, "is_support_hall_pen", &tmp)) {
		is_support_hall_pen = tmp;
		log_info("is_support_hall_pen = %d\n", is_support_hall_pen);
	}

	if (!of_property_read_u32(node, "hall_pen_value", &tmp)) {
		pen_hall_value = tmp;
		log_info("pen_hall_value = %d\n", pen_hall_value);
	}

	if (!of_property_read_u32(node, "is_support_hall_keyboard", &tmp)) {
		is_support_hall_keyboard = tmp;
		log_info("is_support_hall_keyboard = %d\n", is_support_hall_keyboard);
	}

	if (!of_property_read_u32(node, "hall_keyboard_value", &tmp)) {
		kb_hall_value = tmp;
		log_info("kb_hall_value = %d\n", kb_hall_value);
	}
}

int hall_report_register(struct device *dev)
{
	int ret;
	struct input_dev *input_ptr = NULL;

	if ((dev == NULL) || (dev->of_node == NULL)) {
		log_err("dev or of_node is NULL\n");
		return -EINVAL;
	}

	get_hall_fature_config(dev->of_node);

	input_ptr = input_allocate_device();
	if (IS_ERR_OR_NULL(input_ptr)) {
		ret = PTR_ERR(input_ptr);
		log_err("input alloc fail, ret = %ld\n", ret);
		return ret;
	}

	input_ptr->name = "hall";
	set_bit(EV_MSC, input_ptr->evbit);
	set_bit(MSC_SCAN, input_ptr->mscbit);
	ret = input_register_device(input_ptr);
	if (ret) {
		log_err("input register fail, ret = %d\n", ret);
		goto free_input_dev;
	}

	ret = sensors_classdev_register(&input_ptr->dev, &hall_cdev);
	if (ret) {
		log_err("sensor class register fail\n");
		goto unregister_input;
	}

	ret = app_info_set("Hall", "AKM8789");
	if (ret) {
		log_err("app info set fail\n");
		goto unregister_classdev;
	}

	hall_input = input_ptr;
	return ret;

unregister_classdev:
	sensors_classdev_unregister(&hall_cdev);

unregister_input:
	input_unregister_device(input_ptr);

free_input_dev:
	input_free_device(input_ptr);
	hall_input = NULL;

	return ret;
}

void hall_report_unregister()
{
	sensors_classdev_unregister(&hall_cdev);
	if (hall_input != NULL) {
		input_unregister_device(hall_input);
		input_free_device(hall_input);
		hall_input = NULL;
	}
}

static void check_hall_pen_state(unsigned int value)
{
	static unsigned int state = 0;
	unsigned int temp;

	temp = value & pen_hall_value;
	if (temp != state) {
		if (temp) {
			if (support_coil_switch)
				power_event_bnc_notify(POWER_BNT_WLTX_AUX, POWER_NE_WLTX_AUX_PEN_HALL_APPROACH, NULL);
			else
				power_event_bnc_notify(POWER_BNT_WLTX_AUX, POWER_NE_WLTX_HALL_APPROACH, NULL);

			log_info("open wireless charging\n");
		} else {
			if (support_coil_switch)
				power_event_bnc_notify(POWER_BNT_WLTX_AUX, POWER_NE_WLTX_AUX_PEN_HALL_AWAY_FROM, NULL);
			else
				power_event_bnc_notify(POWER_BNT_WLTX_AUX, POWER_NE_WLTX_HALL_AWAY_FROM, NULL);

			log_info("close wireless charging\n");
		}
		state = temp;
	}
}

static void check_hall_keyboard_state(unsigned int value)
{
	static unsigned int state = 0;
	unsigned int temp;

	temp = value & kb_hall_value;
	if (temp != state) {
		if (temp) {
			if (support_coil_switch)
				power_event_bnc_notify(POWER_BNT_WLTX_AUX, POWER_NE_WLTX_AUX_KB_HALL_APPROACH, NULL);
			else
				power_event_bnc_notify(POWER_BNT_WLTX, POWER_NE_WLTX_HALL_APPROACH, NULL);

			log_info("open wireless charging\n");
		} else {
			if (support_coil_switch)
				power_event_bnc_notify(POWER_BNT_WLTX_AUX, POWER_NE_WLTX_AUX_KB_HALL_AWAY_FROM, NULL);
			else
				power_event_bnc_notify(POWER_BNT_WLTX, POWER_NE_WLTX_HALL_AWAY_FROM, NULL);

			log_info("close wireless charging\n");
		}
		state = temp;
	}
}

int hall_report_value(int value)
{
	if (hall_input == NULL) {
		log_err("ptr is NULL\n");
		return -EINVAL;
	}

	input_event(hall_input, EV_MSC, MSC_SCAN, value);
	input_sync(hall_input);
	log_info("value = %d\n", value);

	if (is_support_hall_keyboard)
		check_hall_keyboard_state((unsigned int)value);

	if (is_support_hall_pen)
		check_hall_pen_state((unsigned int)value);

	return 0;
}

