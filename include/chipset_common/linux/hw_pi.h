/*
 * hw_pi.h
 *
 * Description: provide external call interfaces of hw_pi.
 *
 * Copyright (c) Huawei Technologies Co., Ltd. 2020-2020. All rights reserved.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */
#ifndef HW_PI_H_INCLUDED
#define HW_PI_H_INCLUDED
#include <linux/sched.h>
#ifndef MAX_DL_PRIO
#include <linux/sched/deadline.h>
#endif
#include <linux/sched/rt.h>
#include <linux/cgroup.h>
#include <linux/futex.h>
#include <../../../kernel/locking/rtmutex_common.h>
#ifdef CONFIG_HW_QOS_THREAD
#include <chipset_common/hwqos/hwqos_common.h>
#endif

#ifdef CONFIG_HUAWEI_SCHED_VIP
#define MIN_PREEMPT_VIP_PRIO	(10U)
#define MIN_INHERIT_VIP_PRIO	(1U)
#endif
#ifdef CONFIG_HW_QOS_THREAD
#define MIN_PREEMPT_QOS		(VALUE_QOS_CRITICAL)
#define MIN_INHERIT_QOS		(VALUE_QOS_CRITICAL)
#endif

#define VIP_BITS			(16U)
#define QOS_BITS			(4U)
#define VIP_MASK			((1U << VIP_BITS) - 1)
#define QOS_MASK			((1U << QOS_BITS) - 1)

#define SUPPORT_FUTEX_PI	(0x1)
#define USER_SPACE_ENABLE	(0x2)
#define FUTEX_PI_ENABLE		(SUPPORT_FUTEX_PI | USER_SPACE_ENABLE)
extern unsigned int g_hw_futex_pi_enabled;
static inline int is_hw_futex_pi_enabled(void)
{
	return (g_hw_futex_pi_enabled & FUTEX_PI_ENABLE) == FUTEX_PI_ENABLE;
}

static inline int can_all_pi(struct rt_mutex_waiter *left,
	struct rt_mutex_waiter *right)
{
	return (left && right && !left->major_only && !right->major_only);
}

#ifdef CONFIG_HUAWEI_SCHED_VIP
static inline bool vip_prio_equal(unsigned int left, unsigned int right)
{
	return (left == right) || ((left < MIN_INHERIT_VIP_PRIO) &&
	    (right < MIN_INHERIT_VIP_PRIO));
}

static inline bool prio_equal(struct task_struct *p, int prio,
	unsigned int vip_prio, struct rt_mutex_waiter *waiter)
{
	return likely(p) && ((waiter && waiter->major_only) ?
	    vip_prio_equal(vip_prio, p->vip_prio) :
	    ((vip_prio == p->vip_prio) && (prio == p->prio)));
}
#else
static inline bool prio_equal(struct task_struct *p, int prio,
	unsigned int vip_prio, struct rt_mutex_waiter *waiter)
{
	return (waiter && waiter->major_only) ||
	    (likely(p) && (prio == p->prio));
}
#endif

static inline bool mix_prio_equal(struct task_struct *p, int prio,
	unsigned int vip_prio, struct rt_mutex_waiter *w)
{
	int rt = rt_prio(prio);

	return likely(p) && ((rt && (prio == p->prio) && !dl_prio(prio)) ||
	    (!rt && !rt_prio(p->prio) && prio_equal(p, prio, vip_prio, w)));
}

static inline bool rt_mutex_mix_prio_equal(struct task_struct *p, int prio,
	unsigned int vip_prio, struct rt_mutex_waiter *waiter)
{
	return likely(p) && (likely(is_hw_futex_pi_enabled()) ?
	    mix_prio_equal(p, prio, vip_prio, waiter) :
	    (prio == p->prio && !dl_prio(prio)));
}

#ifdef CONFIG_HW_QOS_THREAD
static inline unsigned int get_preempt_qos(struct task_struct *p)
{
	int qos = likely(p) ? get_task_qos(p) : 0;

	return (qos < MIN_PREEMPT_QOS) ? 0 : (unsigned int)qos;
}
#else
static inline unsigned int get_preempt_qos(struct task_struct *p)
{
	return 0;
}
#endif

static inline unsigned int calculate_major_prio(struct task_struct *p)
{
	return get_preempt_qos(p);
}

static inline void set_preempt_policy(struct rt_mutex_waiter *waiter,
	struct task_struct *p, bool set_policy)
{
	if (likely(waiter) && set_policy)
		waiter->major_only = likely(p) ? (IS_ENABLED(CONFIG_CPUSETS) &&
		    !task_css_is_root(p, cpuset_cgrp_id)) : 0;
}

#define task_to_waiter(p) &(struct rt_mutex_waiter) { \
	.major_prio = calculate_major_prio(p), .major_only = 0, \
	.prio = (p)->prio, .deadline = (p)->dl.deadline }

static inline void rt_mutex_waiter_fill_additional_infos(
	struct rt_mutex_waiter *waiter, struct task_struct *p, bool set_policy)
{
	if (likely(waiter))
		waiter->major_prio = calculate_major_prio(p);
	set_preempt_policy(waiter, p, set_policy);
}

static inline int waiter_less(struct rt_mutex_waiter *left,
	struct rt_mutex_waiter *right)
{
	return (likely(left) && likely(right) && ((left->major_prio >
	    right->major_prio) || ((left->major_prio == right->major_prio) &&
	    can_all_pi(left, right) && (left->prio < right->prio)))) ? 1 : 0;
}

static inline int waiter_more(struct rt_mutex_waiter *left,
	struct rt_mutex_waiter *right)
{
	return (likely(left) && likely(right) && ((left->major_prio <
	    right->major_prio) || ((left->major_prio == right->major_prio) &&
	    can_all_pi(left, right) && (left->prio > right->prio)))) ? 1 : 0;
}

static inline int waiter_equal(struct rt_mutex_waiter *left,
	struct rt_mutex_waiter *right)
{
	return (unlikely(!left) || unlikely(!right) ||
	    (left->major_prio != right->major_prio) ||
	    (can_all_pi(left, right) && (left->prio != right->prio))) ? 0 : 1;
}

static inline int hw_rt_mutex_waiter_less(struct rt_mutex_waiter *left,
	struct rt_mutex_waiter *right)
{
	return (likely(is_hw_futex_pi_enabled()) && likely(left) &&
	    likely(right) && !rt_prio(left->prio) && !rt_prio(right->prio)) ?
	    waiter_less(left, right) : -1;
}

static inline int hw_rt_mutex_waiter_more(struct rt_mutex_waiter *left,
	struct rt_mutex_waiter *right)
{
	return (likely(is_hw_futex_pi_enabled()) && likely(left) &&
	    likely(right) && !rt_prio(left->prio) && !rt_prio(right->prio)) ?
	    waiter_more(left, right) : -1;
}

static inline int hw_rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
	struct rt_mutex_waiter *right)
{
	return (likely(is_hw_futex_pi_enabled()) && likely(left) &&
	    likely(right) && !rt_prio(left->prio) && !rt_prio(right->prio)) ?
	    waiter_equal(left, right) : -1;
}

static inline int rt_mutex_waiter_more(struct rt_mutex_waiter *l,
	struct rt_mutex_waiter *r)
{
	int ret = hw_rt_mutex_waiter_more(l, r);

	return (ret >= 0) ? ret : (((l->prio > r->prio) ||
	    (dl_prio(l->prio) && (l->deadline > r->deadline))) ? 1 : 0);
}

static inline bool hw_pi_can_steal(struct rt_mutex_waiter *l,
	struct rt_mutex_waiter *r)
{
	return likely(is_hw_futex_pi_enabled()) && likely(l) &&
	    likely(r) && !rt_prio(l->prio) && !rt_prio(r->prio);
}

unsigned int rt_mutex_calculate_vip_prio(struct task_struct *p,
	struct task_struct *pi_task);
#ifdef CONFIG_SECCOMP_FILTER
bool can_skip_filter(int this_syscall);
#endif
#endif /* HW_PI_H_INCLUDED */
