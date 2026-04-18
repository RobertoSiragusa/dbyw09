/* SPDX-License-Identifier: GPL-2.0 */
/*
 * power_time.h
 *
 * power time module
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

#ifndef _POWER_TIME_H_
#define _POWER_TIME_H_

#include <linux/timekeeping.h>
#include <linux/version.h>

#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4, 18, 0))
static inline struct timespec power_get_current_kernel_time(void)
{
	struct timespec64 ts64;

	ktime_get_coarse_real_ts64(&ts64);
	return timespec64_to_timespec(ts64);
}

static inline struct timespec64 power_get_current_kernel_time64(void)
{
	struct timespec64 ts64;

	ktime_get_coarse_real_ts64(&ts64);
	return ts64;
}

static inline void power_get_timeofday(struct timeval *tv)
{
	struct timespec64 now;

	ktime_get_real_ts64(&now);
	tv->tv_sec = now.tv_sec;
	tv->tv_usec = now.tv_nsec / 1000;
}
#else
static inline struct timespec power_get_current_kernel_time(void)
{
	struct timespec64 now = current_kernel_time64();

	return timespec64_to_timespec(now);
}

static inline struct timespec64 power_get_current_kernel_time64(void)
{
	return current_kernel_time64();
}

static inline void power_get_timeofday(struct timeval *tv)
{
	do_gettimeofday(tv);
}
#endif

#endif /* _POWER_TIME_H_ */
