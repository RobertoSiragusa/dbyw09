	.text
	.file	"mas_blk_busy_idle_notify.c"
	.globl	mas_blk_busyidle_handler_latency_check_timer_expire // -- Begin function mas_blk_busyidle_handler_latency_check_timer_expire
	.p2align	3
	.type	mas_blk_busyidle_handler_latency_check_timer_expire,@function
mas_blk_busyidle_handler_latency_check_timer_expire: // @mas_blk_busyidle_handler_latency_check_timer_expire
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	adrp	x0, .L.str
	adrp	x1, .L__func__.mas_blk_busyidle_handler_latency_check_timer_expire
	add	x2, x19, #120           // =120
	add	x0, x0, :lo12:.L.str
	add	x1, x1, :lo12:.L__func__.mas_blk_busyidle_handler_latency_check_timer_expire
	mov	w3, #1000
	bl	printk
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end0:
	.size	mas_blk_busyidle_handler_latency_check_timer_expire, .Lfunc_end0-mas_blk_busyidle_handler_latency_check_timer_expire
                                        // -- End function
	.globl	mas_blk_busyidle_notify_handler // -- Begin function mas_blk_busyidle_notify_handler
	.p2align	3
	.type	mas_blk_busyidle_notify_handler,@function
mas_blk_busyidle_notify_handler:        // @mas_blk_busyidle_notify_handler
// %bb.0:
	str	x23, [sp, #-64]!        // 8-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	mov	x22, x1
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	x20, x0
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	bl	_mcount
	ldr	x8, [x20, #56]
	add	x19, x20, #24           // =24
	cbz	x8, .LBB1_14
// %bb.1:
	sub	x23, x20, #112          // =112
	bl	ktime_get
	adrp	x8, jiffies
	add	x21, x23, #16           // =16
	mov	x20, x0
	ldr	x8, [x8, :lo12:jiffies]
	mov	x0, x21
	add	x1, x8, #250            // =250
	bl	mod_timer
	cbz	x22, .LBB1_6
// %bb.2:
	cmp	x22, #1                 // =1
	b.ne	.LBB1_15
// %bb.3:
	ldr	w8, [x23, #192]
	cbnz	w8, .LBB1_9
// %bb.4:
	ldr	x8, [x23, #168]
	orr	w1, wzr, #0x1
	mov	x0, x19
	orr	w22, wzr, #0x1
	blr	x8
	cmp	w0, #1                  // =1
	str	w22, [x23, #192]
	b.ne	.LBB1_8
// %bb.5:
	mov	w22, #32769
	b	.LBB1_10
.LBB1_6:
	ldr	w8, [x23, #192]
	cmp	w8, #1                  // =1
	b.ne	.LBB1_9
// %bb.7:
	ldr	x8, [x23, #168]
	mov	x0, x19
	mov	w1, wzr
	blr	x8
	str	wzr, [x23, #192]
.LBB1_8:
	cmp	w0, #2                  // =2
	b.eq	.LBB1_12
.LBB1_9:
	mov	w22, wzr
.LBB1_10:
	mov	x0, x21
	bl	del_timer_sync
	bl	ktime_get
	mov	w8, #38528
	movk	w8, #152, lsl #16
	add	x8, x20, x8
	cmp	x0, x8
	b.gt	.LBB1_13
.LBB1_11:
	mov	w0, w22
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldr	x23, [sp], #64          // 8-byte Folded Reload
	ret
.LBB1_12:
	adrp	x0, .L.str.2
	adrp	x1, .L__func__.mas_blk_busyidle_notify_handler
	add	x0, x0, :lo12:.L.str.2
	add	x1, x1, :lo12:.L__func__.mas_blk_busyidle_notify_handler
	mov	x2, x19
	bl	printk
	bl	dump_stack
	b	.LBB1_9
.LBB1_13:
	bl	ktime_get
	mov	x9, #13531
	movk	x9, #55222, lsl #16
	movk	x9, #56962, lsl #32
	sub	x8, x0, x20
	movk	x9, #17179, lsl #48
	adrp	x0, .L.str.3
	smulh	x8, x8, x9
	adrp	x1, .L__func__.mas_blk_busyidle_notify_handler
	add	x0, x0, :lo12:.L.str.3
	asr	x9, x8, #18
	add	x3, x9, x8, lsr #63
	add	x1, x1, :lo12:.L__func__.mas_blk_busyidle_notify_handler
	mov	x2, x19
	bl	printk
	b	.LBB1_11
.LBB1_14:
	adrp	x0, .L.str.1
	adrp	x1, .L__func__.mas_blk_busyidle_notify_handler
	add	x0, x0, :lo12:.L.str.1
	add	x1, x1, :lo12:.L__func__.mas_blk_busyidle_notify_handler
	mov	x2, x19
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.LBB1_15:
	adrp	x0, .L.str.41
	adrp	x1, .L.str.42
	add	x0, x0, :lo12:.L.str.41
	add	x1, x1, :lo12:.L.str.42
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.Lfunc_end1:
	.size	mas_blk_busyidle_notify_handler, .Lfunc_end1-mas_blk_busyidle_notify_handler
                                        // -- End function
	.globl	mas_blk_idle_notify_work // -- Begin function mas_blk_idle_notify_work
	.p2align	3
	.type	mas_blk_idle_notify_work,@function
mas_blk_idle_notify_work:               // @mas_blk_idle_notify_work
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldrb	w8, [x19, #-8]!
	cbz	w8, .LBB2_2
// %bb.1:
	str	wzr, [x19, #432]
.LBB2_2:
	add	x20, x19, #440          // =440
	mov	x0, x20
	mov	w1, wzr
	bl	mutex_lock_nested
	ldr	w8, [x19, #432]
	cbnz	w8, .LBB2_7
// %bb.3:
	ldr	w8, [x19, #624]
	cmp	w8, #1                  // =1
	b.eq	.LBB2_7
// %bb.4:
	ldr	x8, [x19, #664]
	orr	w9, wzr, #0x1
	str	w9, [x19, #624]
	add	x8, x8, #1              // =1
	str	x8, [x19, #664]
	bl	ktime_get
	ldr	x8, [x19, #640]
	str	x0, [x19, #632]
	cbz	x8, .LBB2_6
// %bb.5:
	ldr	x9, [x19, #648]
	sub	x8, x0, x8
	add	x8, x8, x9
	str	x8, [x19, #648]
.LBB2_6:
	add	x0, x19, #232           // =232
	orr	w1, wzr, #0x1
	mov	x2, xzr
	bl	blocking_notifier_call_chain
.LBB2_7:
	mov	x0, x20
	bl	mutex_unlock
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end2:
	.size	mas_blk_idle_notify_work, .Lfunc_end2-mas_blk_idle_notify_work
                                        // -- End function
	.globl	blk_lld_idle_notify     // -- Begin function blk_lld_idle_notify
	.p2align	3
	.type	blk_lld_idle_notify,@function
blk_lld_idle_notify:                    // @blk_lld_idle_notify
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	w8, [x19]
	cmp	w8, #122                // =122
	b.ne	.LBB3_2
// %bb.1:
	adrp	x8, blk_idle_notify_workqueue
	ldr	w0, [x19, #288]
	add	x19, x19, #88           // =88
	ldr	x20, [x8, :lo12:blk_idle_notify_workqueue]
	bl	__msecs_to_jiffies
	mov	x3, x0
	orr	w0, wzr, #0x8
	mov	x1, x20
	mov	x2, x19
	bl	queue_delayed_work_on
.LBB3_2:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end3:
	.size	blk_lld_idle_notify, .Lfunc_end3-blk_lld_idle_notify
                                        // -- End function
	.globl	mas_queue_busyidle_enable_store // -- Begin function mas_queue_busyidle_enable_store
	.p2align	3
	.type	mas_queue_busyidle_enable_store,@function
mas_queue_busyidle_enable_store:        // @mas_queue_busyidle_enable_store
// %bb.0:
	sub	sp, sp, #64             // =64
	adrp	x8, __stack_chk_guard
	str	x21, [sp, #16]          // 8-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	x19, x2
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	mov	x21, x1
	mov	x20, x0
	str	x8, [sp, #8]
	bl	_mcount
	mov	x0, sp
	mov	x1, x21
	mov	x2, x19
	bl	queue_var_store
	mov	x19, x0
	tbnz	x0, #63, .LBB4_4
// %bb.1:
	ldr	x8, [sp]
	cbz	x8, .LBB4_4
// %bb.2:
	adrp	x0, .L.str.4
	adrp	x1, .L__func__.mas_queue_busyidle_enable_store
	add	x0, x0, :lo12:.L.str.4
	add	x1, x1, :lo12:.L__func__.mas_queue_busyidle_enable_store
	bl	printk
	cbz	x20, .LBB4_7
// %bb.3:
	mov	x0, x20
	bl	mas_blk_get_lld
	ldr	x8, [x0, #24]
	orr	x8, x8, #0x8
	b	.LBB4_6
.LBB4_4:
	adrp	x0, .L.str.5
	adrp	x1, .L__func__.mas_queue_busyidle_enable_store
	add	x0, x0, :lo12:.L.str.5
	add	x1, x1, :lo12:.L__func__.mas_queue_busyidle_enable_store
	bl	printk
	cbz	x20, .LBB4_7
// %bb.5:
	mov	x0, x20
	bl	mas_blk_get_lld
	ldr	x8, [x0, #24]
	and	x8, x8, #0xfffffffffffffff7
.LBB4_6:
	str	x8, [x0, #24]
.LBB4_7:
	adrp	x9, __stack_chk_guard
	ldr	x8, [sp, #8]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB4_9
// %bb.8:
	mov	x0, x19
	ldr	x21, [sp, #16]          // 8-byte Folded Reload
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	add	sp, sp, #64             // =64
	ret
.LBB4_9:
	bl	__stack_chk_fail
.Lfunc_end4:
	.size	mas_queue_busyidle_enable_store, .Lfunc_end4-mas_queue_busyidle_enable_store
                                        // -- End function
	.globl	blk_queue_busyidle_enable // -- Begin function blk_queue_busyidle_enable
	.p2align	3
	.type	blk_queue_busyidle_enable,@function
blk_queue_busyidle_enable:              // @blk_queue_busyidle_enable
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	w19, w1
	mov	x20, x0
	bl	_mcount
	cbz	x20, .LBB5_2
// %bb.1:
	mov	x0, x20
	bl	mas_blk_get_lld
	ldr	x8, [x0, #24]
	cmp	w19, #0                 // =0
	orr	x9, x8, #0x8
	and	x8, x8, #0xfffffffffffffff7
	csel	x8, x8, x9, eq
	str	x8, [x0, #24]
.LBB5_2:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end5:
	.size	blk_queue_busyidle_enable, .Lfunc_end5-blk_queue_busyidle_enable
                                        // -- End function
	.globl	mas_queue_busyidle_statistic_reset_store // -- Begin function mas_queue_busyidle_statistic_reset_store
	.p2align	3
	.type	mas_queue_busyidle_statistic_reset_store,@function
mas_queue_busyidle_statistic_reset_store: // @mas_queue_busyidle_statistic_reset_store
// %bb.0:
	sub	sp, sp, #64             // =64
	adrp	x8, __stack_chk_guard
	str	x21, [sp, #16]          // 8-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	x19, x2
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	mov	x21, x1
	mov	x20, x0
	str	x8, [sp, #8]
	bl	_mcount
	mov	x0, x20
	bl	mas_blk_get_lld
	mov	x20, x0
	mov	x0, sp
	mov	x1, x21
	mov	x2, x19
	bl	queue_var_store
	mov	x19, x0
	tbnz	x0, #63, .LBB6_2
// %bb.1:
	ldr	x8, [sp]
	cbnz	x8, .LBB6_4
.LBB6_2:
	adrp	x9, __stack_chk_guard
	ldr	x8, [sp, #8]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB6_5
// %bb.3:
	mov	x0, x19
	ldr	x21, [sp, #16]          // 8-byte Folded Reload
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	add	sp, sp, #64             // =64
	ret
.LBB6_4:
	adrp	x0, .L.str.6
	adrp	x1, .L__func__.mas_queue_busyidle_statistic_reset_store
	add	x0, x0, :lo12:.L.str.6
	add	x1, x1, :lo12:.L__func__.mas_queue_busyidle_statistic_reset_store
	bl	printk
	str	xzr, [x20, #824]
	str	xzr, [x20, #816]
	str	xzr, [x20, #808]
	str	xzr, [x20, #800]
	str	xzr, [x20, #792]
	str	xzr, [x20, #784]
	str	xzr, [x20, #776]
	str	xzr, [x20, #768]
	str	xzr, [x20, #760]
	str	xzr, [x20, #752]
	str	xzr, [x20, #744]
	str	xzr, [x20, #736]
	str	xzr, [x20, #728]
	b	.LBB6_2
.LBB6_5:
	bl	__stack_chk_fail
.Lfunc_end6:
	.size	mas_queue_busyidle_statistic_reset_store, .Lfunc_end6-mas_queue_busyidle_statistic_reset_store
                                        // -- End function
	.globl	mas_queue_busyidle_statistic_show // -- Begin function mas_queue_busyidle_statistic_show
	.p2align	3
	.type	mas_queue_busyidle_statistic_show,@function
mas_queue_busyidle_statistic_show:      // @mas_queue_busyidle_statistic_show
// %bb.0:
	stp	x22, x21, [sp, #-48]!   // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x2
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x20, x1
	mov	x21, x0
	bl	_mcount
	mov	x0, x21
	bl	mas_blk_get_lld
	mov	x8, #13531
	ldr	x9, [x0, #728]
	movk	x8, #55222, lsl #16
	ldr	x10, [x0, #736]
	movk	x8, #56962, lsl #32
	movk	x8, #17179, lsl #48
	adrp	x2, .L.str.7
	smulh	x9, x9, x8
	mov	x21, x0
	smulh	x8, x10, x8
	add	x2, x2, :lo12:.L.str.7
	asr	x10, x9, #18
	asr	x11, x8, #18
	add	x3, x10, x9, lsr #63
	add	x4, x11, x8, lsr #63
	mov	x0, x20
	mov	x1, x19
	bl	snprintf
                                        // kill: def $w0 killed $w0 def $x0
	ldr	x3, [x21, #744]
	adrp	x2, .L.str.8
	sxtw	x22, w0
	add	x0, x20, x22
	sub	x1, x19, x22
	add	x2, x2, :lo12:.L.str.8
	bl	snprintf
	add	x22, x22, w0, sxtw
	adrp	x2, .L.str.9
	add	x0, x20, x22
	sub	x1, x19, x22
	add	x2, x2, :lo12:.L.str.9
	bl	snprintf
	ldr	x3, [x21, #824]
	add	x22, x22, w0, sxtw
	adrp	x2, .L.str.10
	add	x0, x20, x22
	sub	x1, x19, x22
	add	x2, x2, :lo12:.L.str.10
	bl	snprintf
	ldr	x3, [x21, #752]
	add	x22, x22, w0, sxtw
	adrp	x2, .L.str.11
	add	x0, x20, x22
	sub	x1, x19, x22
	add	x2, x2, :lo12:.L.str.11
	bl	snprintf
	ldr	x3, [x21, #760]
	add	x22, x22, w0, sxtw
	adrp	x2, .L.str.12
	add	x0, x20, x22
	sub	x1, x19, x22
	add	x2, x2, :lo12:.L.str.12
	bl	snprintf
	ldr	x3, [x21, #768]
	add	x22, x22, w0, sxtw
	adrp	x2, .L.str.13
	add	x0, x20, x22
	sub	x1, x19, x22
	add	x2, x2, :lo12:.L.str.13
	bl	snprintf
	ldr	x3, [x21, #776]
	add	x22, x22, w0, sxtw
	adrp	x2, .L.str.14
	add	x0, x20, x22
	sub	x1, x19, x22
	add	x2, x2, :lo12:.L.str.14
	bl	snprintf
	ldr	x3, [x21, #784]
	add	x22, x22, w0, sxtw
	adrp	x2, .L.str.15
	add	x0, x20, x22
	sub	x1, x19, x22
	add	x2, x2, :lo12:.L.str.15
	bl	snprintf
	ldr	x3, [x21, #792]
	add	x22, x22, w0, sxtw
	adrp	x2, .L.str.16
	add	x0, x20, x22
	sub	x1, x19, x22
	add	x2, x2, :lo12:.L.str.16
	bl	snprintf
	ldr	x3, [x21, #800]
	add	x22, x22, w0, sxtw
	adrp	x2, .L.str.17
	add	x0, x20, x22
	sub	x1, x19, x22
	add	x2, x2, :lo12:.L.str.17
	bl	snprintf
	ldr	x3, [x21, #808]
	add	x22, x22, w0, sxtw
	adrp	x2, .L.str.18
	add	x0, x20, x22
	sub	x1, x19, x22
	add	x2, x2, :lo12:.L.str.18
	bl	snprintf
	ldr	x3, [x21, #816]
	add	x22, x22, w0, sxtw
	adrp	x2, .L.str.19
	add	x0, x20, x22
	sub	x1, x19, x22
	add	x2, x2, :lo12:.L.str.19
	bl	snprintf
	ldr	x3, [x21, #744]
	add	x21, x22, w0, sxtw
	adrp	x2, .L.str.20
	add	x0, x20, x21
	sub	x1, x19, x21
	add	x2, x2, :lo12:.L.str.20
	bl	snprintf
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	add	x0, x21, w0, sxtw
	ldp	x22, x21, [sp], #48     // 16-byte Folded Reload
	ret
.Lfunc_end7:
	.size	mas_queue_busyidle_statistic_show, .Lfunc_end7-mas_queue_busyidle_statistic_show
                                        // -- End function
	.globl	mas_queue_hw_idle_enable_show // -- Begin function mas_queue_hw_idle_enable_show
	.p2align	3
	.type	mas_queue_hw_idle_enable_show,@function
mas_queue_hw_idle_enable_show:          // @mas_queue_hw_idle_enable_show
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x2
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x20, x1
	mov	x21, x0
	bl	_mcount
	mov	x0, x21
	bl	mas_blk_get_lld
	ldrb	w8, [x0, #80]
	adrp	x9, .L.str.22
	adrp	x10, .L.str.23
	add	x9, x9, :lo12:.L.str.22
	add	x10, x10, :lo12:.L.str.23
	cmp	w8, #0                  // =0
	adrp	x2, .L.str.21
	csel	x3, x10, x9, eq
	add	x2, x2, :lo12:.L.str.21
	mov	x0, x20
	mov	x1, x19
	bl	snprintf
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
                                        // kill: def $w0 killed $w0 def $x0
	sxtw	x0, w0
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.Lfunc_end8:
	.size	mas_queue_hw_idle_enable_show, .Lfunc_end8-mas_queue_hw_idle_enable_show
                                        // -- End function
	.globl	mas_queue_idle_state_show // -- Begin function mas_queue_idle_state_show
	.p2align	3
	.type	mas_queue_idle_state_show,@function
mas_queue_idle_state_show:              // @mas_queue_idle_state_show
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x2
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x20, x1
	mov	x21, x0
	bl	_mcount
	mov	x0, x21
	bl	mas_blk_get_lld
	ldr	w8, [x0, #704]
	adrp	x9, .L.str.26
	adrp	x10, .L.str.25
	add	x9, x9, :lo12:.L.str.26
	add	x10, x10, :lo12:.L.str.25
	cmp	w8, #1                  // =1
	adrp	x2, .L.str.24
	mov	x21, x0
	csel	x3, x10, x9, eq
	add	x2, x2, :lo12:.L.str.24
	mov	x0, x20
	mov	x1, x19
	bl	snprintf
                                        // kill: def $w0 killed $w0 def $x0
	ldr	w3, [x21, #512]
	adrp	x2, .L.str.27
	sxtw	x21, w0
	add	x0, x20, x21
	sub	x1, x19, x21
	add	x2, x2, :lo12:.L.str.27
	bl	snprintf
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	add	x0, x21, w0, sxtw
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.Lfunc_end9:
	.size	mas_queue_idle_state_show, .Lfunc_end9-mas_queue_idle_state_show
                                        // -- End function
	.globl	mas_blk_busyidle_check_bio // -- Begin function mas_blk_busyidle_check_bio
	.p2align	3
	.type	mas_blk_busyidle_check_bio,@function
mas_blk_busyidle_check_bio:             // @mas_blk_busyidle_check_bio
// %bb.0:
	str	x25, [sp, #-80]!        // 8-byte Folded Spill
	stp	x24, x23, [sp, #16]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #32]     // 16-byte Folded Spill
	mov	x21, x0
	stp	x20, x19, [sp, #48]     // 16-byte Folded Spill
	mov	x19, x1
	stp	x29, x30, [sp, #64]     // 16-byte Folded Spill
	add	x29, sp, #64            // =64
	bl	_mcount
	mov	x0, x21
	bl	mas_blk_get_lld
	ldrb	w8, [x19, #152]
	str	x21, [x19, #104]
	tbnz	w8, #0, .LBB10_4
// %bb.1:
	add	x21, x0, #1216          // =1216
	mov	x20, x0
	orr	w8, w8, #0x1
	mov	x0, x21
	strb	w8, [x19, #152]
	bl	_raw_spin_lock_irqsave
	ldr	x8, [x20, #1168]
	add	x23, x19, #352          // =352
	ldr	x24, [x20, #1192]
	add	x25, x20, #1184         // =1184
	mov	x22, x0
	mov	x0, x23
	add	x8, x8, #1              // =1
	mov	x1, x24
	mov	x2, x25
	str	x8, [x20, #1168]
	bl	__list_add_valid
	tbz	w0, #0, .LBB10_3
// %bb.2:
	str	x23, [x20, #1192]
	stp	x25, x24, [x19, #352]
	str	x23, [x24]
.LBB10_3:
	mov	x0, x21
	mov	x1, x22
	bl	_raw_spin_unlock_irqrestore
	mov	x0, x20
	bl	blk_busy_count
.LBB10_4:
	ldp	x29, x30, [sp, #64]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]     // 16-byte Folded Reload
	ldr	x25, [sp], #80          // 8-byte Folded Reload
	ret
.Lfunc_end10:
	.size	mas_blk_busyidle_check_bio, .Lfunc_end10-mas_blk_busyidle_check_bio
                                        // -- End function
	.p2align	3               // -- Begin function blk_busy_count
	.type	blk_busy_count,@function
blk_busy_count:                         // @blk_busy_count
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldrb	w8, [x19, #24]
	tbz	w8, #3, .LBB11_3
// %bb.1:
	ldr	w8, [x19, #512]
	cbz	w8, .LBB11_4
.LBB11_2:
	add	x8, x19, #512           // =512
	//APP
	// atomic_add
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
.LBB11_3:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.LBB11_4:
	add	x20, x19, #520          // =520
	mov	x0, x20
	mov	w1, wzr
	bl	mutex_lock_nested
	add	x0, x19, #88            // =88
	bl	cancel_delayed_work
	ldr	w8, [x19, #704]
	cmp	w8, #1                  // =1
	b.ne	.LBB11_28
// %bb.5:
	str	wzr, [x19, #704]
	bl	ktime_get
	ldr	x8, [x19, #712]
	str	x0, [x19, #720]
	cbz	x8, .LBB11_27
// %bb.6:
	cbz	x0, .LBB11_26
// %bb.7:
	mov	x9, #13531
	ldr	x12, [x19, #824]
	movk	x9, #55222, lsl #16
	movk	x9, #56962, lsl #32
	movk	x9, #17179, lsl #48
	smulh	x10, x0, x9
	smulh	x9, x8, x9
	asr	x11, x10, #18
	asr	x13, x9, #18
	add	x10, x11, x10, lsr #63
	add	x9, x13, x9, lsr #63
	sub	x9, x10, x9
	cmp	x9, x12
	b.le	.LBB11_9
// %bb.8:
	str	x9, [x19, #824]
.LBB11_9:
	cmp	x9, #99                 // =99
	b.gt	.LBB11_11
// %bb.10:
	ldr	x9, [x19, #752]
	add	x9, x9, #1              // =1
	str	x9, [x19, #752]
	b	.LBB11_26
.LBB11_11:
	cmp	x9, #499                // =499
	b.gt	.LBB11_13
// %bb.12:
	ldr	x9, [x19, #760]
	add	x9, x9, #1              // =1
	str	x9, [x19, #760]
	b	.LBB11_26
.LBB11_13:
	cmp	x9, #999                // =999
	b.gt	.LBB11_15
// %bb.14:
	ldr	x9, [x19, #768]
	add	x9, x9, #1              // =1
	str	x9, [x19, #768]
	b	.LBB11_26
.LBB11_15:
	cmp	x9, #1999               // =1999
	b.gt	.LBB11_17
// %bb.16:
	ldr	x9, [x19, #776]
	add	x9, x9, #1              // =1
	str	x9, [x19, #776]
	b	.LBB11_26
.LBB11_17:
	cmp	x9, #3999               // =3999
	b.gt	.LBB11_19
// %bb.18:
	ldr	x9, [x19, #784]
	add	x9, x9, #1              // =1
	str	x9, [x19, #784]
	b	.LBB11_26
.LBB11_19:
	mov	w10, #5999
	cmp	x9, x10
	b.gt	.LBB11_21
// %bb.20:
	ldr	x9, [x19, #792]
	add	x9, x9, #1              // =1
	str	x9, [x19, #792]
	b	.LBB11_26
.LBB11_21:
	mov	w10, #7999
	cmp	x9, x10
	b.gt	.LBB11_23
// %bb.22:
	ldr	x9, [x19, #800]
	add	x9, x9, #1              // =1
	str	x9, [x19, #800]
	b	.LBB11_26
.LBB11_23:
	mov	w10, #9999
	cmp	x9, x10
	b.gt	.LBB11_25
// %bb.24:
	ldr	x9, [x19, #808]
	add	x9, x9, #1              // =1
	str	x9, [x19, #808]
	b	.LBB11_26
.LBB11_25:
	ldr	x9, [x19, #816]
	add	x9, x9, #1              // =1
	str	x9, [x19, #816]
.LBB11_26:
	ldr	x9, [x19, #736]
	sub	x8, x0, x8
	add	x8, x8, x9
	str	x8, [x19, #736]
.LBB11_27:
	add	x0, x19, #312           // =312
	mov	x1, xzr
	mov	x2, xzr
	bl	blocking_notifier_call_chain
.LBB11_28:
	mov	x0, x20
	bl	mutex_unlock
	b	.LBB11_2
.Lfunc_end11:
	.size	blk_busy_count, .Lfunc_end11-blk_busy_count
                                        // -- End function
	.globl	mas_blk_busyidle_check_request_bio // -- Begin function mas_blk_busyidle_check_request_bio
	.p2align	3
	.type	mas_blk_busyidle_check_request_bio,@function
mas_blk_busyidle_check_request_bio:     // @mas_blk_busyidle_check_request_bio
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x20, x1
	mov	x19, x0
	bl	_mcount
	ldr	x20, [x20, #64]
	cbz	x20, .LBB12_3
.LBB12_1:                               // =>This Inner Loop Header: Depth=1
	mov	x0, x19
	mov	x1, x20
	bl	mas_blk_busyidle_check_bio
	ldr	x20, [x20]
	cbnz	x20, .LBB12_1
// %bb.2:
	orr	w0, wzr, #0x1
	b	.LBB12_4
.LBB12_3:
	mov	w0, wzr
.LBB12_4:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end12:
	.size	mas_blk_busyidle_check_request_bio, .Lfunc_end12-mas_blk_busyidle_check_request_bio
                                        // -- End function
	.globl	mas_blk_busyidle_end_rq // -- Begin function mas_blk_busyidle_end_rq
	.p2align	3
	.type	mas_blk_busyidle_end_rq,@function
mas_blk_busyidle_end_rq:                // @mas_blk_busyidle_end_rq
// %bb.0:
	stp	x24, x23, [sp, #-64]!   // 16-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	w19, w1
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	mov	x20, x0
	bl	_mcount
	ldr	x0, [x20]
	bl	mas_blk_get_lld
	ldr	x8, [x0, #1176]
	cbz	x8, .LBB13_12
// %bb.1:
	add	x22, x0, #1216          // =1216
	mov	x21, x0
	mov	x0, x22
	bl	_raw_spin_lock_irqsave
	ldr	x8, [x21, #1176]
	add	x24, x20, #440          // =440
	mov	x23, x0
	mov	x0, x24
	sub	x8, x8, #1              // =1
	str	x8, [x21, #1176]
	bl	__list_del_entry_valid
	tbz	w0, #0, .LBB13_3
// %bb.2:
	ldp	x8, x9, [x20, #440]
	str	x9, [x8, #8]
	str	x8, [x9]
.LBB13_3:
	mov	x0, x22
	str	x24, [x20, #440]
	mov	x1, x23
	str	x24, [x20, #448]
	bl	_raw_spin_unlock_irqrestore
	ldrb	w8, [x21, #24]
	tbz	w8, #3, .LBB13_7
// %bb.4:
	ldrb	w8, [x21, #80]
	cbnz	w8, .LBB13_7
// %bb.5:
	ldr	w8, [x21, #512]
	cbz	w8, .LBB13_13
// %bb.6:
	add	x8, x21, #512           // =512
	//APP
	// atomic_sub_return
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	sub	w9, w9, #1
	stlxr	w10, w9, [x8]
	cbnz	w10, 1b
	dmb ish
	//NO_APP
	cbz	w9, .LBB13_10
.LBB13_7:
	ldr	x8, [x20, #264]
	cbz	x8, .LBB13_9
.LBB13_8:
	mov	x0, x20
	mov	w1, w19
	blr	x8
.LBB13_9:
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldp	x24, x23, [sp], #64     // 16-byte Folded Reload
	ret
.LBB13_10:
	ldr	w8, [x21]
	cmp	w8, #122                // =122
	b.ne	.LBB13_7
// %bb.11:
	adrp	x8, blk_idle_notify_workqueue
	ldr	w0, [x21, #288]
	add	x21, x21, #88           // =88
	ldr	x22, [x8, :lo12:blk_idle_notify_workqueue]
	bl	__msecs_to_jiffies
	mov	x3, x0
	orr	w0, wzr, #0x8
	mov	x1, x22
	mov	x2, x21
	bl	queue_delayed_work_on
	ldr	x8, [x20, #264]
	cbnz	x8, .LBB13_8
	b	.LBB13_9
.LBB13_12:
	adrp	x0, .L.str.41
	adrp	x1, .L.str.44
	add	x0, x0, :lo12:.L.str.41
	add	x1, x1, :lo12:.L.str.44
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.LBB13_13:
	adrp	x0, .L.str.45
	adrp	x1, .L__func__.blk_idle_count
	add	x0, x0, :lo12:.L.str.45
	add	x1, x1, :lo12:.L__func__.blk_idle_count
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.Lfunc_end13:
	.size	mas_blk_busyidle_end_rq, .Lfunc_end13-mas_blk_busyidle_end_rq
                                        // -- End function
	.globl	mas_blk_busyidle_check_execute_request // -- Begin function mas_blk_busyidle_check_execute_request
	.p2align	3
	.type	mas_blk_busyidle_check_execute_request,@function
mas_blk_busyidle_check_execute_request: // @mas_blk_busyidle_check_execute_request
// %bb.0:
	stp	x26, x25, [sp, #-80]!   // 16-byte Folded Spill
	stp	x24, x23, [sp, #16]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #32]     // 16-byte Folded Spill
	mov	x21, x0
	stp	x20, x19, [sp, #48]     // 16-byte Folded Spill
	mov	x19, x2
	stp	x29, x30, [sp, #64]     // 16-byte Folded Spill
	add	x29, sp, #64            // =64
	mov	x20, x1
	bl	_mcount
	ldr	x22, [x20, #64]
	cbz	x22, .LBB14_3
.LBB14_1:                               // =>This Inner Loop Header: Depth=1
	mov	x0, x21
	mov	x1, x22
	bl	mas_blk_busyidle_check_bio
	ldr	x22, [x22]
	cbnz	x22, .LBB14_1
// %bb.2:
	str	x19, [x20, #544]
	b	.LBB14_6
.LBB14_3:
	ldr	x0, [x20]
	bl	mas_blk_get_lld
	add	x22, x0, #1216          // =1216
	mov	x21, x0
	mov	x0, x22
	bl	_raw_spin_lock_irqsave
	ldr	x8, [x21, #1176]
	add	x24, x20, #440          // =440
	ldr	x25, [x21, #1208]
	add	x26, x21, #1200         // =1200
	mov	x23, x0
	mov	x0, x24
	add	x8, x8, #1              // =1
	mov	x1, x25
	mov	x2, x26
	str	x8, [x21, #1176]
	bl	__list_add_valid
	tbz	w0, #0, .LBB14_5
// %bb.4:
	str	x24, [x21, #1208]
	stp	x26, x25, [x20, #440]
	str	x24, [x25]
.LBB14_5:
	mov	x0, x22
	mov	x1, x23
	bl	_raw_spin_unlock_irqrestore
	mov	x0, x21
	bl	blk_busy_count
	adrp	x8, __cfi_mas_blk_busyidle_end_rq
	str	x19, [x20, #264]
	add	x8, x8, :lo12:__cfi_mas_blk_busyidle_end_rq
	str	x8, [x20, #544]
.LBB14_6:
	ldp	x29, x30, [sp, #64]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]     // 16-byte Folded Reload
	ldp	x26, x25, [sp], #80     // 16-byte Folded Reload
	ret
.Lfunc_end14:
	.size	mas_blk_busyidle_check_execute_request, .Lfunc_end14-mas_blk_busyidle_check_execute_request
                                        // -- End function
	.globl	mas_blk_busyidle_check_bio_endio // -- Begin function mas_blk_busyidle_check_bio_endio
	.p2align	3
	.type	mas_blk_busyidle_check_bio_endio,@function
mas_blk_busyidle_check_bio_endio:       // @mas_blk_busyidle_check_bio_endio
// %bb.0:
	str	x23, [sp, #-64]!        // 8-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	x20, x0
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	bl	_mcount
	ldr	x8, [x20, #8]
	add	x9, x20, #104           // =104
	add	x10, x8, #1712          // =1712
	cmp	x8, #0                  // =0
	csel	x8, x9, x10, eq
	ldr	x0, [x8]
	bl	mas_blk_get_lld
	ldrb	w8, [x20, #152]
	tbz	w8, #0, .LBB15_8
// %bb.1:
	ldr	x8, [x0, #1168]
	mov	x19, x0
	cbz	x8, .LBB15_11
// %bb.2:
	add	x21, x19, #1216         // =1216
	mov	x0, x21
	bl	_raw_spin_lock_irqsave
	ldr	x8, [x19, #1168]
	add	x23, x20, #352          // =352
	mov	x22, x0
	mov	x0, x23
	sub	x8, x8, #1              // =1
	str	x8, [x19, #1168]
	bl	__list_del_entry_valid
	tbz	w0, #0, .LBB15_4
// %bb.3:
	ldp	x8, x9, [x20, #352]
	str	x9, [x8, #8]
	str	x8, [x9]
.LBB15_4:
	mov	x0, x21
	str	x23, [x20, #352]
	mov	x1, x22
	str	x23, [x20, #360]
	bl	_raw_spin_unlock_irqrestore
	strb	wzr, [x20, #152]
	ldrb	w8, [x19, #24]
	tbz	w8, #3, .LBB15_8
// %bb.5:
	ldrb	w8, [x19, #80]
	cbnz	w8, .LBB15_8
// %bb.6:
	ldr	w8, [x19, #512]
	cbz	w8, .LBB15_12
// %bb.7:
	add	x8, x19, #512           // =512
	//APP
	// atomic_sub_return
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	sub	w9, w9, #1
	stlxr	w10, w9, [x8]
	cbnz	w10, 1b
	dmb ish
	//NO_APP
	cbz	w9, .LBB15_9
.LBB15_8:
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldr	x23, [sp], #64          // 8-byte Folded Reload
	ret
.LBB15_9:
	ldr	w8, [x19]
	cmp	w8, #122                // =122
	b.ne	.LBB15_8
// %bb.10:
	adrp	x8, blk_idle_notify_workqueue
	ldr	w0, [x19, #288]
	add	x19, x19, #88           // =88
	ldr	x20, [x8, :lo12:blk_idle_notify_workqueue]
	bl	__msecs_to_jiffies
	mov	x3, x0
	orr	w0, wzr, #0x8
	mov	x1, x20
	mov	x2, x19
	bl	queue_delayed_work_on
	b	.LBB15_8
.LBB15_11:
	adrp	x0, .L.str.41
	adrp	x1, .L.str.46
	add	x0, x0, :lo12:.L.str.41
	add	x1, x1, :lo12:.L.str.46
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.LBB15_12:
	adrp	x0, .L.str.45
	adrp	x1, .L__func__.blk_idle_count
	add	x0, x0, :lo12:.L.str.45
	add	x1, x1, :lo12:.L__func__.blk_idle_count
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.Lfunc_end15:
	.size	mas_blk_busyidle_check_bio_endio, .Lfunc_end15-mas_blk_busyidle_check_bio_endio
                                        // -- End function
	.globl	blk_busyidle_event_subscribe // -- Begin function blk_busyidle_event_subscribe
	.p2align	3
	.type	blk_busyidle_event_subscribe,@function
blk_busyidle_event_subscribe:           // @blk_busyidle_event_subscribe
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	mov	w0, #-22
	cbz	x20, .LBB16_5
// %bb.1:
	cbz	x19, .LBB16_5
// %bb.2:
	ldr	x8, [x20, #280]
	ldr	x0, [x8, #1712]
	cbz	x0, .LBB16_4
// %bb.3:
	bl	mas_blk_get_lld
	mov	x1, x19
	bl	blk_lld_busyidle_event_subscribe
	b	.LBB16_5
.LBB16_4:
	mov	w0, #-22
.LBB16_5:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end16:
	.size	blk_busyidle_event_subscribe, .Lfunc_end16-blk_busyidle_event_subscribe
                                        // -- End function
	.globl	blk_queue_busyidle_event_subscribe // -- Begin function blk_queue_busyidle_event_subscribe
	.p2align	3
	.type	blk_queue_busyidle_event_subscribe,@function
blk_queue_busyidle_event_subscribe:     // @blk_queue_busyidle_event_subscribe
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	mov	w0, #-22
	cbz	x20, .LBB17_3
// %bb.1:
	cbz	x19, .LBB17_3
// %bb.2:
	mov	x0, x20
	bl	mas_blk_get_lld
	mov	x1, x19
	bl	blk_lld_busyidle_event_subscribe
.LBB17_3:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end17:
	.size	blk_queue_busyidle_event_subscribe, .Lfunc_end17-blk_queue_busyidle_event_subscribe
                                        // -- End function
	.globl	blk_lld_busyidle_event_subscribe // -- Begin function blk_lld_busyidle_event_subscribe
	.p2align	3
	.type	blk_lld_busyidle_event_subscribe,@function
blk_lld_busyidle_event_subscribe:       // @blk_lld_busyidle_event_subscribe
// %bb.0:
	str	x25, [sp, #-80]!        // 8-byte Folded Spill
	stp	x24, x23, [sp, #16]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #32]     // 16-byte Folded Spill
	mov	x22, x1
	stp	x20, x19, [sp, #48]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #64]     // 16-byte Folded Spill
	add	x29, sp, #64            // =64
	bl	_mcount
	mov	w0, #-22
	cbz	x19, .LBB18_14
// %bb.1:
	cbz	x22, .LBB18_14
// %bb.2:
	adrp	x8, kmalloc_caches
	str	x19, [x22, #48]
	add	x8, x8, :lo12:kmalloc_caches
	mov	w1, #32960
	movk	w1, #96, lsl #16
	ldr	x0, [x8, #64]
	mov	w2, #200
	bl	kmem_cache_alloc_trace
	cbz	x0, .LBB18_13
// %bb.3:
	ldp	x8, x10, [x22]
	mov	x20, x0
	ldp	x9, x13, [x22, #16]
	ldp	x12, x11, [x22, #40]
	mov	x21, x0
	str	x8, [x20, #136]!
	ldr	x8, [x22, #32]
	stp	x10, x9, [x20, #8]
	stp	x12, x11, [x20, #40]
	stp	x13, x8, [x20, #24]
	cbz	x8, .LBB18_15
// %bb.4:
	mov	x0, x20
	bl	strlen
	sub	x8, x0, #1              // =1
	cmp	x8, #31                 // =31
	b.hs	.LBB18_16
// %bb.5:
	add	x22, x19, #520          // =520
	mov	x0, x22
	mov	w1, wzr
	bl	mutex_lock_nested
	ldr	x24, [x19, #296]
	add	x23, x19, #296          // =296
	cmp	x24, x23
	b.ne	.LBB18_7
	b	.LBB18_10
.LBB18_6:                               //   in Loop: Header=BB18_7 Depth=1
	ldr	x24, [x24]
	cmp	x24, x23
	b.eq	.LBB18_10
.LBB18_7:                               // =>This Inner Loop Header: Depth=1
	add	x1, x24, #136           // =136
	mov	x0, x20
	bl	strcmp
	cbnz	w0, .LBB18_6
// %bb.8:                               //   in Loop: Header=BB18_7 Depth=1
	ldr	x8, [x21, #168]
	ldr	x9, [x24, #168]
	cmp	x8, x9
	b.ne	.LBB18_6
// %bb.9:
	cbnz	x24, .LBB18_18
.LBB18_10:
	adrp	x1, __cfi_mas_blk_busyidle_handler_latency_check_timer_expire
	adrp	x3, .L.str.52
	adrp	x4, setup_busy_idle_notify_nb.__key
	add	x0, x21, #16            // =16
	add	x1, x1, :lo12:__cfi_mas_blk_busyidle_handler_latency_check_timer_expire
	add	x3, x3, :lo12:.L.str.52
	add	x4, x4, :lo12:setup_busy_idle_notify_nb.__key
	mov	w2, wzr
	bl	init_timer_key
	adrp	x8, __cfi_mas_blk_busyidle_notify_handler
	mov	x24, x21
	add	x8, x8, :lo12:__cfi_mas_blk_busyidle_notify_handler
	mov	x0, x21
	mov	x2, x23
	str	x8, [x24, #112]!
	ldr	x25, [x19, #304]
	orr	w8, wzr, #0x1
	str	wzr, [x21, #128]
	str	w8, [x21, #192]
	mov	x1, x25
	bl	__list_add_valid
	tbz	w0, #0, .LBB18_12
// %bb.11:
	str	x21, [x19, #304]
	stp	x23, x25, [x21]
	str	x21, [x25]
.LBB18_12:
	add	x0, x19, #312           // =312
	mov	x1, x24
	bl	blocking_notifier_chain_register
	adrp	x0, .L.str.49
	add	x0, x0, :lo12:.L.str.49
	mov	x1, x20
	bl	printk
	mov	x0, x22
	bl	mutex_unlock
	mov	w0, wzr
	b	.LBB18_14
.LBB18_13:
	mov	w0, #-12
.LBB18_14:
	ldp	x29, x30, [sp, #64]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]     // 16-byte Folded Reload
	ldr	x25, [sp], #80          // 8-byte Folded Reload
	ret
.LBB18_15:
	adrp	x0, .L.str.50
	add	x0, x0, :lo12:.L.str.50
	b	.LBB18_17
.LBB18_16:
	adrp	x0, .L.str.51
	add	x0, x0, :lo12:.L.str.51
.LBB18_17:
	adrp	x1, .L__func__.is_valid_event_node
	add	x1, x1, :lo12:.L__func__.is_valid_event_node
	bl	printk
	adrp	x0, .L.str.41
	adrp	x1, .L.str.47
	add	x0, x0, :lo12:.L.str.41
	add	x1, x1, :lo12:.L.str.47
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.LBB18_18:
	adrp	x0, .L.str.48
	adrp	x1, .L__func__.mas_blk_busyidle_event_register
	add	x0, x0, :lo12:.L.str.48
	add	x1, x1, :lo12:.L__func__.mas_blk_busyidle_event_register
	mov	x2, x20
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.Lfunc_end18:
	.size	blk_lld_busyidle_event_subscribe, .Lfunc_end18-blk_lld_busyidle_event_subscribe
                                        // -- End function
	.globl	blk_busyidle_event_unsubscribe // -- Begin function blk_busyidle_event_unsubscribe
	.p2align	3
	.type	blk_busyidle_event_unsubscribe,@function
blk_busyidle_event_unsubscribe:         // @blk_busyidle_event_unsubscribe
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	cbz	x19, .LBB19_2
// %bb.1:
	mov	x0, x19
	bl	mas_blk_busyidle_event_unregister
	b	.LBB19_3
.LBB19_2:
	mov	w0, #-22
.LBB19_3:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end19:
	.size	blk_busyidle_event_unsubscribe, .Lfunc_end19-blk_busyidle_event_unsubscribe
                                        // -- End function
	.p2align	3               // -- Begin function mas_blk_busyidle_event_unregister
	.type	mas_blk_busyidle_event_unregister,@function
mas_blk_busyidle_event_unregister:      // @mas_blk_busyidle_event_unregister
// %bb.0:
	stp	x24, x23, [sp, #-64]!   // 16-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	mov	x21, x0
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	bl	_mcount
	ldr	x23, [x21, #48]
	mov	w1, wzr
	add	x19, x23, #520          // =520
	mov	x0, x19
	bl	mutex_lock_nested
	ldr	x20, [x23, #296]
	add	x24, x23, #296          // =296
	cmp	x20, x24
	b.ne	.LBB20_2
	b	.LBB20_5
.LBB20_1:                               //   in Loop: Header=BB20_2 Depth=1
	ldr	x20, [x20]
	cmp	x20, x24
	b.eq	.LBB20_5
.LBB20_2:                               // =>This Inner Loop Header: Depth=1
	add	x22, x20, #136          // =136
	mov	x0, x21
	mov	x1, x22
	bl	strcmp
	cbnz	w0, .LBB20_1
// %bb.3:                               //   in Loop: Header=BB20_2 Depth=1
	ldr	x8, [x21, #32]
	ldr	x9, [x20, #168]
	cmp	x8, x9
	b.ne	.LBB20_1
// %bb.4:
	cbnz	x20, .LBB20_7
.LBB20_5:
	adrp	x0, .L.str.53
	add	x0, x0, :lo12:.L.str.53
	bl	printk
	bl	dump_stack
	mov	w20, #-22
.LBB20_6:
	mov	x0, x19
	bl	mutex_unlock
	mov	w0, w20
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldp	x24, x23, [sp], #64     // 16-byte Folded Reload
	ret
.LBB20_7:
	add	x21, x20, #112          // =112
	add	x0, x23, #312           // =312
	mov	x1, x21
	bl	blocking_notifier_chain_unregister
	adrp	x0, .L.str.54
	add	x0, x0, :lo12:.L.str.54
	mov	x1, x22
	mov	x2, x21
	bl	printk
	mov	x0, x20
	bl	__list_del_entry_valid
	tbz	w0, #0, .LBB20_9
// %bb.8:
	ldp	x8, x9, [x20]
	str	x9, [x8, #8]
	str	x8, [x9]
.LBB20_9:
	mov	x0, x20
	str	x20, [x20]
	str	x20, [x20, #8]
	bl	kfree
	mov	w20, wzr
	b	.LBB20_6
.Lfunc_end20:
	.size	mas_blk_busyidle_event_unregister, .Lfunc_end20-mas_blk_busyidle_event_unregister
                                        // -- End function
	.globl	blk_queue_busyidle_event_unsubscribe // -- Begin function blk_queue_busyidle_event_unsubscribe
	.p2align	3
	.type	blk_queue_busyidle_event_unsubscribe,@function
blk_queue_busyidle_event_unsubscribe:   // @blk_queue_busyidle_event_unsubscribe
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	cbz	x19, .LBB21_2
// %bb.1:
	mov	x0, x19
	bl	mas_blk_busyidle_event_unregister
	b	.LBB21_3
.LBB21_2:
	mov	w0, #-22
.LBB21_3:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end21:
	.size	blk_queue_busyidle_event_unsubscribe, .Lfunc_end21-blk_queue_busyidle_event_unsubscribe
                                        // -- End function
	.globl	blk_mq_tagset_busyidle_enable // -- Begin function blk_mq_tagset_busyidle_enable
	.p2align	3
	.type	blk_mq_tagset_busyidle_enable,@function
blk_mq_tagset_busyidle_enable:          // @blk_mq_tagset_busyidle_enable
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	w20, w1
	mov	x19, x0
	bl	_mcount
	cbz	x19, .LBB22_2
// %bb.1:
	ldr	x8, [x19, #40]
	cmp	w20, #0                 // =0
	orr	x9, x8, #0x8
	and	x8, x8, #0xfffffffffffffff7
	csel	x8, x8, x9, eq
	str	x8, [x19, #40]
.LBB22_2:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end22:
	.size	blk_mq_tagset_busyidle_enable, .Lfunc_end22-blk_mq_tagset_busyidle_enable
                                        // -- End function
	.globl	blk_mq_tagset_hw_idle_notify_enable // -- Begin function blk_mq_tagset_hw_idle_notify_enable
	.p2align	3
	.type	blk_mq_tagset_hw_idle_notify_enable,@function
blk_mq_tagset_hw_idle_notify_enable:    // @blk_mq_tagset_hw_idle_notify_enable
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	w20, w1
	mov	x19, x0
	bl	_mcount
	cbz	x19, .LBB23_2
// %bb.1:
	cmp	w20, #0                 // =0
	cset	w8, ne
	strb	w8, [x19, #96]
.LBB23_2:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end23:
	.size	blk_mq_tagset_hw_idle_notify_enable, .Lfunc_end23-blk_mq_tagset_hw_idle_notify_enable
                                        // -- End function
	.globl	mas_blk_busyidle_state_init // -- Begin function mas_blk_busyidle_state_init
	.p2align	3
	.type	mas_blk_busyidle_state_init,@function
mas_blk_busyidle_state_init:            // @mas_blk_busyidle_state_init
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	adrp	x20, blk_idle_notify_workqueue
	ldr	x8, [x20, :lo12:blk_idle_notify_workqueue]
	cbnz	x8, .LBB24_2
// %bb.1:
	adrp	x0, .L.str.29
	adrp	x3, mas_blk_busyidle_state_init.__key
	adrp	x4, .L.str.28
	add	x0, x0, :lo12:.L.str.29
	add	x3, x3, :lo12:mas_blk_busyidle_state_init.__key
	add	x4, x4, :lo12:.L.str.28
	orr	w1, wzr, #0x18
	mov	w2, wzr
	bl	__alloc_workqueue_key
	str	x0, [x20, :lo12:blk_idle_notify_workqueue]
	cbz	x0, .LBB24_4
.LBB24_2:
	mov	w8, #5
	str	xzr, [x19, #744]
	adrp	x1, .L.str.32
	str	xzr, [x19, #736]
	adrp	x2, mas_blk_busyidle_state_init.__key.31
	str	xzr, [x19, #728]
	str	w8, [x19, #208]
	mov	x8, #68719476704
	add	x0, x19, #40            // =40
	str	xzr, [x19, #720]
	add	x1, x1, :lo12:.L.str.32
	str	xzr, [x19, #712]
	add	x2, x2, :lo12:mas_blk_busyidle_state_init.__key.31
	str	xzr, [x19, #704]
	mov	w3, wzr
	str	xzr, [x19, #696]
	str	xzr, [x19, #688]
	str	xzr, [x19, #680]
	str	xzr, [x19, #672]
	str	xzr, [x19, #664]
	str	xzr, [x19, #656]
	str	xzr, [x19, #648]
	str	x8, [x19, #8]
	str	xzr, [x19, #640]
	str	xzr, [x19, #632]
	bl	lockdep_init_map
	adrp	x9, __cfi_mas_blk_idle_notify_work
	adrp	x1, delayed_work_timer_fn
	adrp	x3, .L.str.34
	adrp	x4, mas_blk_busyidle_state_init.__key.33
	add	x8, x19, #16            // =16
	add	x9, x9, :lo12:__cfi_mas_blk_idle_notify_work
	add	x0, x19, #96            // =96
	add	x1, x1, :lo12:delayed_work_timer_fn
	str	x8, [x19, #16]
	add	x3, x3, :lo12:.L.str.34
	stp	x8, x9, [x19, #24]
	add	x4, x4, :lo12:mas_blk_busyidle_state_init.__key.33
	orr	w2, wzr, #0x200000
	bl	init_timer_key
	adrp	x1, .L.str.36
	str	wzr, [x19, #432]
	adrp	x2, mas_blk_busyidle_state_init.__key.35
	add	x0, x19, #440           // =440
	add	x1, x1, :lo12:.L.str.36
	add	x2, x2, :lo12:mas_blk_busyidle_state_init.__key.35
	bl	__mutex_init
	adrp	x1, .L.str.38
	adrp	x2, mas_blk_busyidle_state_init.__key.37
	add	x8, x19, #216           // =216
	add	x0, x19, #232           // =232
	add	x1, x1, :lo12:.L.str.38
	add	x2, x2, :lo12:mas_blk_busyidle_state_init.__key.37
	str	x8, [x19, #216]
	str	x8, [x19, #224]
	bl	__init_rwsem
	adrp	x1, .L.str.40
	str	xzr, [x19, #424]
	adrp	x2, mas_blk_busyidle_state_init.__key.39
	str	xzr, [x19, #1096]
	orr	w8, wzr, #0x1
	str	xzr, [x19, #1088]
	add	x9, x19, #1104          // =1104
	add	x10, x19, #1120         // =1120
	add	x0, x19, #1136          // =1136
	str	w8, [x19, #624]
	add	x1, x1, :lo12:.L.str.40
	str	x9, [x19, #1104]
	add	x2, x2, :lo12:mas_blk_busyidle_state_init.__key.39
	str	x9, [x19, #1112]
	str	x10, [x19, #1120]
	str	x10, [x19, #1128]
	bl	__raw_spin_lock_init
	mov	w0, wzr
.LBB24_3:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.LBB24_4:
	adrp	x0, .L.str.30
	adrp	x1, .L__func__.mas_blk_busyidle_state_init
	add	x0, x0, :lo12:.L.str.30
	add	x1, x1, :lo12:.L__func__.mas_blk_busyidle_state_init
	bl	printk
	mov	w0, #-12
	b	.LBB24_3
.Lfunc_end24:
	.size	mas_blk_busyidle_state_init, .Lfunc_end24-mas_blk_busyidle_state_init
                                        // -- End function
	.type	.L.str,@object          // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"\0013[BLK-IO]%s: %s process time is more than %u ms\n"
	.size	.L.str, 50

	.type	.L__func__.mas_blk_busyidle_handler_latency_check_timer_expire,@object // @__func__.mas_blk_busyidle_handler_latency_check_timer_expire
.L__func__.mas_blk_busyidle_handler_latency_check_timer_expire:
	.asciz	"mas_blk_busyidle_handler_latency_check_timer_expire"
	.size	.L__func__.mas_blk_busyidle_handler_latency_check_timer_expire, 52

	.type	.L.str.1,@object        // @.str.1
.L.str.1:
	.asciz	"\0013[BLK-IO]%s: %s NULL callback\n"
	.size	.L.str.1, 32

	.type	.L__func__.mas_blk_busyidle_notify_handler,@object // @__func__.mas_blk_busyidle_notify_handler
.L__func__.mas_blk_busyidle_notify_handler:
	.asciz	"mas_blk_busyidle_notify_handler"
	.size	.L__func__.mas_blk_busyidle_notify_handler, 32

	.type	.L.str.2,@object        // @.str.2
.L.str.2:
	.asciz	"\0013[BLK-IO]%s: %s error!\n"
	.size	.L.str.2, 25

	.type	.L.str.3,@object        // @.str.3
.L.str.3:
	.asciz	"\0013[BLK-IO]%s: %s busy idle callback cost %lld ms\n"
	.size	.L.str.3, 50

	.type	blk_idle_notify_workqueue,@object // @blk_idle_notify_workqueue
	.local	blk_idle_notify_workqueue
	.comm	blk_idle_notify_workqueue,8,8
	.type	.L.str.4,@object        // @.str.4
.L.str.4:
	.asciz	"\0013[BLK-IO]%s: busy idle enable\n"
	.size	.L.str.4, 32

	.type	.L__func__.mas_queue_busyidle_enable_store,@object // @__func__.mas_queue_busyidle_enable_store
.L__func__.mas_queue_busyidle_enable_store:
	.asciz	"mas_queue_busyidle_enable_store"
	.size	.L__func__.mas_queue_busyidle_enable_store, 32

	.type	.L.str.5,@object        // @.str.5
.L.str.5:
	.asciz	"\0013[BLK-IO]%s: busy idle disable\n"
	.size	.L.str.5, 33

	.type	.L.str.6,@object        // @.str.6
.L.str.6:
	.asciz	"\0013[BLK-IO]%s: io busy idle statistic result reset!\n"
	.size	.L.str.6, 52

	.type	.L__func__.mas_queue_busyidle_statistic_reset_store,@object // @__func__.mas_queue_busyidle_statistic_reset_store
.L__func__.mas_queue_busyidle_statistic_reset_store:
	.asciz	"mas_queue_busyidle_statistic_reset_store"
	.size	.L__func__.mas_queue_busyidle_statistic_reset_store, 41

	.type	.L.str.7,@object        // @.str.7
.L.str.7:
	.asciz	"Total Busy Time: %lld ms  Total Idle Time: %lld ms\r\n"
	.size	.L.str.7, 53

	.type	.L.str.8,@object        // @.str.8
.L.str.8:
	.asciz	"Total Idle Count: %llu \r\n"
	.size	.L.str.8, 26

	.type	.L.str.9,@object        // @.str.9
.L.str.9:
	.asciz	"block idle interval statistic:\n"
	.size	.L.str.9, 32

	.type	.L.str.10,@object       // @.str.10
.L.str.10:
	.asciz	"max_idle_duration: %lldms\n"
	.size	.L.str.10, 27

	.type	.L.str.11,@object       // @.str.11
.L.str.11:
	.asciz	"less than 100ms: %lld\n"
	.size	.L.str.11, 23

	.type	.L.str.12,@object       // @.str.12
.L.str.12:
	.asciz	"less than 500ms: %lld\n"
	.size	.L.str.12, 23

	.type	.L.str.13,@object       // @.str.13
.L.str.13:
	.asciz	"less than 1s: %lld\n"
	.size	.L.str.13, 20

	.type	.L.str.14,@object       // @.str.14
.L.str.14:
	.asciz	"less than 2s: %lld\n"
	.size	.L.str.14, 20

	.type	.L.str.15,@object       // @.str.15
.L.str.15:
	.asciz	"less than 4s: %lld\n"
	.size	.L.str.15, 20

	.type	.L.str.16,@object       // @.str.16
.L.str.16:
	.asciz	"less than 6s: %lld\n"
	.size	.L.str.16, 20

	.type	.L.str.17,@object       // @.str.17
.L.str.17:
	.asciz	"less than 8s: %lld\n"
	.size	.L.str.17, 20

	.type	.L.str.18,@object       // @.str.18
.L.str.18:
	.asciz	"less than 10s: %lld\n"
	.size	.L.str.18, 21

	.type	.L.str.19,@object       // @.str.19
.L.str.19:
	.asciz	"more than 10s: %lld\n"
	.size	.L.str.19, 21

	.type	.L.str.20,@object       // @.str.20
.L.str.20:
	.asciz	"idle total counts: %llu\n"
	.size	.L.str.20, 25

	.type	.L.str.21,@object       // @.str.21
.L.str.21:
	.asciz	"%s\n"
	.size	.L.str.21, 4

	.type	.L.str.22,@object       // @.str.22
.L.str.22:
	.asciz	"enabled"
	.size	.L.str.22, 8

	.type	.L.str.23,@object       // @.str.23
.L.str.23:
	.asciz	"disabled"
	.size	.L.str.23, 9

	.type	.L.str.24,@object       // @.str.24
.L.str.24:
	.asciz	"idle_state: %s\n"
	.size	.L.str.24, 16

	.type	.L.str.25,@object       // @.str.25
.L.str.25:
	.asciz	"idle"
	.size	.L.str.25, 5

	.type	.L.str.26,@object       // @.str.26
.L.str.26:
	.asciz	"busy"
	.size	.L.str.26, 5

	.type	.L.str.27,@object       // @.str.27
.L.str.27:
	.asciz	"io_count: %d\n"
	.size	.L.str.27, 14

	.type	mas_blk_busyidle_state_init.__key,@object // @mas_blk_busyidle_state_init.__key
	.local	mas_blk_busyidle_state_init.__key
	.comm	mas_blk_busyidle_state_init.__key,8,1
	.type	.L.str.28,@object       // @.str.28
.L.str.28:
	.asciz	"(wq_completion)\"busyidle_notify\""
	.size	.L.str.28, 33

	.type	.L.str.29,@object       // @.str.29
.L.str.29:
	.asciz	"busyidle_notify"
	.size	.L.str.29, 16

	.type	.L.str.30,@object       // @.str.30
.L.str.30:
	.asciz	"\0013[BLK-IO]%s: Failed to alloc workqueue!\n"
	.size	.L.str.30, 42

	.type	.L__func__.mas_blk_busyidle_state_init,@object // @__func__.mas_blk_busyidle_state_init
.L__func__.mas_blk_busyidle_state_init:
	.asciz	"mas_blk_busyidle_state_init"
	.size	.L__func__.mas_blk_busyidle_state_init, 28

	.type	mas_blk_busyidle_state_init.__key.31,@object // @mas_blk_busyidle_state_init.__key.31
	.local	mas_blk_busyidle_state_init.__key.31
	.comm	mas_blk_busyidle_state_init.__key.31,8,1
	.type	.L.str.32,@object       // @.str.32
.L.str.32:
	.asciz	"(work_completion)(&(&blk_idle->idle_notify_worker)->work)"
	.size	.L.str.32, 58

	.type	mas_blk_busyidle_state_init.__key.33,@object // @mas_blk_busyidle_state_init.__key.33
	.local	mas_blk_busyidle_state_init.__key.33
	.comm	mas_blk_busyidle_state_init.__key.33,8,1
	.type	.L.str.34,@object       // @.str.34
.L.str.34:
	.asciz	"&(&blk_idle->idle_notify_worker)->timer"
	.size	.L.str.34, 40

	.type	mas_blk_busyidle_state_init.__key.35,@object // @mas_blk_busyidle_state_init.__key.35
	.local	mas_blk_busyidle_state_init.__key.35
	.comm	mas_blk_busyidle_state_init.__key.35,8,1
	.type	.L.str.36,@object       // @.str.36
.L.str.36:
	.asciz	"&blk_idle->io_count_mutex"
	.size	.L.str.36, 26

	.type	mas_blk_busyidle_state_init.__key.37,@object // @mas_blk_busyidle_state_init.__key.37
	.local	mas_blk_busyidle_state_init.__key.37
	.comm	mas_blk_busyidle_state_init.__key.37,8,1
	.type	.L.str.38,@object       // @.str.38
.L.str.38:
	.asciz	"&(&blk_idle->nh)->rwsem"
	.size	.L.str.38, 24

	.type	mas_blk_busyidle_state_init.__key.39,@object // @mas_blk_busyidle_state_init.__key.39
	.local	mas_blk_busyidle_state_init.__key.39
	.comm	mas_blk_busyidle_state_init.__key.39,8,1
	.type	.L.str.40,@object       // @.str.40
.L.str.40:
	.asciz	"&(&blk_idle->counted_list_lock)->rlock"
	.size	.L.str.40, 39

	.type	.L.str.41,@object       // @.str.41
.L.str.41:
	.asciz	"\0013[BLK-IO]%s\n"
	.size	.L.str.41, 14

	.type	.L.str.42,@object       // @.str.42
.L.str.42:
	.asciz	"Unknown busy idle event!"
	.size	.L.str.42, 25

	.type	.L.str.44,@object       // @.str.44
.L.str.44:
	.asciz	"req_count is zero!"
	.size	.L.str.44, 19

	.type	.L.str.45,@object       // @.str.45
.L.str.45:
	.asciz	"\0013[BLK-IO]%s: io_count has been zero\n"
	.size	.L.str.45, 38

	.type	.L__func__.blk_idle_count,@object // @__func__.blk_idle_count
.L__func__.blk_idle_count:
	.asciz	"blk_idle_count"
	.size	.L__func__.blk_idle_count, 15

	.type	.L.str.46,@object       // @.str.46
.L.str.46:
	.asciz	"bio_count is zero!"
	.size	.L.str.46, 19

	.type	.L.str.47,@object       // @.str.47
.L.str.47:
	.asciz	"Invalid event node!"
	.size	.L.str.47, 20

	.type	.L.str.48,@object       // @.str.48
.L.str.48:
	.asciz	"\0013[BLK-IO]%s: %s has been registered already!\n"
	.size	.L.str.48, 47

	.type	.L__func__.mas_blk_busyidle_event_register,@object // @__func__.mas_blk_busyidle_event_register
.L__func__.mas_blk_busyidle_event_register:
	.asciz	"mas_blk_busyidle_event_register"
	.size	.L__func__.mas_blk_busyidle_event_register, 32

	.type	.L.str.49,@object       // @.str.49
.L.str.49:
	.asciz	"\0013[BLK-IO]%s registered to busy idle\n"
	.size	.L.str.49, 38

	.type	.L.str.50,@object       // @.str.50
.L.str.50:
	.asciz	"\0010[BLK-IO]%s: notifier_callback is NULL\n"
	.size	.L.str.50, 41

	.type	.L__func__.is_valid_event_node,@object // @__func__.is_valid_event_node
.L__func__.is_valid_event_node:
	.asciz	"is_valid_event_node"
	.size	.L__func__.is_valid_event_node, 20

	.type	.L.str.51,@object       // @.str.51
.L.str.51:
	.asciz	"\0010[BLK-IO]%s: Invalid subscriber\n"
	.size	.L.str.51, 34

	.type	setup_busy_idle_notify_nb.__key,@object // @setup_busy_idle_notify_nb.__key
	.local	setup_busy_idle_notify_nb.__key
	.comm	setup_busy_idle_notify_nb.__key,8,1
	.type	.L.str.52,@object       // @.str.52
.L.str.52:
	.asciz	"(&nb->handler_dur_check_timer)"
	.size	.L.str.52, 31

	.type	.L.str.53,@object       // @.str.53
.L.str.53:
	.asciz	"\0013[BLK-IO]Trying to unregister an unregistered event_node!\n"
	.size	.L.str.53, 60

	.type	.L.str.54,@object       // @.str.54
.L.str.54:
	.asciz	"\0013[BLK-IO]%s unregistered from busy idle module 0x%pK\n"
	.size	.L.str.54, 55


	.ident	"Snapdragon LLVM ARM Compiler 8.0.12 for Android NDK (based on llvm.org 7.0+)"
	.section	".note.GNU-stack","",@progbits
