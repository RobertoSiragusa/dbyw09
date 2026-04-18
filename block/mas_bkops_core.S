	.text
	.file	"mas_bkops_core.c"
	.globl	mas_bkops_update_dur    // -- Begin function mas_bkops_update_dur
	.p2align	3
	.type	mas_bkops_update_dur,@function
mas_bkops_update_dur:                   // @mas_bkops_update_dur
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	cbz	x19, .LBB0_6
// %bb.1:
	bl	ktime_get
	ldr	x8, [x19, #56]
	ldr	x9, [x19, #112]
	sub	x8, x0, x8
	cmp	x8, x9
	b.ls	.LBB0_3
// %bb.2:
	str	x8, [x19, #112]
.LBB0_3:
	mov	w9, #57599
	movk	w9, #1525, lsl #16
	cmp	x8, x9
	b.hi	.LBB0_7
// %bb.4:
	ldr	w9, [x19, #128]
	add	w9, w9, #1              // =1
	str	w9, [x19, #128]
	ldr	w9, [x19, #8]
	cbz	w9, .LBB0_6
.LBB0_5:
	ldr	x10, [x19, #120]
	sub	w11, w9, #1             // =1
	madd	x8, x10, x11, x8
	udiv	x8, x8, x9
	str	x8, [x19, #120]
.LBB0_6:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.LBB0_7:
	mov	w9, #25855
	movk	w9, #7629, lsl #16
	cmp	x8, x9
	b.hi	.LBB0_9
// %bb.8:
	ldr	w9, [x19, #132]
	add	w9, w9, #1              // =1
	str	w9, [x19, #132]
	ldr	w9, [x19, #8]
	cbnz	w9, .LBB0_5
	b	.LBB0_6
.LBB0_9:
	mov	w9, #51711
	movk	w9, #15258, lsl #16
	cmp	x8, x9
	b.hi	.LBB0_11
// %bb.10:
	ldr	w9, [x19, #136]
	add	w9, w9, #1              // =1
	str	w9, [x19, #136]
	ldr	w9, [x19, #8]
	cbnz	w9, .LBB0_5
	b	.LBB0_6
.LBB0_11:
	mov	w9, #37887
	movk	w9, #30517, lsl #16
	cmp	x8, x9
	b.hi	.LBB0_13
// %bb.12:
	ldr	w9, [x19, #140]
	add	w9, w9, #1              // =1
	str	w9, [x19, #140]
	ldr	w9, [x19, #8]
	cbnz	w9, .LBB0_5
	b	.LBB0_6
.LBB0_13:
	mov	x9, #61951
	movk	x9, #10757, lsl #16
	movk	x9, #1, lsl #32
	cmp	x8, x9
	b.hi	.LBB0_15
// %bb.14:
	ldr	w9, [x19, #144]
	add	w9, w9, #1              // =1
	str	w9, [x19, #144]
	ldr	w9, [x19, #8]
	cbnz	w9, .LBB0_5
	b	.LBB0_6
.LBB0_15:
	ldr	w9, [x19, #148]
	add	w9, w9, #1              // =1
	str	w9, [x19, #148]
	ldr	w9, [x19, #8]
	cbnz	w9, .LBB0_5
	b	.LBB0_6
.Lfunc_end0:
	.size	mas_bkops_update_dur, .Lfunc_end0-mas_bkops_update_dur
                                        // -- End function
	.globl	mas_bkops_set_status_str // -- Begin function mas_bkops_set_status_str
	.p2align	3
	.type	mas_bkops_set_status_str,@function
mas_bkops_set_status_str:               // @mas_bkops_set_status_str
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x2
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	w21, w1
	mov	x20, x0
	bl	_mcount
	cbz	x20, .LBB1_3
// %bb.1:
	cbz	x19, .LBB1_3
// %bb.2:
	str	w21, [x20, #552]
	str	x19, [x20, #560]
.LBB1_3:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.Lfunc_end1:
	.size	mas_bkops_set_status_str, .Lfunc_end1-mas_bkops_set_status_str
                                        // -- End function
	.globl	bkops_idle_work_func    // -- Begin function bkops_idle_work_func
	.p2align	3
	.type	bkops_idle_work_func,@function
bkops_idle_work_func:                   // @bkops_idle_work_func
// %bb.0:
	sub	sp, sp, #64             // =64
	adrp	x8, __stack_chk_guard
	str	x21, [sp, #16]          // 8-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	str	x8, [sp, #8]
	bl	_mcount
	sub	x19, x19, #32           // =32
	str	wzr, [sp, #4]
	add	x1, sp, #4              // =4
	mov	x0, x19
	bl	mas_bkops_query
	cbnz	w0, .LBB2_12
// %bb.1:
	ldr	x8, [x19, #232]
	ldr	w9, [sp, #4]
	and	x8, x8, #0xfffffffffffffffd
	str	w9, [x19, #304]
	str	x8, [x19, #232]
	cbz	w9, .LBB2_10
// %bb.2:
	ldr	x8, [x19, #232]
	tbnz	w8, #0, .LBB2_10
// %bb.3:
	ldr	x21, [x19, #8]
	bl	ktime_get
	mov	x20, x0
	adrp	x0, bkops_lock
	add	x0, x0, :lo12:bkops_lock
	mov	w1, wzr
	bl	mutex_lock_nested
	adrp	x8, bkops_enabled
	ldrb	w8, [x8, :lo12:bkops_enabled]
	tbz	w8, #0, .LBB2_5
// %bb.4:
	adrp	x0, bkops_lock
	add	x0, x0, :lo12:bkops_lock
	bl	mutex_unlock
	b	.LBB2_9
.LBB2_5:
	ldr	x8, [x21]
	orr	w1, wzr, #0x1
	ldr	x0, [x19, #16]
	blr	x8
	ldr	w8, [x19, #364]
	mov	w21, w0
	adrp	x0, mas_bkops_start.bkops_start_rs
	adrp	x1, .L__func__.mas_bkops_start
	add	x0, x0, :lo12:mas_bkops_start.bkops_start_rs
	add	w8, w8, #1              // =1
	add	x1, x1, :lo12:.L__func__.mas_bkops_start
	str	w8, [x19, #364]
	bl	___ratelimit
	cbnz	w0, .LBB2_13
.LBB2_6:
	bl	ktime_get
	ldr	x9, [x19, #440]
	sub	x8, x0, x20
	str	x0, [x19, #416]
	cmp	x8, x9
	b.ls	.LBB2_8
// %bb.7:
	str	x8, [x19, #440]
.LBB2_8:
	ldr	w9, [x19, #364]
	adrp	x0, bkops_lock
	ldr	x10, [x19, #448]
	add	x0, x0, :lo12:bkops_lock
	sub	w11, w9, #1             // =1
	madd	x8, x10, x11, x8
	udiv	x8, x8, x9
	str	x8, [x19, #448]
	bl	mutex_unlock
	cbnz	w21, .LBB2_14
.LBB2_9:
	add	x8, x19, #232           // =232
	//APP
	// atomic64_or
	prfm	pstl1strm, [x8]
1:	ldxr	x9, [x8]
	orr	x9, x9, #1
	stxr	w10, x9, [x8]
	cbnz	w10, 1b
	//NO_APP
.LBB2_10:
	adrp	x9, __stack_chk_guard
	ldr	x8, [sp, #8]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB2_15
// %bb.11:
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldr	x21, [sp, #16]          // 8-byte Folded Reload
	add	sp, sp, #64             // =64
	ret
.LBB2_12:
	adrp	x0, .L.str
	add	x0, x0, :lo12:.L.str
	bl	printk
	b	.LBB2_10
.LBB2_13:
	ldr	w1, [x19, #364]
	adrp	x0, .L.str.22
	add	x0, x0, :lo12:.L.str.22
	bl	printk
	b	.LBB2_6
.LBB2_14:
	adrp	x0, .L.str.1
	add	x0, x0, :lo12:.L.str.1
	bl	printk
	b	.LBB2_10
.LBB2_15:
	bl	__stack_chk_fail
.Lfunc_end2:
	.size	bkops_idle_work_func, .Lfunc_end2-bkops_idle_work_func
                                        // -- End function
	.p2align	3               // -- Begin function mas_bkops_query
	.type	mas_bkops_query,@function
mas_bkops_query:                        // @mas_bkops_query
// %bb.0:
	stp	x22, x21, [sp, #-48]!   // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x20, x1
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x19, x0
	bl	_mcount
	adrp	x0, bkops_lock
	ldr	x22, [x19, #8]
	add	x0, x0, :lo12:bkops_lock
	mov	w1, wzr
	bl	mutex_lock_nested
	adrp	x8, bkops_enabled
	mov	w21, wzr
	ldrb	w8, [x8, :lo12:bkops_enabled]
	tbnz	w8, #0, .LBB3_11
// %bb.1:
	ldr	w3, [x19, #592]
	cbnz	w3, .LBB3_12
.LBB3_2:
	bl	ktime_get
	ldr	x8, [x19, #16]
	mov	x1, x20
	ldr	x9, [x22, #8]
	mov	x22, x0
	mov	x0, x8
	blr	x9
	adrp	x8, user_manual_gc
	mov	w21, w0
	ldrb	w9, [x8, :lo12:user_manual_gc]
	cbz	w9, .LBB3_5
// %bb.3:
	ldr	w9, [x20]
	cbnz	w9, .LBB3_5
// %bb.4:
	strb	wzr, [x8, :lo12:user_manual_gc]
.LBB3_5:
	ldr	w8, [x19, #380]
	add	w8, w8, #1              // =1
	str	w8, [x19, #380]
	cbnz	w21, .LBB3_8
// %bb.6:
	ldr	w8, [x20]
	ldr	w9, [x19, #552]
	cmp	w8, w9
	b.hs	.LBB3_8
// %bb.7:
	add	x8, x19, x8, lsl #2
	ldr	w9, [x8, #512]
	add	w9, w9, #1              // =1
	str	w9, [x8, #512]
.LBB3_8:
	bl	ktime_get
	ldr	x9, [x19, #424]
	sub	x8, x0, x22
	cmp	x8, x9
	b.ls	.LBB3_10
// %bb.9:
	str	x8, [x19, #424]
.LBB3_10:
	ldr	w9, [x19, #380]
	ldr	x10, [x19, #432]
	sub	w11, w9, #1             // =1
	madd	x8, x10, x11, x8
	udiv	x8, x8, x9
	str	x8, [x19, #432]
.LBB3_11:
	adrp	x0, bkops_lock
	add	x0, x0, :lo12:bkops_lock
	bl	mutex_unlock
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	mov	w0, w21
	ldp	x22, x21, [sp], #48     // 16-byte Folded Reload
	ret
.LBB3_12:
	adrp	x0, .L.str.18
	adrp	x1, .L__func__.mas_bkops_query
	add	x0, x0, :lo12:.L.str.18
	add	x1, x1, :lo12:.L__func__.mas_bkops_query
	mov	w2, #114
	bl	printk
	ldr	w0, [x19, #592]
	bl	msleep
	b	.LBB3_2
.Lfunc_end3:
	.size	mas_bkops_query, .Lfunc_end3-mas_bkops_query
                                        // -- End function
	.globl	bkops_io_busyidle_notify_handler // -- Begin function bkops_io_busyidle_notify_handler
	.p2align	3
	.type	bkops_io_busyidle_notify_handler,@function
bkops_io_busyidle_notify_handler:       // @bkops_io_busyidle_notify_handler
// %bb.0:
	sub	sp, sp, #48             // =48
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	w19, w1
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x20, x0
	bl	_mcount
	ldr	x20, [x20, #40]
	cbz	w19, .LBB4_5
// %bb.1:
	cmp	w19, #1                 // =1
	b.ne	.LBB4_9
// %bb.2:
	ldrb	w8, [x20, #589]
	cbz	w8, .LBB4_11
// %bb.3:
	ldr	x8, [x20, #232]
.LBB4_4:
	and	x8, x8, #0xfffffffffffffffd
	mov	w0, wzr
	str	x8, [x20, #232]
	b	.LBB4_35
.LBB4_5:
	ldr	x8, [x20, #232]
	str	x8, [sp, #8]
	ldr	x8, [sp, #8]
	tbz	w8, #5, .LBB4_17
// %bb.6:
	add	x8, x20, #232           // =232
	//APP
	// atomic64_fetch_andnot
	prfm	pstl1strm, [x8]
1:	ldxr	x9, [x8]
	bic	x10, x9, #32
	stlxr	w11, x10, [x8]
	cbnz	w11, 1b
	dmb ish
	//NO_APP
	tbz	w9, #5, .LBB4_17
// %bb.7:
	add	x0, x20, #32            // =32
	bl	cancel_delayed_work_sync
	tbz	w0, #0, .LBB4_16
// %bb.8:
	ldr	w8, [x20, #384]
	add	w8, w8, #1              // =1
	str	w8, [x20, #384]
	ldr	x8, [x20, #232]
	tbz	w8, #0, .LBB4_17
	b	.LBB4_18
.LBB4_9:
	adrp	x0, bkops_io_busyidle_notify_handler._rs
	adrp	x1, .L__func__.bkops_io_busyidle_notify_handler
	add	x0, x0, :lo12:bkops_io_busyidle_notify_handler._rs
	add	x1, x1, :lo12:.L__func__.bkops_io_busyidle_notify_handler
	bl	___ratelimit
	cbz	w0, .LBB4_35
// %bb.10:
	adrp	x0, .L.str.3
	adrp	x1, .L__func__.bkops_io_busyidle_notify_handler
	add	x0, x0, :lo12:.L.str.3
	add	x1, x1, :lo12:.L__func__.bkops_io_busyidle_notify_handler
	mov	w2, w19
	bl	printk
	b	.LBB4_17
.LBB4_11:
	ldrb	w8, [x20, #590]
	cbnz	w8, .LBB4_34
// %bb.12:
	ldrb	w8, [x20, #232]
	tbnz	w8, #1, .LBB4_34
// %bb.13:
	ldr	w8, [x20, #308]
	cbz	w8, .LBB4_23
// %bb.14:
	ldr	w8, [x20, #304]
	cbz	w8, .LBB4_23
// %bb.15:
	ldr	w8, [x20, #360]
	add	w8, w8, #1              // =1
	str	w8, [x20, #360]
	b	.LBB4_34
.LBB4_16:
	ldr	w8, [x20, #388]
	add	w8, w8, #1              // =1
	str	w8, [x20, #388]
	ldr	x8, [x20, #232]
	tbnz	w8, #0, .LBB4_18
.LBB4_17:
	mov	w0, wzr
	b	.LBB4_35
.LBB4_18:
	ldrb	w8, [x20, #588]
	cbnz	w8, .LBB4_22
// %bb.19:
	adrp	x0, bkops_lock
	add	x0, x0, :lo12:bkops_lock
	mov	w1, wzr
	bl	mutex_lock_nested
	adrp	x8, bkops_enabled
	ldrb	w8, [x8, :lo12:bkops_enabled]
	tbnz	w8, #0, .LBB4_21
// %bb.20:
	ldp	x8, x0, [x20, #8]
	mov	w1, wzr
	ldr	x8, [x8]
	blr	x8
	ldr	w8, [x20, #372]
	add	w8, w8, #1              // =1
	str	w8, [x20, #372]
.LBB4_21:
	adrp	x0, bkops_lock
	add	x0, x0, :lo12:bkops_lock
	bl	mutex_unlock
.LBB4_22:
	add	x8, x20, #232           // =232
	mov	w0, wzr
	//APP
	// atomic64_andnot
	prfm	pstl1strm, [x8]
1:	ldxr	x9, [x8]
	bic	x9, x9, #1
	stxr	w10, x9, [x8]
	cbnz	w10, 1b
	//NO_APP
	b	.LBB4_35
.LBB4_23:
	ldr	x0, [x20, #24]
	bl	mas_blk_get_lld
	ldr	x8, [x20, #232]
	mov	x19, x0
	tbz	w8, #4, .LBB4_27
// %bb.24:
	orr	w0, wzr, #0x1
	bl	ktime_get_with_offset
	bl	ns_to_timespec
	ldr	x8, [x20, #320]
	cbz	x8, .LBB4_36
// %bb.25:
	ldr	x9, [x20, #312]
	sub	x8, x0, x8
	cmp	x8, x9
	b.ge	.LBB4_36
// %bb.26:
	ldr	x8, [x20, #232]
.LBB4_27:
	tbz	w8, #3, .LBB4_29
// %bb.28:
	ldr	x9, [x19, #1304]
	ldp	x11, x10, [x20, #328]
	sub	x10, x9, x10
	cmp	x10, x11
	b.hs	.LBB4_32
.LBB4_29:
	tbz	w8, #2, .LBB4_31
// %bb.30:
	ldr	x9, [x19, #1296]
	ldp	x11, x10, [x20, #344]
	sub	x10, x9, x10
	cmp	x10, x11
	b.hs	.LBB4_33
.LBB4_31:
	adrp	x9, user_manual_gc
	ldrb	w9, [x9, :lo12:user_manual_gc]
	cbnz	w9, .LBB4_34
	b	.LBB4_4
.LBB4_32:
	ldr	w8, [x20, #400]
	str	x9, [x20, #336]
	add	w8, w8, #1              // =1
	str	w8, [x20, #400]
	b	.LBB4_34
.LBB4_33:
	ldr	w8, [x20, #396]
	str	x9, [x20, #352]
	add	w8, w8, #1              // =1
	str	w8, [x20, #396]
.LBB4_34:
	ldr	x8, [x20, #232]!
	orr	x8, x8, #0x2
	adrp	x9, bkops_workqueue_g
	str	x8, [x20]
	//APP
	// atomic64_or
	prfm	pstl1strm, [x20]
1:	ldxr	x8, [x20]
	orr	x8, x8, #32
	stxr	w10, x8, [x20]
	cbnz	w10, 1b
	//NO_APP
	ldr	w0, [x20, #8]
	sub	x20, x20, #200          // =200
	ldr	x19, [x9, :lo12:bkops_workqueue_g]
	bl	__msecs_to_jiffies
	mov	x3, x0
	orr	w0, wzr, #0x8
	mov	x1, x19
	mov	x2, x20
	bl	queue_delayed_work_on
	orr	w0, wzr, #0x1
.LBB4_35:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	add	sp, sp, #48             // =48
	ret
.LBB4_36:
	ldr	w8, [x20, #392]
	str	x0, [x20, #320]
	add	w8, w8, #1              // =1
	str	w8, [x20, #392]
	b	.LBB4_34
.Lfunc_end4:
	.size	bkops_io_busyidle_notify_handler, .Lfunc_end4-bkops_io_busyidle_notify_handler
                                        // -- End function
	.globl	bkops_pm_callback       // -- Begin function bkops_pm_callback
	.p2align	3
	.type	bkops_pm_callback,@function
bkops_pm_callback:                      // @bkops_pm_callback
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	bl	_mcount
	sub	x8, x19, #1             // =1
	cmp	x8, #3                  // =3
	b.hi	.LBB5_4
// %bb.1:
	adrp	x9, .LJTI5_0
	add	x9, x9, :lo12:.LJTI5_0
	adr	x10, .LBB5_2
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
	br	x10
.LBB5_2:
	adrp	x20, bkops_lock
	add	x20, x20, :lo12:bkops_lock
	mov	x0, x20
	mov	w1, wzr
	bl	mutex_lock_nested
	adrp	x8, bkops_enabled
	orr	w19, wzr, #0x1
	mov	x0, x20
	strb	w19, [x8, :lo12:bkops_enabled]
	bl	mutex_unlock
	b	.LBB5_5
.LBB5_3:
	adrp	x19, bkops_lock
	add	x19, x19, :lo12:bkops_lock
	mov	x0, x19
	mov	w1, wzr
	bl	mutex_lock_nested
	adrp	x8, bkops_enabled
	mov	x0, x19
	strb	wzr, [x8, :lo12:bkops_enabled]
	bl	mutex_unlock
	orr	w19, wzr, #0x1
	b	.LBB5_5
.LBB5_4:
	mov	w19, wzr
.LBB5_5:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	mov	w0, w19
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end5:
	.size	bkops_pm_callback, .Lfunc_end5-bkops_pm_callback
	.section	.rodata,"a",@progbits
.LJTI5_0:
	.byte	(.LBB5_2-.LBB5_2)>>2
	.byte	(.LBB5_3-.LBB5_2)>>2
	.byte	(.LBB5_2-.LBB5_2)>>2
	.byte	(.LBB5_3-.LBB5_2)>>2
                                        // -- End function
	.text
	.globl	bkops_notify_reboot     // -- Begin function bkops_notify_reboot
	.p2align	3
	.type	bkops_notify_reboot,@function
bkops_notify_reboot:                    // @bkops_notify_reboot
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	bl	_mcount
	adrp	x19, bkops_lock
	add	x19, x19, :lo12:bkops_lock
	mov	x0, x19
	mov	w1, wzr
	bl	mutex_lock_nested
	adrp	x8, bkops_enabled
	orr	w9, wzr, #0x1
	mov	x0, x19
	strb	w9, [x8, :lo12:bkops_enabled]
	bl	mutex_unlock
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	mov	w0, wzr
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end6:
	.size	bkops_notify_reboot, .Lfunc_end6-bkops_notify_reboot
                                        // -- End function
	.globl	mas_bkops_alloc         // -- Begin function mas_bkops_alloc
	.p2align	3
	.type	mas_bkops_alloc,@function
mas_bkops_alloc:                        // @mas_bkops_alloc
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	bl	_mcount
	adrp	x8, kmalloc_caches
	add	x8, x8, :lo12:kmalloc_caches
	mov	w1, #32960
	movk	w1, #96, lsl #16
	ldr	x0, [x8, #80]
	mov	w2, #600
	bl	kmem_cache_alloc_trace
	mov	x19, x0
	cbz	x0, .LBB7_3
// %bb.1:
	adrp	x1, .L.str.5
	adrp	x2, mas_bkops_alloc.__key
	mov	x8, #68719476704
	add	x0, x19, #64            // =64
	add	x1, x1, :lo12:.L.str.5
	add	x2, x2, :lo12:mas_bkops_alloc.__key
	str	x8, [x19, #32]
	mov	w3, wzr
	bl	lockdep_init_map
	adrp	x9, __ufs_bkops_idle_work_func
	adrp	x1, delayed_work_timer_fn
	adrp	x3, .L.str.7
	adrp	x4, mas_bkops_alloc.__key.6
	add	x8, x19, #40            // =40
	add	x9, x9, :lo12:__ufs_bkops_idle_work_func
	add	x0, x19, #120           // =120
	add	x1, x1, :lo12:delayed_work_timer_fn
	str	x8, [x19, #40]
	add	x3, x3, :lo12:.L.str.7
	stp	x8, x9, [x19, #48]
	add	x4, x4, :lo12:mas_bkops_alloc.__key.6
	orr	w2, wzr, #0x200000
	bl	init_timer_key
	mov	w8, #1000
	mov	w9, #3600
	orr	w10, wzr, #0x20000000
	str	x8, [x19, #240]
	str	x9, [x19, #312]
	str	x10, [x19, #328]
	str	x10, [x19, #344]
.LBB7_2:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	mov	x0, x19
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.LBB7_3:
	adrp	x0, .L.str.4
	add	x0, x0, :lo12:.L.str.4
	bl	printk
	b	.LBB7_2
.Lfunc_end7:
	.size	mas_bkops_alloc, .Lfunc_end7-mas_bkops_alloc
                                        // -- End function
	.globl	mas_bkops_manual_gc_proc_show // -- Begin function mas_bkops_manual_gc_proc_show
	.p2align	3
	.type	mas_bkops_manual_gc_proc_show,@function
mas_bkops_manual_gc_proc_show:          // @mas_bkops_manual_gc_proc_show
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	adrp	x8, user_manual_gc
	adrp	x1, .L.str.8
	add	x1, x1, :lo12:.L.str.8
	ldrb	w2, [x8, :lo12:user_manual_gc]
	mov	x0, x19
	bl	seq_printf
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	mov	w0, wzr
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end8:
	.size	mas_bkops_manual_gc_proc_show, .Lfunc_end8-mas_bkops_manual_gc_proc_show
                                        // -- End function
	.globl	mas_bkops_manual_gc_proc_open // -- Begin function mas_bkops_manual_gc_proc_open
	.p2align	3
	.type	mas_bkops_manual_gc_proc_open,@function
mas_bkops_manual_gc_proc_open:          // @mas_bkops_manual_gc_proc_open
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	bl	_mcount
	adrp	x1, __cfi_mas_bkops_manual_gc_proc_show
	add	x1, x1, :lo12:__cfi_mas_bkops_manual_gc_proc_show
	mov	x0, x19
	mov	x2, xzr
	bl	single_open
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end9:
	.size	mas_bkops_manual_gc_proc_open, .Lfunc_end9-mas_bkops_manual_gc_proc_open
                                        // -- End function
	.globl	mas_bkops_manual_gc_proc_write // -- Begin function mas_bkops_manual_gc_proc_write
	.p2align	3
	.type	mas_bkops_manual_gc_proc_write,@function
mas_bkops_manual_gc_proc_write:         // @mas_bkops_manual_gc_proc_write
// %bb.0:
	sub	sp, sp, #48             // =48
	adrp	x8, __stack_chk_guard
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x19, x2
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	mov	x20, x1
	str	x8, [sp, #8]
	bl	_mcount
	mov	x0, #-22
	cbz	x20, .LBB10_6
// %bb.1:
	cbz	x19, .LBB10_6
// %bb.2:
	adrp	x0, .L.str.24
	mov	w1, #113
	add	x0, x0, :lo12:.L.str.24
	bl	__might_fault
	//APP
	mrs x8, sp_el0
	//NO_APP
	mov	x10, x20
	ldr	x9, [x8, #64]
	//APP
		adds	x10, x10, #1
	csel	x9, xzr, x9, hi
	csinv	x10, x10, xzr, cc
	sbcs	xzr, x10, x9
	cset	x10, ls

	//NO_APP
	cbz	x10, .LBB10_9
// %bb.3:
	ldr	x8, [x8, #64]
	add	x0, sp, #4              // =4
	orr	w2, wzr, #0x1
	//APP
		bics	xzr, x20, x8
	csel	x1, x20, xzr, eq

	//NO_APP
	//APP
	hint #20
	//NO_APP
	bl	__arch_copy_from_user
	cbnz	x0, .LBB10_10
// %bb.4:
	ldrb	w8, [sp, #4]
	sub	w8, w8, #48             // =48
	cmp	w8, #2                  // =2
	b.hs	.LBB10_8
// %bb.5:
	adrp	x9, user_manual_gc
	mov	x0, x19
	strb	w8, [x9, :lo12:user_manual_gc]
.LBB10_6:
	adrp	x9, __stack_chk_guard
	ldr	x8, [sp, #8]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB10_12
// %bb.7:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	add	sp, sp, #48             // =48
	ret
.LBB10_8:
	adrp	x0, .L.str.9
	adrp	x1, .L__func__.mas_bkops_manual_gc_proc_write
	add	x0, x0, :lo12:.L.str.9
	add	x1, x1, :lo12:.L__func__.mas_bkops_manual_gc_proc_write
	mov	w2, #743
	bl	printk
	mov	x0, #-22
	b	.LBB10_6
.LBB10_9:
	orr	w2, wzr, #0x1
	b	.LBB10_11
.LBB10_10:
	mov	x2, x0
.LBB10_11:
	orr	w8, wzr, #0x1
	sub	x8, x8, x2
	add	x9, sp, #4              // =4
	add	x0, x9, x8
	mov	w1, wzr
	bl	memset
	mov	x0, #-14
	b	.LBB10_6
.LBB10_12:
	bl	__stack_chk_fail
.Lfunc_end10:
	.size	mas_bkops_manual_gc_proc_write, .Lfunc_end10-mas_bkops_manual_gc_proc_write
                                        // -- End function
	.globl	mas_bkops_status_proc_show // -- Begin function mas_bkops_status_proc_show
	.p2align	3
	.type	mas_bkops_status_proc_show,@function
mas_bkops_status_proc_show:             // @mas_bkops_status_proc_show
// %bb.0:
	sub	sp, sp, #48             // =48
	adrp	x8, __stack_chk_guard
	str	x19, [sp, #16]          // 8-byte Folded Spill
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x19, x0
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	str	x8, [sp, #8]
	bl	_mcount
	ldr	x0, [x19, #272]
	add	x1, sp, #4              // =4
	str	wzr, [sp, #4]
	bl	mas_bkops_query
	ldr	w2, [sp, #4]
	adrp	x1, .L.str.10
	add	x1, x1, :lo12:.L.str.10
	mov	x0, x19
	bl	seq_printf
	adrp	x9, __stack_chk_guard
	ldr	x8, [sp, #8]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB11_2
// %bb.1:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldr	x19, [sp, #16]          // 8-byte Folded Reload
	mov	w0, wzr
	add	sp, sp, #48             // =48
	ret
.LBB11_2:
	bl	__stack_chk_fail
.Lfunc_end11:
	.size	mas_bkops_status_proc_show, .Lfunc_end11-mas_bkops_status_proc_show
                                        // -- End function
	.globl	mas_bkops_status_proc_open // -- Begin function mas_bkops_status_proc_open
	.p2align	3
	.type	mas_bkops_status_proc_open,@function
mas_bkops_status_proc_open:             // @mas_bkops_status_proc_open
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	mov	x0, x20
	bl	PDE_DATA
	adrp	x1, __cfi_mas_bkops_status_proc_show
	mov	x2, x0
	add	x1, x1, :lo12:__cfi_mas_bkops_status_proc_show
	mov	x0, x19
	bl	single_open
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end12:
	.size	mas_bkops_status_proc_open, .Lfunc_end12-mas_bkops_status_proc_open
                                        // -- End function
	.globl	mas_bkops_enable        // -- Begin function mas_bkops_enable
	.p2align	3
	.type	mas_bkops_enable,@function
mas_bkops_enable:                       // @mas_bkops_enable
// %bb.0:
	stp	x24, x23, [sp, #-64]!   // 16-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	mov	x22, x2
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	x19, x1
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	mov	x20, x0
	bl	_mcount
	mov	w0, #-22
	cbz	x20, .LBB13_19
// %bb.1:
	cbz	x19, .LBB13_19
// %bb.2:
	cbz	x22, .LBB13_19
// %bb.3:
	mov	x0, x20
	bl	mas_blk_get_lld
	ldrb	w8, [x0, #24]
	tbz	w8, #3, .LBB13_23
// %bb.4:
	ldr	w8, [x19]
	sub	w8, w8, #1              // =1
	cmp	w8, #3                  // =3
	b.hs	.LBB13_15
// %bb.5:
	ldr	x8, [x19, #8]
	cbz	x8, .LBB13_16
// %bb.6:
	adrp	x24, mas_bkops_inited
	mov	x21, x0
	ldrb	w8, [x24, :lo12:mas_bkops_inited]
	tbnz	w8, #0, .LBB13_9
// %bb.7:
	adrp	x0, .L.str.26
	adrp	x3, mas_bkops_init.__key
	adrp	x4, .L.str.25
	add	x0, x0, :lo12:.L.str.26
	add	x3, x3, :lo12:mas_bkops_init.__key
	add	x4, x4, :lo12:.L.str.25
	orr	w1, wzr, #0x18
	mov	w2, wzr
	bl	__alloc_workqueue_key
	adrp	x8, bkops_workqueue_g
	str	x0, [x8, :lo12:bkops_workqueue_g]
	cbz	x0, .LBB13_21
// %bb.8:
	adrp	x0, bkops_pm_notifier
	add	x0, x0, :lo12:bkops_pm_notifier
	bl	register_pm_notifier
	adrp	x0, bkops_reboot_notifier
	add	x0, x0, :lo12:bkops_reboot_notifier
	bl	register_reboot_notifier
	orr	w8, wzr, #0x1
	strb	w8, [x24, :lo12:mas_bkops_inited]
.LBB13_9:
	mov	x0, x19
	mov	x1, x22
	add	x23, x19, #248          // =248
	bl	mas_bkops_add_debugfs
	cbnz	w0, .LBB13_20
.LBB13_10:
	adrp	x1, .L.str.16
	str	x20, [x19, #24]
	add	x1, x1, :lo12:.L.str.16
	orr	w2, wzr, #0x20
	mov	x0, x23
	bl	strncpy
	adrp	x8, __cfi_bkops_io_busyidle_notify_handler
	strb	wzr, [x19, #279]
	add	x8, x8, :lo12:__cfi_bkops_io_busyidle_notify_handler
	mov	x0, x21
	mov	x1, x23
	stp	x8, x19, [x19, #280]
	bl	blk_lld_busyidle_event_subscribe
	cbz	w0, .LBB13_13
// %bb.11:
	adrp	x19, bkops_workqueue_g
	ldr	x8, [x19, :lo12:bkops_workqueue_g]
	cbz	x8, .LBB13_18
// %bb.12:
	adrp	x0, bkops_reboot_notifier
	strb	wzr, [x24, :lo12:mas_bkops_inited]
	add	x0, x0, :lo12:bkops_reboot_notifier
	bl	unregister_reboot_notifier
	adrp	x0, bkops_pm_notifier
	add	x0, x0, :lo12:bkops_pm_notifier
	bl	unregister_pm_notifier
	ldr	x0, [x19, :lo12:bkops_workqueue_g]
	bl	destroy_workqueue
	mov	w0, #-22
	str	xzr, [x19, :lo12:bkops_workqueue_g]
	b	.LBB13_19
.LBB13_13:
	adrp	x0, .L.str.27
	add	x0, x0, :lo12:.L.str.27
	mov	x1, xzr
	bl	proc_mkdir
	cbz	x0, .LBB13_22
// %bb.14:
	mov	x20, x0
	adrp	x0, .L.str.29
	adrp	x3, mas_bkops_manual_gc_fops
	add	x0, x0, :lo12:.L.str.29
	add	x3, x3, :lo12:mas_bkops_manual_gc_fops
	mov	w1, #432
	mov	x2, x20
	bl	proc_create
	adrp	x0, .L.str.30
	adrp	x3, mas_bkops_status_fops
	add	x0, x0, :lo12:.L.str.30
	add	x3, x3, :lo12:mas_bkops_status_fops
	mov	w1, #288
	mov	x2, x20
	mov	x4, x19
	bl	proc_create_data
	mov	w0, wzr
	b	.LBB13_19
.LBB13_15:
	adrp	x0, .L.str.12
	add	x0, x0, :lo12:.L.str.12
	b	.LBB13_17
.LBB13_16:
	adrp	x0, .L.str.13
	add	x0, x0, :lo12:.L.str.13
.LBB13_17:
	bl	printk
.LBB13_18:
	mov	w0, #-22
.LBB13_19:
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldp	x24, x23, [sp], #64     // 16-byte Folded Reload
	ret
.LBB13_20:
	adrp	x0, .L.str.15
	add	x0, x0, :lo12:.L.str.15
	bl	printk
	b	.LBB13_10
.LBB13_21:
	adrp	x0, .L.str.14
	adrp	x1, .L__func__.mas_bkops_enable
	add	x0, x0, :lo12:.L.str.14
	add	x1, x1, :lo12:.L__func__.mas_bkops_enable
	mov	w2, #828
	bl	printk
	b	.LBB13_18
.LBB13_22:
	adrp	x0, .L.str.28
	adrp	x1, .L__func__.mas_bkops_manual_gc_proc_init
	add	x0, x0, :lo12:.L.str.28
	add	x1, x1, :lo12:.L__func__.mas_bkops_manual_gc_proc_init
	mov	w2, #790
	bl	printk
	mov	w0, wzr
	b	.LBB13_19
.LBB13_23:
	adrp	x0, .L.str.11
	add	x0, x0, :lo12:.L.str.11
	b	.LBB13_17
.Lfunc_end13:
	.size	mas_bkops_enable, .Lfunc_end13-mas_bkops_enable
                                        // -- End function
	.globl	blk_mq_tagset_tz_query_register // -- Begin function blk_mq_tagset_tz_query_register
	.p2align	3
	.type	blk_mq_tagset_tz_query_register,@function
blk_mq_tagset_tz_query_register:        // @blk_mq_tagset_tz_query_register
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	cbz	x20, .LBB14_2
// %bb.1:
	str	x19, [x20, #80]
.LBB14_2:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end14:
	.size	blk_mq_tagset_tz_query_register, .Lfunc_end14-blk_mq_tagset_tz_query_register
                                        // -- End function
	.globl	blk_lld_tz_query        // -- Begin function blk_lld_tz_query
	.p2align	3
	.type	blk_lld_tz_query,@function
blk_lld_tz_query:                       // @blk_lld_tz_query
// %bb.0:
	stp	x22, x21, [sp, #-48]!   // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	w19, w3
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x20, x2
	mov	w21, w1
	mov	x22, x0
	bl	_mcount
	mov	w0, #-1
	cbz	x22, .LBB15_7
// %bb.1:
	cbz	x20, .LBB15_7
// %bb.2:
	ldr	x8, [x22, #280]
	ldr	x22, [x8, #1712]
	cbz	x22, .LBB15_6
// %bb.3:
	mov	x0, x22
	bl	mas_blk_get_lld
	cbz	x0, .LBB15_6
// %bb.4:
	ldr	x8, [x0, #64]
	cbz	x8, .LBB15_6
// %bb.5:
	mov	x0, x22
	mov	w1, w21
	mov	x2, x20
	mov	w3, w19
	blr	x8
	b	.LBB15_7
.LBB15_6:
	mov	w0, #-1
.LBB15_7:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldp	x22, x21, [sp], #48     // 16-byte Folded Reload
	ret
.Lfunc_end15:
	.size	blk_lld_tz_query, .Lfunc_end15-blk_lld_tz_query
                                        // -- End function
	.globl	blk_mq_tagset_tz_ctrl_register // -- Begin function blk_mq_tagset_tz_ctrl_register
	.p2align	3
	.type	blk_mq_tagset_tz_ctrl_register,@function
blk_mq_tagset_tz_ctrl_register:         // @blk_mq_tagset_tz_ctrl_register
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	cbz	x20, .LBB16_2
// %bb.1:
	str	x19, [x20, #88]
.LBB16_2:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end16:
	.size	blk_mq_tagset_tz_ctrl_register, .Lfunc_end16-blk_mq_tagset_tz_ctrl_register
                                        // -- End function
	.globl	blk_lld_tz_ctrl         // -- Begin function blk_lld_tz_ctrl
	.p2align	3
	.type	blk_lld_tz_ctrl,@function
blk_lld_tz_ctrl:                        // @blk_lld_tz_ctrl
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	w19, w2
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	w20, w1
	mov	x21, x0
	bl	_mcount
	cbz	x21, .LBB17_5
// %bb.1:
	ldr	x8, [x21, #280]
	ldr	x21, [x8, #1712]
	cbz	x21, .LBB17_5
// %bb.2:
	mov	x0, x21
	bl	mas_blk_get_lld
	cbz	x0, .LBB17_5
// %bb.3:
	ldr	x8, [x0, #72]
	cbz	x8, .LBB17_5
// %bb.4:
	mov	x0, x21
	mov	w1, w20
	mov	w2, w19
	blr	x8
	b	.LBB17_6
.LBB17_5:
	mov	w0, #-1
.LBB17_6:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.Lfunc_end17:
	.size	blk_lld_tz_ctrl, .Lfunc_end17-blk_lld_tz_ctrl
                                        // -- End function
	.globl	mas_queue_tz_write_bytes_show // -- Begin function mas_queue_tz_write_bytes_show
	.p2align	3
	.type	mas_queue_tz_write_bytes_show,@function
mas_queue_tz_write_bytes_show:          // @mas_queue_tz_write_bytes_show
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	ldr	x3, [x20, #1904]
	adrp	x2, .L.str.17
	add	x2, x2, :lo12:.L.str.17
	orr	w1, wzr, #0x1000
	mov	x0, x19
	bl	snprintf
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
                                        // kill: def $w0 killed $w0 def $x0
	sxtw	x0, w0
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end18:
	.size	mas_queue_tz_write_bytes_show, .Lfunc_end18-mas_queue_tz_write_bytes_show
                                        // -- End function
	.type	.L.str,@object          // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"\0013[BKOPS]mas_bkops_query failed!\n"
	.size	.L.str, 34

	.type	.L.str.1,@object        // @.str.1
.L.str.1:
	.asciz	"\0013[BKOPS]mas_bkops_start failed!\n"
	.size	.L.str.1, 34

	.type	bkops_workqueue_g,@object // @bkops_workqueue_g
	.local	bkops_workqueue_g
	.comm	bkops_workqueue_g,8,8
	.type	bkops_io_busyidle_notify_handler._rs,@object // @bkops_io_busyidle_notify_handler._rs
	.data
	.p2align	3
bkops_io_busyidle_notify_handler._rs:
	.zero	4
	.word	3735899821              // 0xdead4ead
	.word	4294967295              // 0xffffffff
	.zero	4
	.xword	-1
	.xword	0
	.zero	16
	.xword	.L.str.2
	.word	0                       // 0x0
	.zero	4
	.xword	0                       // 0x0
	.xword	0                       // 0x0
	.word	1250                    // 0x4e2
	.word	10                      // 0xa
	.word	0                       // 0x0
	.word	0                       // 0x0
	.xword	0                       // 0x0
	.xword	0                       // 0x0
	.size	bkops_io_busyidle_notify_handler._rs, 112

	.type	.L.str.2,@object        // @.str.2
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.2:
	.asciz	"_rs.lock"
	.size	.L.str.2, 9

	.type	.L__func__.bkops_io_busyidle_notify_handler,@object // @__func__.bkops_io_busyidle_notify_handler
.L__func__.bkops_io_busyidle_notify_handler:
	.asciz	"bkops_io_busyidle_notify_handler"
	.size	.L__func__.bkops_io_busyidle_notify_handler, 33

	.type	.L.str.3,@object        // @.str.3
.L.str.3:
	.asciz	"\0013[BKOPS]%s unknown state: %d\n"
	.size	.L.str.3, 31

	.type	.L.str.4,@object        // @.str.4
.L.str.4:
	.asciz	"\0013[BKOPS]Failed to alloc bkops_func\n"
	.size	.L.str.4, 37

	.type	mas_bkops_alloc.__key,@object // @mas_bkops_alloc.__key
	.local	mas_bkops_alloc.__key
	.comm	mas_bkops_alloc.__key,8,1
	.type	.L.str.5,@object        // @.str.5
.L.str.5:
	.asciz	"(work_completion)(&(&bkops->bkops_idle_work)->work)"
	.size	.L.str.5, 52

	.type	mas_bkops_alloc.__key.6,@object // @mas_bkops_alloc.__key.6
	.local	mas_bkops_alloc.__key.6
	.comm	mas_bkops_alloc.__key.6,8,1
	.type	.L.str.7,@object        // @.str.7
.L.str.7:
	.asciz	"&(&bkops->bkops_idle_work)->timer"
	.size	.L.str.7, 34

	.type	.L.str.8,@object        // @.str.8
.L.str.8:
	.asciz	"%d\n"
	.size	.L.str.8, 4

	.type	user_manual_gc,@object  // @user_manual_gc
	.local	user_manual_gc
	.comm	user_manual_gc,1,4
	.type	.L.str.9,@object        // @.str.9
.L.str.9:
	.asciz	"\0013[BKOPS]%s %d: input error.\n"
	.size	.L.str.9, 30

	.type	.L__func__.mas_bkops_manual_gc_proc_write,@object // @__func__.mas_bkops_manual_gc_proc_write
.L__func__.mas_bkops_manual_gc_proc_write:
	.asciz	"mas_bkops_manual_gc_proc_write"
	.size	.L__func__.mas_bkops_manual_gc_proc_write, 31

	.type	.L.str.10,@object       // @.str.10
.L.str.10:
	.asciz	"%u\n"
	.size	.L.str.10, 4

	.type	.L.str.11,@object       // @.str.11
.L.str.11:
	.asciz	"\0013[BKOPS]Busy Idle was not enabled!\n"
	.size	.L.str.11, 37

	.type	.L.str.12,@object       // @.str.12
.L.str.12:
	.asciz	"\0013[BKOPS]bkops dev type not specified!\n"
	.size	.L.str.12, 40

	.type	.L.str.13,@object       // @.str.13
.L.str.13:
	.asciz	"\0013[BKOPS]bkops_ops is NULL!\n"
	.size	.L.str.13, 29

	.type	.L.str.14,@object       // @.str.14
.L.str.14:
	.asciz	"\0013[BKOPS]%s %d mas_bkops_init failed!\n"
	.size	.L.str.14, 39

	.type	.L__func__.mas_bkops_enable,@object // @__func__.mas_bkops_enable
.L__func__.mas_bkops_enable:
	.asciz	"mas_bkops_enable"
	.size	.L__func__.mas_bkops_enable, 17

	.type	.L.str.15,@object       // @.str.15
.L.str.15:
	.asciz	"\0013[BKOPS]Failed to create mmc bkops debugfs!\n"
	.size	.L.str.15, 46

	.type	.L.str.16,@object       // @.str.16
.L.str.16:
	.asciz	"mas_bkops"
	.size	.L.str.16, 10

	.type	.L.str.17,@object       // @.str.17
.L.str.17:
	.asciz	"tz_write_bytes: %lu\n"
	.size	.L.str.17, 21

	.type	bkops_lock,@object      // @bkops_lock
	.data
	.p2align	3
bkops_lock:
	.zero	8
	.zero	4
	.word	3735899821              // 0xdead4ead
	.word	4294967295              // 0xffffffff
	.zero	4
	.xword	-1
	.xword	0
	.zero	16
	.xword	.L.str.19
	.word	0                       // 0x0
	.zero	4
	.xword	0                       // 0x0
	.xword	0                       // 0x0
	.zero	4
	.zero	4
	.xword	bkops_lock+96
	.xword	bkops_lock+96
	.xword	bkops_lock
	.xword	0
	.zero	16
	.xword	.L.str.20
	.word	0                       // 0x0
	.zero	4
	.xword	0                       // 0x0
	.xword	0                       // 0x0
	.xword	0
	.size	bkops_lock, 184

	.type	bkops_enabled,@object   // @bkops_enabled
	.local	bkops_enabled
	.comm	bkops_enabled,1,1
	.type	.L.str.18,@object       // @.str.18
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.18:
	.asciz	"\0013[BKOPS]%s %d simulate bkops query delay %u ms\n"
	.size	.L.str.18, 49

	.type	.L__func__.mas_bkops_query,@object // @__func__.mas_bkops_query
.L__func__.mas_bkops_query:
	.asciz	"mas_bkops_query"
	.size	.L__func__.mas_bkops_query, 16

	.type	.L.str.19,@object       // @.str.19
.L.str.19:
	.asciz	"bkops_lock.wait_lock"
	.size	.L.str.19, 21

	.type	.L.str.20,@object       // @.str.20
.L.str.20:
	.asciz	"bkops_lock"
	.size	.L.str.20, 11

	.type	mas_bkops_start.bkops_start_rs,@object // @mas_bkops_start.bkops_start_rs
	.data
	.p2align	3
mas_bkops_start.bkops_start_rs:
	.zero	4
	.word	3735899821              // 0xdead4ead
	.word	4294967295              // 0xffffffff
	.zero	4
	.xword	-1
	.xword	0
	.zero	16
	.xword	.L.str.21
	.word	0                       // 0x0
	.zero	4
	.xword	0                       // 0x0
	.xword	0                       // 0x0
	.word	15000                   // 0x3a98
	.word	1                       // 0x1
	.word	0                       // 0x0
	.word	0                       // 0x0
	.xword	0                       // 0x0
	.xword	0                       // 0x0
	.size	mas_bkops_start.bkops_start_rs, 112

	.type	.L.str.21,@object       // @.str.21
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.21:
	.asciz	"bkops_start_rs.lock"
	.size	.L.str.21, 20

	.type	.L__func__.mas_bkops_start,@object // @__func__.mas_bkops_start
.L__func__.mas_bkops_start:
	.asciz	"mas_bkops_start"
	.size	.L__func__.mas_bkops_start, 16

	.type	.L.str.22,@object       // @.str.22
.L.str.22:
	.asciz	"\0016[BKOPS]bkops_start_count: %u\n"
	.size	.L.str.22, 32

	.type	.L.str.24,@object       // @.str.24
.L.str.24:
	.asciz	"/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/include/linux/uaccess.h"
	.size	.L.str.24, 117

	.type	mas_bkops_inited,@object // @mas_bkops_inited
	.local	mas_bkops_inited
	.comm	mas_bkops_inited,1,4
	.type	mas_bkops_init.__key,@object // @mas_bkops_init.__key
	.local	mas_bkops_init.__key
	.comm	mas_bkops_init.__key,8,1
	.type	.L.str.25,@object       // @.str.25
.L.str.25:
	.asciz	"(wq_completion)\"bkops_workqueue\""
	.size	.L.str.25, 33

	.type	.L.str.26,@object       // @.str.26
.L.str.26:
	.asciz	"bkops_workqueue"
	.size	.L.str.26, 16

	.type	bkops_pm_notifier,@object // @bkops_pm_notifier
	.data
	.p2align	3
bkops_pm_notifier:
	.xword	__cfi_bkops_pm_callback
	.xword	0
	.word	0                       // 0x0
	.zero	4
	.size	bkops_pm_notifier, 24

	.type	bkops_reboot_notifier,@object // @bkops_reboot_notifier
	.p2align	3
bkops_reboot_notifier:
	.xword	__cfi_bkops_notify_reboot
	.xword	0
	.word	2147483647              // 0x7fffffff
	.zero	4
	.size	bkops_reboot_notifier, 24

	.type	.L.str.27,@object       // @.str.27
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.27:
	.asciz	"block"
	.size	.L.str.27, 6

	.type	.L.str.28,@object       // @.str.28
.L.str.28:
	.asciz	"\0013[BKOPS]%s %d: proc mk error.\n"
	.size	.L.str.28, 32

	.type	.L__func__.mas_bkops_manual_gc_proc_init,@object // @__func__.mas_bkops_manual_gc_proc_init
.L__func__.mas_bkops_manual_gc_proc_init:
	.asciz	"mas_bkops_manual_gc_proc_init"
	.size	.L__func__.mas_bkops_manual_gc_proc_init, 30

	.type	.L.str.29,@object       // @.str.29
.L.str.29:
	.asciz	"manual_gc"
	.size	.L.str.29, 10

	.type	mas_bkops_manual_gc_fops,@object // @mas_bkops_manual_gc_fops
	.section	.rodata,"a",@progbits
	.p2align	3
mas_bkops_manual_gc_fops:
	.xword	0
	.xword	seq_lseek
	.xword	seq_read
	.xword	__cfi_mas_bkops_manual_gc_proc_write
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0                       // 0x0
	.xword	__cfi_mas_bkops_manual_gc_proc_open
	.xword	0
	.xword	single_release
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.size	mas_bkops_manual_gc_fops, 256

	.type	.L.str.30,@object       // @.str.30
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.30:
	.asciz	"status"
	.size	.L.str.30, 7

	.type	mas_bkops_status_fops,@object // @mas_bkops_status_fops
	.section	.rodata,"a",@progbits
	.p2align	3
mas_bkops_status_fops:
	.xword	0
	.xword	seq_lseek
	.xword	seq_read
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0                       // 0x0
	.xword	__cfi_mas_bkops_status_proc_open
	.xword	0
	.xword	single_release
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.xword	0
	.size	mas_bkops_status_fops, 256


	.ident	"Snapdragon LLVM ARM Compiler 8.0.12 for Android NDK (based on llvm.org 7.0+)"
	.section	".note.GNU-stack","",@progbits
