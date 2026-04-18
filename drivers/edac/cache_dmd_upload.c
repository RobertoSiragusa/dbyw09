/*
 * Copyright (C) Huawei technologies Co., Ltd All rights reserved.
 * FileName: dmd_upload
 * Description: Define some macros and some structures
 * Revision history:2020-10-14 zhangxun NVE
 */
#include "cache_dmd_upload.h"
#ifdef CONFIG_HUAWEI_DSM
#include <dsm/dsm_pub.h>
#endif /* CONFIG_HUAWEI_DSM */
#include <log/hiview_hievent.h>
#include <log/hw_log.h>
#include <log/log_exception.h>
#include <securec.h>

#ifdef CONFIG_HUAWEI_DSM
#define DSM_BUFF_SIZE 256

enum {
	DMD_L3_CACHE_CE = 925200000,
	DMD_L3_CACHE_UE = 925201200,
	DMD_L1_CACHE_CE_0 = 925201201,
	DMD_L1_CACHE_CE_1,
	DMD_L1_CACHE_CE_2,
	DMD_L1_CACHE_CE_3,
	DMD_L1_CACHE_CE_4,
	DMD_L1_CACHE_CE_5,
	DMD_L1_CACHE_CE_6,
	DMD_L1_CACHE_CE_7,
	DMD_L2_CACHE_CE_0 = 925201209,
	DMD_L2_CACHE_CE_1,
	DMD_L2_CACHE_CE_2,
	DMD_L2_CACHE_CE_3,
	DMD_L2_CACHE_CE_4,
	DMD_L2_CACHE_CE_5,
	DMD_L2_CACHE_CE_6,
	DMD_L2_CACHE_CE_7,
	DMD_L1_CACHE_UE_0 = 925201217,
	DMD_L1_CACHE_UE_1,
	DMD_L1_CACHE_UE_2,
	DMD_L1_CACHE_UE_3,
	DMD_L1_CACHE_UE_4,
	DMD_L1_CACHE_UE_5,
	DMD_L1_CACHE_UE_6,
	DMD_L1_CACHE_UE_7,
	DMD_L2_CACHE_UE_0 = 925201225,
	DMD_L2_CACHE_UE_1,
	DMD_L2_CACHE_UE_2,
	DMD_L2_CACHE_UE_3,
	DMD_L2_CACHE_UE_4,
	DMD_L2_CACHE_UE_5,
	DMD_L2_CACHE_UE_6,
	DMD_L2_CACHE_UE_7,
	DMD_SYS_CACHE_CE = 925205200,
	DMD_SYS_CACHE_UE = 925205201,
};

void report_dsm_err(int err_code, const char *err_msg)
{
	int ret;
	struct hiview_hievent *hi_event =
		hiview_hievent_create(err_code);

	if (!hi_event) {
		pr_err("create hievent fail\n");
		return;
	}

	ret = hiview_hievent_put_string(hi_event, "CONTENT", err_msg);
	if (ret < 0)
		pr_err("hievent put string failed\n");

	ret = hiview_hievent_report(hi_event);
	if (ret < 0)
		pr_err("report hievent failed\n");

	hiview_hievent_destroy(hi_event);
}

void report_cache_ecc(int cpuid, int level, int errtype)
{
	int dmd_base = -1;
	char buf[DSM_BUFF_SIZE] = {0};

	if (cpuid > 7 || cpuid < 0) { // max number of cpu is 7
		pr_info("cannot tell cpuid %d, report use cpu0 dmd", cpuid);
		cpuid = 0;
	}
	switch (level) {
	case DMD_CACHE_LEVEL_L1:
		if (errtype == DMD_CACHE_TYPE_CE)
			dmd_base = DMD_L1_CACHE_CE_0;
		else if (errtype == DMD_CACHE_TYPE_UE)
			dmd_base = DMD_L1_CACHE_UE_0;
		break;
	case DMD_CACHE_LEVEL_L2:
		if (errtype == DMD_CACHE_TYPE_CE)
			dmd_base = DMD_L2_CACHE_CE_0;
		else if (errtype == DMD_CACHE_TYPE_UE)
			dmd_base = DMD_L2_CACHE_UE_0;
		break;
	case DMD_CACHE_LEVEL_L3:
		cpuid = 0;
		if (errtype == DMD_CACHE_TYPE_CE)
			dmd_base = DMD_L3_CACHE_CE;
		else if (errtype == DMD_CACHE_TYPE_UE)
			dmd_base = DMD_L3_CACHE_UE;
		break;
	case DMD_CACHE_LEVEL_SYSCACHE:
		cpuid = 0;
		if (errtype == DMD_CACHE_TYPE_CE)
			dmd_base = DMD_SYS_CACHE_CE;
		else if (errtype == DMD_CACHE_TYPE_UE)
			dmd_base = DMD_SYS_CACHE_UE;
		break;
	default:
		pr_info("dmd level not found, dont report dmd");
		return;
	}
	if (dmd_base == -1) {
		pr_err("dmd cannot match, cancel report");
		return;
	}
	if (snprintf_s(buf, sizeof(buf), DSM_BUFF_SIZE,
		"Cache Ecc error, cpuid: %d, cache-level : %d, error type: %d\n",
		cpuid, level, errtype) == -1)
		pr_err("snprintf failed!");
	report_dsm_err(dmd_base + cpuid, buf);
}

#else
void report_cache_ecc(int cpuid, int level, int errtype)
{
	pr_info("ECC_DSM %s: dsm not support\n", __func__);
}
#endif
