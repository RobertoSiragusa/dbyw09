	.text
	.file	"mas_blk_mq_tag.c"
	.globl	ufs_tagset_tag_busy_iter // -- Begin function ufs_tagset_tag_busy_iter
	.p2align	3
	.type	ufs_tagset_tag_busy_iter,@function
ufs_tagset_tag_busy_iter:               // @ufs_tagset_tag_busy_iter
// %bb.0:
	stp	x28, x27, [sp, #-96]!   // 16-byte Folded Spill
	stp	x26, x25, [sp, #16]     // 16-byte Folded Spill
	stp	x24, x23, [sp, #32]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #48]     // 16-byte Folded Spill
	mov	x21, x0
	stp	x20, x19, [sp, #64]     // 16-byte Folded Spill
	mov	x19, x2
	stp	x29, x30, [sp, #80]     // 16-byte Folded Spill
	add	x29, sp, #80            // =80
	mov	x20, x1
	bl	_mcount
	ldr	x25, [x21, #560]
	ldr	w8, [x25, #40]
	cbz	w8, .LBB0_17
// %bb.1:
	cbz	x20, .LBB0_11
// %bb.2:
	mov	w26, wzr
	mov	w27, wzr
.LBB0_3:                                // =>This Loop Header: Depth=1
                                        //     Child Loop BB0_6 Depth 2
	ldr	x9, [x25, #56]
	mov	w10, w26
	sub	w8, w8, w27
	add	x22, x9, x10, lsl #6
	ldr	w9, [x22, #8]
	ldr	x10, [x22]
	cmp	w8, w9
	csel	w28, w9, w8, hi
	add	w27, w28, w27
	cbz	x10, .LBB0_10
// %bb.4:                               //   in Loop: Header=BB0_3 Depth=1
	mov	w23, w28
	mov	x0, x22
	mov	x1, x23
	mov	x2, xzr
	b	.LBB0_6
.LBB0_5:                                //   in Loop: Header=BB0_6 Depth=2
	add	w2, w24, #1             // =1
	mov	x0, x22
	mov	x1, x23
.LBB0_6:                                //   Parent Loop BB0_3 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	bl	find_next_bit
	mov	x24, x0
	cmp	w28, w24
	b.ls	.LBB0_10
// %bb.7:                               //   in Loop: Header=BB0_6 Depth=2
	ldr	w8, [x25, #44]
	ldr	x9, [x21, #560]
	lsl	w8, w26, w8
	ldr	x9, [x9, #208]
	add	w8, w8, w24
	ldr	x1, [x9, w8, uxtw #3]
	cbz	x1, .LBB0_5
// %bb.8:                               //   in Loop: Header=BB0_6 Depth=2
	ldr	x8, [x1]
	ldr	x9, [x21, #360]
	cmp	x8, x9
	b.ne	.LBB0_5
// %bb.9:                               //   in Loop: Header=BB0_6 Depth=2
	mov	x0, x21
	mov	x2, x19
	mov	w3, wzr
	blr	x20
	b	.LBB0_5
.LBB0_10:                               //   in Loop: Header=BB0_3 Depth=1
	ldr	w9, [x25, #48]
	add	w10, w26, #1            // =1
	ldr	w8, [x25, #40]
	cmp	w10, w9
	csinc	w26, wzr, w26, hs
	cmp	w8, w27
	b.hi	.LBB0_3
	b	.LBB0_17
.LBB0_11:
	mov	w24, wzr
	mov	w26, wzr
.LBB0_12:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB0_15 Depth 2
	ldr	x9, [x25, #56]
	mov	w10, w24
	sub	w8, w8, w26
	add	x22, x9, x10, lsl #6
	ldr	w9, [x22, #8]
	ldr	x10, [x22]
	cmp	w8, w9
	csel	w27, w9, w8, hi
	add	w26, w27, w26
	cbz	x10, .LBB0_16
// %bb.13:                              //   in Loop: Header=BB0_12 Depth=1
	mov	w23, w27
	mov	x0, x22
	mov	x1, x23
	mov	x2, xzr
	b	.LBB0_15
.LBB0_14:                               //   in Loop: Header=BB0_15 Depth=2
	add	w2, w0, #1              // =1
	mov	x0, x22
	mov	x1, x23
.LBB0_15:                               //   Parent Loop BB0_12 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	bl	find_next_bit
	cmp	w27, w0
	b.hi	.LBB0_14
.LBB0_16:                               //   in Loop: Header=BB0_12 Depth=1
	ldr	w9, [x25, #48]
	add	w10, w24, #1            // =1
	ldr	w8, [x25, #40]
	cmp	w10, w9
	csinc	w24, wzr, w24, hs
	cmp	w8, w26
	b.hi	.LBB0_12
.LBB0_17:
	ldr	w8, [x25, #8]
	cbz	w8, .LBB0_35
// %bb.18:
	ldr	w8, [x25, #152]
	cbz	w8, .LBB0_35
// %bb.19:
	cbz	x20, .LBB0_29
// %bb.20:
	mov	w26, wzr
	mov	w27, wzr
.LBB0_21:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB0_24 Depth 2
	ldr	x9, [x25, #168]
	mov	w10, w26
	sub	w8, w8, w27
	add	x22, x9, x10, lsl #6
	ldr	w9, [x22, #8]
	ldr	x10, [x22]
	cmp	w8, w9
	csel	w28, w9, w8, hi
	add	w27, w28, w27
	cbz	x10, .LBB0_28
// %bb.22:                              //   in Loop: Header=BB0_21 Depth=1
	mov	w23, w28
	mov	x0, x22
	mov	x1, x23
	mov	x2, xzr
	b	.LBB0_24
.LBB0_23:                               //   in Loop: Header=BB0_24 Depth=2
	add	w2, w24, #1             // =1
	mov	x0, x22
	mov	x1, x23
.LBB0_24:                               //   Parent Loop BB0_21 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	bl	find_next_bit
	mov	x24, x0
	cmp	w28, w24
	b.ls	.LBB0_28
// %bb.25:                              //   in Loop: Header=BB0_24 Depth=2
	ldr	x8, [x21, #560]
	ldr	w9, [x25, #156]
	ldr	w10, [x8, #20]
	lsl	w9, w26, w9
	ldr	x8, [x8, #208]
	add	w9, w9, w24
	add	w9, w9, w10
	ldr	x1, [x8, w9, uxtw #3]
	cbz	x1, .LBB0_23
// %bb.26:                              //   in Loop: Header=BB0_24 Depth=2
	ldr	x8, [x1]
	ldr	x9, [x21, #360]
	cmp	x8, x9
	b.ne	.LBB0_23
// %bb.27:                              //   in Loop: Header=BB0_24 Depth=2
	mov	x0, x21
	mov	x2, x19
	mov	w3, wzr
	blr	x20
	b	.LBB0_23
.LBB0_28:                               //   in Loop: Header=BB0_21 Depth=1
	ldr	w9, [x25, #160]
	add	w10, w26, #1            // =1
	ldr	w8, [x25, #152]
	cmp	w10, w9
	csinc	w26, wzr, w26, hs
	cmp	w8, w27
	b.hi	.LBB0_21
	b	.LBB0_35
.LBB0_29:
	mov	w24, wzr
	mov	w26, wzr
.LBB0_30:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB0_33 Depth 2
	ldr	x9, [x25, #168]
	mov	w10, w24
	sub	w8, w8, w26
	add	x22, x9, x10, lsl #6
	ldr	w9, [x22, #8]
	ldr	x10, [x22]
	cmp	w8, w9
	csel	w27, w9, w8, hi
	add	w26, w27, w26
	cbz	x10, .LBB0_34
// %bb.31:                              //   in Loop: Header=BB0_30 Depth=1
	mov	w23, w27
	mov	x0, x22
	mov	x1, x23
	mov	x2, xzr
	b	.LBB0_33
.LBB0_32:                               //   in Loop: Header=BB0_33 Depth=2
	add	w2, w0, #1              // =1
	mov	x0, x22
	mov	x1, x23
.LBB0_33:                               //   Parent Loop BB0_30 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	bl	find_next_bit
	cmp	w27, w0
	b.hi	.LBB0_32
.LBB0_34:                               //   in Loop: Header=BB0_30 Depth=1
	ldr	w9, [x25, #160]
	add	w10, w24, #1            // =1
	ldr	w8, [x25, #152]
	cmp	w10, w9
	csinc	w24, wzr, w24, hs
	cmp	w8, w26
	b.hi	.LBB0_30
.LBB0_35:
	ldr	w8, [x25, #4]
	cbz	w8, .LBB0_53
// %bb.36:
	ldr	w8, [x25, #96]
	cbz	w8, .LBB0_53
// %bb.37:
	cbz	x20, .LBB0_47
// %bb.38:
	mov	w26, wzr
	mov	w27, wzr
.LBB0_39:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB0_42 Depth 2
	ldr	x9, [x25, #112]
	mov	w10, w26
	sub	w8, w8, w27
	add	x22, x9, x10, lsl #6
	ldr	w9, [x22, #8]
	ldr	x10, [x22]
	cmp	w8, w9
	csel	w28, w9, w8, hi
	add	w27, w28, w27
	cbz	x10, .LBB0_46
// %bb.40:                              //   in Loop: Header=BB0_39 Depth=1
	mov	w23, w28
	mov	x0, x22
	mov	x1, x23
	mov	x2, xzr
	b	.LBB0_42
.LBB0_41:                               //   in Loop: Header=BB0_42 Depth=2
	add	w2, w24, #1             // =1
	mov	x0, x22
	mov	x1, x23
.LBB0_42:                               //   Parent Loop BB0_39 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	bl	find_next_bit
	mov	x24, x0
	cmp	w28, w24
	b.ls	.LBB0_46
// %bb.43:                              //   in Loop: Header=BB0_42 Depth=2
	ldr	x8, [x21, #560]
	ldr	w9, [x25, #100]
	ldr	w10, [x8, #16]
	lsl	w9, w26, w9
	ldr	x8, [x8, #208]
	add	w9, w9, w24
	add	w9, w9, w10
	ldr	x1, [x8, w9, uxtw #3]
	cbz	x1, .LBB0_41
// %bb.44:                              //   in Loop: Header=BB0_42 Depth=2
	ldr	x8, [x1]
	ldr	x9, [x21, #360]
	cmp	x8, x9
	b.ne	.LBB0_41
// %bb.45:                              //   in Loop: Header=BB0_42 Depth=2
	orr	w3, wzr, #0x1
	mov	x0, x21
	mov	x2, x19
	blr	x20
	b	.LBB0_41
.LBB0_46:                               //   in Loop: Header=BB0_39 Depth=1
	ldr	w9, [x25, #104]
	add	w10, w26, #1            // =1
	ldr	w8, [x25, #96]
	cmp	w10, w9
	csinc	w26, wzr, w26, hs
	cmp	w8, w27
	b.hi	.LBB0_39
	b	.LBB0_53
.LBB0_47:
	mov	w21, wzr
	mov	w22, wzr
.LBB0_48:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB0_51 Depth 2
	ldr	x9, [x25, #112]
	mov	w10, w21
	sub	w8, w8, w22
	add	x19, x9, x10, lsl #6
	ldr	w9, [x19, #8]
	ldr	x10, [x19]
	cmp	w8, w9
	csel	w23, w9, w8, hi
	add	w22, w23, w22
	cbz	x10, .LBB0_52
// %bb.49:                              //   in Loop: Header=BB0_48 Depth=1
	mov	w20, w23
	mov	x0, x19
	mov	x1, x20
	mov	x2, xzr
	b	.LBB0_51
.LBB0_50:                               //   in Loop: Header=BB0_51 Depth=2
	add	w2, w0, #1              // =1
	mov	x0, x19
	mov	x1, x20
.LBB0_51:                               //   Parent Loop BB0_48 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	bl	find_next_bit
	cmp	w23, w0
	b.hi	.LBB0_50
.LBB0_52:                               //   in Loop: Header=BB0_48 Depth=1
	ldr	w9, [x25, #104]
	add	w10, w21, #1            // =1
	ldr	w8, [x25, #96]
	cmp	w10, w9
	csinc	w21, wzr, w21, hs
	cmp	w8, w22
	b.hi	.LBB0_48
.LBB0_53:
	ldp	x29, x30, [sp, #80]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]     // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]     // 16-byte Folded Reload
	ldp	x28, x27, [sp], #96     // 16-byte Folded Reload
	ret
.Lfunc_end0:
	.size	ufs_tagset_tag_busy_iter, .Lfunc_end0-ufs_tagset_tag_busy_iter
                                        // -- End function
	.globl	ufs_tagset_bt_get       // -- Begin function ufs_tagset_bt_get
	.p2align	3
	.type	ufs_tagset_bt_get,@function
ufs_tagset_bt_get:                      // @ufs_tagset_bt_get
// %bb.0:
	sub	sp, sp, #160            // =160
	adrp	x8, __stack_chk_guard
	stp	x28, x27, [sp, #64]     // 16-byte Folded Spill
	stp	x26, x25, [sp, #80]     // 16-byte Folded Spill
	stp	x24, x23, [sp, #96]     // 16-byte Folded Spill
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	stp	x22, x21, [sp, #112]    // 16-byte Folded Spill
	mov	x21, x2
	stp	x20, x19, [sp, #128]    // 16-byte Folded Spill
	mov	x20, x1
	stp	x29, x30, [sp, #144]    // 16-byte Folded Spill
	add	x29, sp, #144           // =144
	mov	x19, x0
	str	x8, [sp, #56]
	bl	_mcount
	cbz	x21, .LBB1_41
// %bb.1:
	ldr	x8, [x19, #16]
	mov	w24, #4096
	movk	w24, #32, lsl #16
	tbnz	w8, #24, .LBB1_6
// %bb.2:
	and	x8, x8, x24
	cbz	x8, .LBB1_6
// %bb.3:
	mov	x0, x19
	bl	ufs_mq_vip_tag_wait_cnt
	cbz	w0, .LBB1_6
// %bb.4:
	ldr	x8, [x19, #32]
	cbz	x8, .LBB1_7
// %bb.5:
	bl	ktime_get
	ldr	x8, [x19, #32]
	mov	w9, #25856
	movk	w9, #7629, lsl #16
	add	x8, x8, x9
	cmp	x0, x8
	b.le	.LBB1_7
.LBB1_6:
	mov	x0, x20
	bl	__sbitmap_queue_get
	mov	w23, w0
	cmn	w0, #1                  // =1
	b.ne	.LBB1_42
.LBB1_7:
	str	wzr, [sp, #16]
	add	x8, sp, #16             // =16
	ldr	x25, [x19, #16]
	add	x9, x8, #24             // =24
	adrp	x8, autoremove_wake_function
	//APP
	mrs x26, sp_el0
	//NO_APP
	add	x8, x8, :lo12:autoremove_wake_function
	stp	x9, x9, [sp, #40]
	stp	x26, x8, [sp, #24]
	mov	x8, x25
	tbz	w25, #24, .LBB1_9
// %bb.8:
	mov	x0, x19
	bl	ufs_mq_inc_vip_wait_cnt
	ldr	x8, [x19, #16]
.LBB1_9:
	tbnz	w8, #24, .LBB1_12
// %bb.10:
	and	x8, x8, x24
	cbz	x8, .LBB1_12
// %bb.11:
	bl	ktime_get
	str	x0, [x19, #32]
.LBB1_12:
	ldr	x8, [x20, #40]
	add	x22, x8, #8             // =8
	tbz	w25, #11, .LBB1_44
// %bb.13:
	mov	w28, #25856
	adrp	x27, __per_cpu_offset
	and	x8, x25, x24
	movk	w28, #7629, lsl #16
	add	x27, x27, :lo12:__per_cpu_offset
	str	x8, [sp, #8]            // 8-byte Folded Spill
	b	.LBB1_15
.LBB1_14:                               //   in Loop: Header=BB1_15 Depth=1
	add	x1, sp, #16             // =16
	mov	x0, x22
	bl	finish_wait
.LBB1_15:                               // =>This Inner Loop Header: Depth=1
	add	x1, sp, #16             // =16
	orr	w2, wzr, #0x2
	mov	x0, x22
	bl	prepare_to_wait
	ldr	x8, [x19, #16]
	tbnz	w8, #24, .LBB1_20
// %bb.16:                              //   in Loop: Header=BB1_15 Depth=1
	and	x8, x8, x24
	cbz	x8, .LBB1_20
// %bb.17:                              //   in Loop: Header=BB1_15 Depth=1
	mov	x0, x19
	bl	ufs_mq_vip_tag_wait_cnt
	cbz	w0, .LBB1_20
// %bb.18:                              //   in Loop: Header=BB1_15 Depth=1
	ldr	x8, [x19, #32]
	cbz	x8, .LBB1_21
// %bb.19:                              //   in Loop: Header=BB1_15 Depth=1
	bl	ktime_get
	ldr	x8, [x19, #32]
	add	x8, x8, x28
	cmp	x0, x8
	b.le	.LBB1_21
.LBB1_20:                               //   in Loop: Header=BB1_15 Depth=1
	mov	x0, x20
	bl	__sbitmap_queue_get
	cmn	w0, #1                  // =1
	b.ne	.LBB1_72
.LBB1_21:                               //   in Loop: Header=BB1_15 Depth=1
	mov	x0, x21
	mov	w1, wzr
	bl	blk_mq_run_hw_queue
	ldr	x8, [x19, #16]
	tbnz	w8, #24, .LBB1_26
// %bb.22:                              //   in Loop: Header=BB1_15 Depth=1
	and	x8, x8, x24
	cbz	x8, .LBB1_26
// %bb.23:                              //   in Loop: Header=BB1_15 Depth=1
	mov	x0, x19
	bl	ufs_mq_vip_tag_wait_cnt
	cbz	w0, .LBB1_26
// %bb.24:                              //   in Loop: Header=BB1_15 Depth=1
	ldr	x8, [x19, #32]
	cbz	x8, .LBB1_27
// %bb.25:                              //   in Loop: Header=BB1_15 Depth=1
	bl	ktime_get
	ldr	x8, [x19, #32]
	add	x8, x8, x28
	cmp	x0, x8
	b.le	.LBB1_27
.LBB1_26:                               //   in Loop: Header=BB1_15 Depth=1
	mov	x0, x20
	bl	__sbitmap_queue_get
	cmn	w0, #1                  // =1
	b.ne	.LBB1_72
.LBB1_27:                               //   in Loop: Header=BB1_15 Depth=1
	ldr	x8, [x19, #48]
	ldr	x8, [x8, #208]
	ldr	x8, [x8, #2304]
	cbz	x8, .LBB1_33
// %bb.28:                              //   in Loop: Header=BB1_15 Depth=1
	ldr	x8, [x8, #80]
	cbz	x8, .LBB1_33
// %bb.29:                              //   in Loop: Header=BB1_15 Depth=1
	blr	x8
	ldr	x8, [x19, #16]
	tbnz	w8, #24, .LBB1_36
.LBB1_30:                               //   in Loop: Header=BB1_15 Depth=1
	and	x8, x8, x24
	cbz	x8, .LBB1_36
// %bb.31:                              //   in Loop: Header=BB1_15 Depth=1
	orr	w0, wzr, #0x1
	bl	io_schedule_timeout
	cbnz	x0, .LBB1_37
// %bb.32:                              //   in Loop: Header=BB1_15 Depth=1
	mov	x0, x19
	bl	reset_vip_wait_cnt
	b	.LBB1_37
.LBB1_33:                               //   in Loop: Header=BB1_15 Depth=1
	orr	w0, wzr, #0x1
	//APP
	//NO_APP
	bl	preempt_count_sub
	ldr	w8, [x26, #72]
	cbnz	w8, .LBB1_35
// %bb.34:                              //   in Loop: Header=BB1_15 Depth=1
	ldr	x8, [x26]
	tbnz	w8, #1, .LBB1_40
.LBB1_35:                               //   in Loop: Header=BB1_15 Depth=1
	ldr	x8, [x19, #16]
	tbz	w8, #24, .LBB1_30
.LBB1_36:                               //   in Loop: Header=BB1_15 Depth=1
	bl	io_schedule
.LBB1_37:                               //   in Loop: Header=BB1_15 Depth=1
	ldr	x23, [x19]
	orr	w0, wzr, #0x1
	bl	preempt_count_add
	//APP
	//NO_APP
	bl	debug_smp_processor_id
	ldr	x8, [x23, #416]
	ldr	x9, [x27, w0, uxtw #3]
	add	x8, x9, x8
	ldr	x9, [x19]
	str	x8, [x19, #48]
	ldrsw	x8, [x8, #128]
	ldr	x10, [x9, #408]
	ldr	x9, [x9, #432]
	ldr	w8, [x10, x8, lsl #2]
	ldr	x8, [x9, x8, lsl #3]
	str	x8, [x19, #56]
	cbz	x8, .LBB1_75
// %bb.38:                              //   in Loop: Header=BB1_15 Depth=1
	cmp	x21, x8
	b.eq	.LBB1_14
// %bb.39:                              //   in Loop: Header=BB1_15 Depth=1
	ldr	x9, [x8, #560]
	mov	x21, x8
	ldr	x10, [sp, #8]           // 8-byte Folded Reload
	cmp	x10, #0                 // =0
	add	x10, x9, #40            // =40
	add	x9, x9, #152            // =152
	csel	x20, x10, x9, eq
	b	.LBB1_14
.LBB1_40:                               //   in Loop: Header=BB1_15 Depth=1
	bl	preempt_schedule
	ldr	x8, [x19, #16]
	tbz	w8, #24, .LBB1_30
	b	.LBB1_36
.LBB1_41:
	mov	w23, #-1
.LBB1_42:
	adrp	x9, __stack_chk_guard
	ldr	x8, [sp, #56]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB1_76
// %bb.43:
	mov	w0, w23
	ldp	x29, x30, [sp, #144]    // 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]    // 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]    // 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]     // 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]     // 16-byte Folded Reload
	ldp	x28, x27, [sp, #64]     // 16-byte Folded Reload
	add	sp, sp, #160            // =160
	ret
.LBB1_44:
	mov	w27, #25856
	adrp	x28, __per_cpu_offset
	movk	w27, #7629, lsl #16
	add	x28, x28, :lo12:__per_cpu_offset
	b	.LBB1_46
.LBB1_45:                               //   in Loop: Header=BB1_46 Depth=1
	add	x1, sp, #16             // =16
	mov	x0, x22
	bl	finish_wait
.LBB1_46:                               // =>This Inner Loop Header: Depth=1
	add	x1, sp, #16             // =16
	orr	w2, wzr, #0x2
	mov	x0, x22
	bl	prepare_to_wait
	ldr	x8, [x19, #16]
	tbnz	w8, #24, .LBB1_51
// %bb.47:                              //   in Loop: Header=BB1_46 Depth=1
	and	x8, x8, x24
	cbz	x8, .LBB1_51
// %bb.48:                              //   in Loop: Header=BB1_46 Depth=1
	mov	x0, x19
	bl	ufs_mq_vip_tag_wait_cnt
	cbz	w0, .LBB1_51
// %bb.49:                              //   in Loop: Header=BB1_46 Depth=1
	ldr	x8, [x19, #32]
	cbz	x8, .LBB1_52
// %bb.50:                              //   in Loop: Header=BB1_46 Depth=1
	bl	ktime_get
	ldr	x8, [x19, #32]
	add	x8, x8, x27
	cmp	x0, x8
	b.le	.LBB1_52
.LBB1_51:                               //   in Loop: Header=BB1_46 Depth=1
	mov	x0, x20
	bl	__sbitmap_queue_get
	cmn	w0, #1                  // =1
	b.ne	.LBB1_72
.LBB1_52:                               //   in Loop: Header=BB1_46 Depth=1
	mov	x0, x21
	mov	w1, wzr
	bl	blk_mq_run_hw_queue
	ldr	x8, [x19, #16]
	tbnz	w8, #24, .LBB1_57
// %bb.53:                              //   in Loop: Header=BB1_46 Depth=1
	and	x8, x8, x24
	cbz	x8, .LBB1_57
// %bb.54:                              //   in Loop: Header=BB1_46 Depth=1
	mov	x0, x19
	bl	ufs_mq_vip_tag_wait_cnt
	cbz	w0, .LBB1_57
// %bb.55:                              //   in Loop: Header=BB1_46 Depth=1
	ldr	x8, [x19, #32]
	cbz	x8, .LBB1_58
// %bb.56:                              //   in Loop: Header=BB1_46 Depth=1
	bl	ktime_get
	ldr	x8, [x19, #32]
	add	x8, x8, x27
	cmp	x0, x8
	b.le	.LBB1_58
.LBB1_57:                               //   in Loop: Header=BB1_46 Depth=1
	mov	x0, x20
	bl	__sbitmap_queue_get
	cmn	w0, #1                  // =1
	b.ne	.LBB1_72
.LBB1_58:                               //   in Loop: Header=BB1_46 Depth=1
	ldr	x8, [x19, #48]
	ldr	x8, [x8, #208]
	ldr	x8, [x8, #2304]
	cbz	x8, .LBB1_61
// %bb.59:                              //   in Loop: Header=BB1_46 Depth=1
	ldr	x8, [x8, #80]
	cbz	x8, .LBB1_61
// %bb.60:                              //   in Loop: Header=BB1_46 Depth=1
	blr	x8
	ldr	x8, [x19, #16]
	tbz	w8, #24, .LBB1_64
	b	.LBB1_68
.LBB1_61:                               //   in Loop: Header=BB1_46 Depth=1
	orr	w0, wzr, #0x1
	//APP
	//NO_APP
	bl	preempt_count_sub
	ldr	w8, [x26, #72]
	cbnz	w8, .LBB1_63
// %bb.62:                              //   in Loop: Header=BB1_46 Depth=1
	ldr	x8, [x26]
	tbnz	w8, #1, .LBB1_67
.LBB1_63:                               //   in Loop: Header=BB1_46 Depth=1
	ldr	x8, [x19, #16]
	tbnz	w8, #24, .LBB1_68
.LBB1_64:                               //   in Loop: Header=BB1_46 Depth=1
	and	x8, x8, x24
	cbz	x8, .LBB1_68
// %bb.65:                              //   in Loop: Header=BB1_46 Depth=1
	orr	w0, wzr, #0x1
	bl	io_schedule_timeout
	cbnz	x0, .LBB1_69
// %bb.66:                              //   in Loop: Header=BB1_46 Depth=1
	mov	x0, x19
	bl	reset_vip_wait_cnt
	b	.LBB1_69
.LBB1_67:                               //   in Loop: Header=BB1_46 Depth=1
	bl	preempt_schedule
	ldr	x8, [x19, #16]
	tbz	w8, #24, .LBB1_64
.LBB1_68:                               //   in Loop: Header=BB1_46 Depth=1
	bl	io_schedule
.LBB1_69:                               //   in Loop: Header=BB1_46 Depth=1
	ldr	x23, [x19]
	orr	w0, wzr, #0x1
	bl	preempt_count_add
	//APP
	//NO_APP
	bl	debug_smp_processor_id
	ldr	x8, [x23, #416]
	ldr	x9, [x28, w0, uxtw #3]
	add	x8, x9, x8
	ldr	x9, [x19]
	str	x8, [x19, #48]
	ldrsw	x8, [x8, #128]
	ldr	x10, [x9, #408]
	ldr	x9, [x9, #432]
	ldr	w8, [x10, x8, lsl #2]
	ldr	x8, [x9, x8, lsl #3]
	str	x8, [x19, #56]
	cbz	x8, .LBB1_75
// %bb.70:                              //   in Loop: Header=BB1_46 Depth=1
	cmp	x21, x8
	b.eq	.LBB1_45
// %bb.71:                              //   in Loop: Header=BB1_46 Depth=1
	ldr	x9, [x8, #560]
	mov	x21, x8
	add	x20, x9, #96            // =96
	b	.LBB1_45
.LBB1_72:
	mov	w23, w0
	tbz	w25, #24, .LBB1_74
.LBB1_73:
	mov	x0, x19
	bl	ufs_mq_dec_vip_wait_cnt
.LBB1_74:
	add	x1, sp, #16             // =16
	mov	x0, x22
	bl	finish_wait
	b	.LBB1_42
.LBB1_75:
	mov	w23, #-1
	tbnz	w25, #24, .LBB1_73
	b	.LBB1_74
.LBB1_76:
	bl	__stack_chk_fail
.Lfunc_end1:
	.size	ufs_tagset_bt_get, .Lfunc_end1-ufs_tagset_bt_get
                                        // -- End function
	.globl	ufs_tagset_all_tag_busy_iter // -- Begin function ufs_tagset_all_tag_busy_iter
	.p2align	3
	.type	ufs_tagset_all_tag_busy_iter,@function
ufs_tagset_all_tag_busy_iter:           // @ufs_tagset_all_tag_busy_iter
// %bb.0:
	str	x27, [sp, #-96]!        // 8-byte Folded Spill
	stp	x26, x25, [sp, #16]     // 16-byte Folded Spill
	stp	x24, x23, [sp, #32]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #48]     // 16-byte Folded Spill
	mov	x21, x1
	stp	x20, x19, [sp, #64]     // 16-byte Folded Spill
	mov	x20, x2
	stp	x29, x30, [sp, #80]     // 16-byte Folded Spill
	add	x29, sp, #80            // =80
	mov	x19, x0
	bl	_mcount
	ldr	x8, [x19, #208]
	cbz	x8, .LBB2_15
// %bb.1:
	ldr	w8, [x19, #40]
	cbz	w8, .LBB2_15
// %bb.2:
	cbz	x21, .LBB2_9
// %bb.3:
	mov	w25, wzr
	mov	w26, wzr
.LBB2_4:                                // =>This Loop Header: Depth=1
                                        //     Child Loop BB2_7 Depth 2
	ldr	x9, [x19, #56]
	mov	w10, w25
	sub	w8, w8, w26
	add	x22, x9, x10, lsl #6
	ldr	w9, [x22, #8]
	ldr	x10, [x22]
	cmp	w8, w9
	csel	w27, w9, w8, hi
	add	w26, w27, w26
	cbz	x10, .LBB2_8
// %bb.5:                               //   in Loop: Header=BB2_4 Depth=1
	mov	w23, w27
	mov	x0, x22
	mov	x1, x23
	mov	x2, xzr
	b	.LBB2_7
.LBB2_6:                                //   in Loop: Header=BB2_7 Depth=2
	ldr	w8, [x19, #44]
	mov	x1, x20
	ldr	x9, [x19, #208]
	mov	w2, wzr
	lsl	w8, w25, w8
	add	w8, w8, w24
	ldr	x0, [x9, w8, uxtw #3]
	blr	x21
	add	w2, w24, #1             // =1
	mov	x0, x22
	mov	x1, x23
.LBB2_7:                                //   Parent Loop BB2_4 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	bl	find_next_bit
	mov	x24, x0
	cmp	w27, w24
	b.hi	.LBB2_6
.LBB2_8:                                //   in Loop: Header=BB2_4 Depth=1
	ldr	w9, [x19, #48]
	add	w10, w25, #1            // =1
	ldr	w8, [x19, #40]
	cmp	w10, w9
	csinc	w25, wzr, w25, hs
	cmp	w8, w26
	b.hi	.LBB2_4
	b	.LBB2_15
.LBB2_9:
	mov	w24, wzr
	mov	w25, wzr
.LBB2_10:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB2_13 Depth 2
	ldr	x9, [x19, #56]
	mov	w10, w24
	sub	w8, w8, w25
	add	x22, x9, x10, lsl #6
	ldr	w9, [x22, #8]
	ldr	x10, [x22]
	cmp	w8, w9
	csel	w26, w9, w8, hi
	add	w25, w26, w25
	cbz	x10, .LBB2_14
// %bb.11:                              //   in Loop: Header=BB2_10 Depth=1
	mov	w23, w26
	mov	x0, x22
	mov	x1, x23
	mov	x2, xzr
	b	.LBB2_13
.LBB2_12:                               //   in Loop: Header=BB2_13 Depth=2
	add	w2, w0, #1              // =1
	mov	x0, x22
	mov	x1, x23
.LBB2_13:                               //   Parent Loop BB2_10 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	bl	find_next_bit
	cmp	w26, w0
	b.hi	.LBB2_12
.LBB2_14:                               //   in Loop: Header=BB2_10 Depth=1
	ldr	w9, [x19, #48]
	add	w10, w24, #1            // =1
	ldr	w8, [x19, #40]
	cmp	w10, w9
	csinc	w24, wzr, w24, hs
	cmp	w8, w25
	b.hi	.LBB2_10
.LBB2_15:
	ldr	w8, [x19, #8]
	cbz	w8, .LBB2_31
// %bb.16:
	ldr	x8, [x19, #208]
	cbz	x8, .LBB2_31
// %bb.17:
	ldr	w8, [x19, #152]
	cbz	w8, .LBB2_31
// %bb.18:
	cbz	x21, .LBB2_25
// %bb.19:
	mov	w25, wzr
	mov	w26, wzr
.LBB2_20:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB2_23 Depth 2
	ldr	x9, [x19, #168]
	mov	w10, w25
	sub	w8, w8, w26
	add	x22, x9, x10, lsl #6
	ldr	w9, [x22, #8]
	ldr	x10, [x22]
	cmp	w8, w9
	csel	w27, w9, w8, hi
	add	w26, w27, w26
	cbz	x10, .LBB2_24
// %bb.21:                              //   in Loop: Header=BB2_20 Depth=1
	mov	w23, w27
	mov	x0, x22
	mov	x1, x23
	mov	x2, xzr
	b	.LBB2_23
.LBB2_22:                               //   in Loop: Header=BB2_23 Depth=2
	ldr	w8, [x19, #156]
	mov	x1, x20
	ldr	w9, [x19, #20]
	mov	w2, wzr
	ldr	x10, [x19, #208]
	lsl	w8, w25, w8
	add	w9, w9, w24
	add	w8, w9, w8
	ldr	x0, [x10, w8, uxtw #3]
	blr	x21
	add	w2, w24, #1             // =1
	mov	x0, x22
	mov	x1, x23
.LBB2_23:                               //   Parent Loop BB2_20 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	bl	find_next_bit
	mov	x24, x0
	cmp	w27, w24
	b.hi	.LBB2_22
.LBB2_24:                               //   in Loop: Header=BB2_20 Depth=1
	ldr	w9, [x19, #160]
	add	w10, w25, #1            // =1
	ldr	w8, [x19, #152]
	cmp	w10, w9
	csinc	w25, wzr, w25, hs
	cmp	w8, w26
	b.hi	.LBB2_20
	b	.LBB2_31
.LBB2_25:
	mov	w24, wzr
	mov	w25, wzr
.LBB2_26:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB2_29 Depth 2
	ldr	x9, [x19, #168]
	mov	w10, w24
	sub	w8, w8, w25
	add	x22, x9, x10, lsl #6
	ldr	w9, [x22, #8]
	ldr	x10, [x22]
	cmp	w8, w9
	csel	w26, w9, w8, hi
	add	w25, w26, w25
	cbz	x10, .LBB2_30
// %bb.27:                              //   in Loop: Header=BB2_26 Depth=1
	mov	w23, w26
	mov	x0, x22
	mov	x1, x23
	mov	x2, xzr
	b	.LBB2_29
.LBB2_28:                               //   in Loop: Header=BB2_29 Depth=2
	add	w2, w0, #1              // =1
	mov	x0, x22
	mov	x1, x23
.LBB2_29:                               //   Parent Loop BB2_26 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	bl	find_next_bit
	cmp	w26, w0
	b.hi	.LBB2_28
.LBB2_30:                               //   in Loop: Header=BB2_26 Depth=1
	ldr	w9, [x19, #160]
	add	w10, w24, #1            // =1
	ldr	w8, [x19, #152]
	cmp	w10, w9
	csinc	w24, wzr, w24, hs
	cmp	w8, w25
	b.hi	.LBB2_26
.LBB2_31:
	ldr	w8, [x19, #4]
	cbz	w8, .LBB2_47
// %bb.32:
	ldr	x8, [x19, #208]
	cbz	x8, .LBB2_47
// %bb.33:
	ldr	w8, [x19, #96]
	cbz	w8, .LBB2_47
// %bb.34:
	cbz	x21, .LBB2_41
// %bb.35:
	mov	w25, wzr
	mov	w26, wzr
.LBB2_36:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB2_39 Depth 2
	ldr	x9, [x19, #112]
	mov	w10, w25
	sub	w8, w8, w26
	add	x22, x9, x10, lsl #6
	ldr	w9, [x22, #8]
	ldr	x10, [x22]
	cmp	w8, w9
	csel	w27, w9, w8, hi
	add	w26, w27, w26
	cbz	x10, .LBB2_40
// %bb.37:                              //   in Loop: Header=BB2_36 Depth=1
	mov	w23, w27
	mov	x0, x22
	mov	x1, x23
	mov	x2, xzr
	b	.LBB2_39
.LBB2_38:                               //   in Loop: Header=BB2_39 Depth=2
	ldr	w8, [x19, #100]
	orr	w2, wzr, #0x1
	ldr	w9, [x19, #16]
	mov	x1, x20
	ldr	x10, [x19, #208]
	lsl	w8, w25, w8
	add	w9, w9, w24
	add	w8, w9, w8
	ldr	x0, [x10, w8, uxtw #3]
	blr	x21
	add	w2, w24, #1             // =1
	mov	x0, x22
	mov	x1, x23
.LBB2_39:                               //   Parent Loop BB2_36 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	bl	find_next_bit
	mov	x24, x0
	cmp	w27, w24
	b.hi	.LBB2_38
.LBB2_40:                               //   in Loop: Header=BB2_36 Depth=1
	ldr	w9, [x19, #104]
	add	w10, w25, #1            // =1
	ldr	w8, [x19, #96]
	cmp	w10, w9
	csinc	w25, wzr, w25, hs
	cmp	w8, w26
	b.hi	.LBB2_36
	b	.LBB2_47
.LBB2_41:
	mov	w22, wzr
	mov	w23, wzr
.LBB2_42:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB2_45 Depth 2
	ldr	x9, [x19, #112]
	mov	w10, w22
	sub	w8, w8, w23
	add	x20, x9, x10, lsl #6
	ldr	w9, [x20, #8]
	ldr	x10, [x20]
	cmp	w8, w9
	csel	w24, w9, w8, hi
	add	w23, w24, w23
	cbz	x10, .LBB2_46
// %bb.43:                              //   in Loop: Header=BB2_42 Depth=1
	mov	w21, w24
	mov	x0, x20
	mov	x1, x21
	mov	x2, xzr
	b	.LBB2_45
.LBB2_44:                               //   in Loop: Header=BB2_45 Depth=2
	add	w2, w0, #1              // =1
	mov	x0, x20
	mov	x1, x21
.LBB2_45:                               //   Parent Loop BB2_42 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	bl	find_next_bit
	cmp	w24, w0
	b.hi	.LBB2_44
.LBB2_46:                               //   in Loop: Header=BB2_42 Depth=1
	ldr	w9, [x19, #104]
	add	w10, w22, #1            // =1
	ldr	w8, [x19, #96]
	cmp	w10, w9
	csinc	w22, wzr, w22, hs
	cmp	w8, w23
	b.hi	.LBB2_42
.LBB2_47:
	ldp	x29, x30, [sp, #80]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]     // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]     // 16-byte Folded Reload
	ldr	x27, [sp], #96          // 8-byte Folded Reload
	ret
.Lfunc_end2:
	.size	ufs_tagset_all_tag_busy_iter, .Lfunc_end2-ufs_tagset_all_tag_busy_iter
                                        // -- End function
	.globl	ufs_tagset_free_tags    // -- Begin function ufs_tagset_free_tags
	.p2align	3
	.type	ufs_tagset_free_tags,@function
ufs_tagset_free_tags:                   // @ufs_tagset_free_tags
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	x0, [x19, #80]
	bl	kfree
	ldr	x0, [x19, #64]
	bl	free_percpu
	ldr	x0, [x19, #56]
	bl	kfree
	ldr	x0, [x19, #136]
	str	xzr, [x19, #56]
	bl	kfree
	ldr	x0, [x19, #120]
	bl	free_percpu
	ldr	x0, [x19, #112]
	bl	kfree
	ldr	x0, [x19, #192]
	str	xzr, [x19, #112]
	bl	kfree
	ldr	x0, [x19, #176]
	bl	free_percpu
	ldr	x0, [x19, #168]
	bl	kfree
	mov	x0, x19
	str	xzr, [x19, #168]
	bl	kfree
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end3:
	.size	ufs_tagset_free_tags, .Lfunc_end3-ufs_tagset_free_tags
                                        // -- End function
	.globl	ufs_mq_tag_wakeup_all   // -- Begin function ufs_mq_tag_wakeup_all
	.p2align	3
	.type	ufs_mq_tag_wakeup_all,@function
ufs_mq_tag_wakeup_all:                  // @ufs_mq_tag_wakeup_all
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	add	x0, x19, #40            // =40
	bl	sbitmap_queue_wake_all
	add	x0, x19, #96            // =96
	bl	sbitmap_queue_wake_all
	add	x0, x19, #152           // =152
	bl	sbitmap_queue_wake_all
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	mov	w0, wzr
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end4:
	.size	ufs_mq_tag_wakeup_all, .Lfunc_end4-ufs_mq_tag_wakeup_all
                                        // -- End function
	.globl	ufs_tagset_init_tags    // -- Begin function ufs_tagset_init_tags
	.p2align	3
	.type	ufs_tagset_init_tags,@function
ufs_tagset_init_tags:                   // @ufs_tagset_init_tags
// %bb.0:
	str	x27, [sp, #-96]!        // 8-byte Folded Spill
	stp	x26, x25, [sp, #16]     // 16-byte Folded Spill
	mov	w25, w1
	stp	x24, x23, [sp, #32]     // 16-byte Folded Spill
	mov	w24, w2
	stp	x22, x21, [sp, #48]     // 16-byte Folded Spill
	mov	w22, w4
	stp	x20, x19, [sp, #64]     // 16-byte Folded Spill
	mov	w20, w3
	stp	x29, x30, [sp, #80]     // 16-byte Folded Spill
	add	x29, sp, #80            // =80
	mov	w26, w0
	bl	_mcount
	adrp	x8, kmalloc_caches
	add	x8, x8, :lo12:kmalloc_caches
	mov	w21, #192
	movk	w21, #96, lsl #16
	ldr	x0, [x8, #64]
	add	w1, w21, #8, lsl #12    // =32768
	orr	w2, wzr, #0xf0
	bl	kmem_cache_alloc_trace
	mov	x19, x0
	cbnz	x0, .LBB5_2
.LBB5_1:
	mov	x0, x19
	ldp	x29, x30, [sp, #80]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]     // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]     // 16-byte Folded Reload
	ldr	x27, [sp], #96          // 8-byte Folded Reload
	ret
.LBB5_2:
	sub	w8, w26, w25
	stp	w26, w25, [x19]
	sub	w23, w8, w24
	str	w24, [x19, #8]
	adrp	x0, .L.str.1
	add	x0, x0, :lo12:.L.str.1
	mov	w1, w23
	mov	w2, w25
	mov	w3, w24
	cmp	w22, #1                 // =1
	cset	w27, eq
	bl	printk
	add	x0, x19, #40            // =40
	mov	w2, #-1
	mov	w1, w23
	mov	w3, w27
	mov	w4, w21
	mov	w5, w20
	bl	sbitmap_queue_init_node
	cbnz	w0, .LBB5_8
// %bb.3:
	cmp	w22, #1                 // =1
	ldr	w1, [x19, #4]
	cset	w3, eq
	add	x0, x19, #96            // =96
	mov	w2, #-1
	mov	w4, w21
	mov	w5, w20
	bl	sbitmap_queue_init_node
	cbnz	w0, .LBB5_7
// %bb.4:
	cmp	w22, #1                 // =1
	ldr	w1, [x19, #8]
	cset	w3, eq
	add	x0, x19, #152           // =152
	mov	w2, #-1
	mov	w4, w21
	mov	w5, w20
	bl	sbitmap_queue_init_node
	cbnz	w0, .LBB5_6
// %bb.5:
	ldr	w8, [x19, #4]
	stp	wzr, w23, [x19, #12]
	add	w8, w8, w23
	str	w8, [x19, #20]
	b	.LBB5_1
.LBB5_6:
	ldr	x0, [x19, #136]
	bl	kfree
	ldr	x0, [x19, #120]
	bl	free_percpu
	ldr	x0, [x19, #112]
	bl	kfree
	str	xzr, [x19, #112]
.LBB5_7:
	ldr	x0, [x19, #80]
	bl	kfree
	ldr	x0, [x19, #64]
	bl	free_percpu
	ldr	x0, [x19, #56]
	bl	kfree
	str	xzr, [x19, #56]
.LBB5_8:
	adrp	x0, .L.str.2
	adrp	x1, .L__func__.ufs_tagset_init_bitmap_tags
	add	x0, x0, :lo12:.L.str.2
	add	x1, x1, :lo12:.L__func__.ufs_tagset_init_bitmap_tags
	bl	printk
	adrp	x0, .L.str
	add	x0, x0, :lo12:.L.str
	bl	printk
	mov	x0, x19
	bl	kfree
	mov	x19, xzr
	b	.LBB5_1
.Lfunc_end5:
	.size	ufs_tagset_init_tags, .Lfunc_end5-ufs_tagset_init_tags
                                        // -- End function
	.type	.L.str,@object          // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"\0013[BLK-IO]Failed to init tagset bitmaps!\n"
	.size	.L.str, 42

	.type	.L.str.1,@object        // @.str.1
.L.str.1:
	.asciz	"\0013[BLK-IO]depth = %d, reserved = %d, high prio = %d \r\n"
	.size	.L.str.1, 55

	.type	.L.str.2,@object        // @.str.2
.L.str.2:
	.asciz	"\0013[BLK-IO]%s: error nomem\n"
	.size	.L.str.2, 27

	.type	.L__func__.ufs_tagset_init_bitmap_tags,@object // @__func__.ufs_tagset_init_bitmap_tags
.L__func__.ufs_tagset_init_bitmap_tags:
	.asciz	"ufs_tagset_init_bitmap_tags"
	.size	.L__func__.ufs_tagset_init_bitmap_tags, 28


	.ident	"Snapdragon LLVM ARM Compiler 8.0.12 for Android NDK (based on llvm.org 7.0+)"
	.section	".note.GNU-stack","",@progbits
