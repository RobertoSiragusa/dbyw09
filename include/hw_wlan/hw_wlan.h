
#ifndef HW_WLAN_H
#define HW_WLAN_H
#include <linux/types.h> /* for size_t */

#ifndef DSM_WIFI_MODULE_INIT_ERROR
#define DSM_WIFI_MODULE_INIT_ERROR		(909030001)
#endif
#ifndef DSM_WIFI_FIRMWARE_DL_ERROR
#define DSM_WIFI_FIRMWARE_DL_ERROR		(909030007)
#endif
#ifndef DSM_WIFI_OPEN_ERROR
#define DSM_WIFI_OPEN_ERROR			(909030019)
#endif

void hw_wlan_dsm_register_client(void);

void hw_wlan_dsm_unregister_client(void);

void hw_wlan_dsm_client_notify(int dsm_id, const char *fmt, ...);

int get_cust_config_ini_path(char *ini_path, size_t len);

#endif //HW_WLAN_H
