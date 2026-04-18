	.text
	.file	"mas_blk_flush.c"
                                        // Start of file scope inline assembly
.section	".initcall6.init", "a"	
__initcall___cfi_mas_blk_flush_init6:		
.long	__cfi_mas_blk_flush_init - .			
.previous					

                                        // End of file scope inline assembly
	.globl	mas_blk_flush_work_fn   // -- Begin function mas_blk_flush_work_fn
	.p2align	3
	.type	mas_blk_flush_work_fn,@function
mas_blk_flush_work_fn:                  // @mas_blk_flush_work_fn
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldur	x0, [x19, #-40]
	mov	w1, wzr
	bl	bdget_disk
	cbz	x0, .LBB0_4
// %bb.1:
	orr	w1, wzr, #0x2
	mov	x2, xzr
	mov	x19, x0
	bl	blkdev_get
	cbnz	w0, .LBB0_5
// %bb.2:
	mov	w1, #192
	movk	w1, #96, lsl #16
	mov	x0, x19
	mov	x2, xzr
	bl	blkdev_issue_flush
	cbnz	w0, .LBB0_6
.LBB0_3:
	orr	w1, wzr, #0x2
	mov	x0, x19
	bl	blkdev_put
.LBB0_4:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.LBB0_5:
	adrp	x0, .L.str
	adrp	x1, .L__func__.mas_blk_flush_work_fn
	add	x0, x0, :lo12:.L.str
	add	x1, x1, :lo12:.L__func__.mas_blk_flush_work_fn
	bl	printk
	b	.LBB0_4
.LBB0_6:
	adrp	x0, .L.str.1
	adrp	x1, .L__func__.mas_blk_flush_work_fn
	add	x0, x0, :lo12:.L.str.1
	add	x1, x1, :lo12:.L__func__.mas_blk_flush_work_fn
	bl	printk
	b	.LBB0_3
.Lfunc_end0:
	.size	mas_blk_flush_work_fn, .Lfunc_end0-mas_blk_flush_work_fn
                                        // -- End function
	.globl	mas_blk_flush_async_dispatch // -- Begin function mas_blk_flush_async_dispatch
	.p2align	3
	.type	mas_blk_flush_async_dispatch,@function
mas_blk_flush_async_dispatch:           // @mas_blk_flush_async_dispatch
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x20, x1
	mov	x19, x0
	bl	_mcount
	ldr	w8, [x19, #2136]
	cbz	w8, .LBB1_5
// %bb.1:
	ldr	w8, [x20, #16]
	tbz	w8, #18, .LBB1_3
// %bb.2:
	ldr	w9, [x20, #48]
	cbz	w9, .LBB1_7
.LBB1_3:
	and	w8, w8, #0xff
	cmp	w8, #1                  // =1
	b.ne	.LBB1_5
// %bb.4:
	add	x8, x19, #2116          // =2116
	mov	w0, wzr
	//APP
	// atomic_add
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	b	.LBB1_6
.LBB1_5:
	mov	w0, wzr
.LBB1_6:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.LBB1_7:
	ldrb	w9, [x20, #154]
	cbz	w9, .LBB1_9
// %bb.8:
	add	x19, x19, #1912         // =1912
	mov	x0, x19
	bl	cancel_delayed_work
	adrp	x8, blk_async_flush_workqueue
	mov	w3, #5
	orr	w0, wzr, #0x8
	ldr	x1, [x8, :lo12:blk_async_flush_workqueue]
	mov	x2, x19
	bl	queue_delayed_work_on
	orr	w0, wzr, #0x1
	b	.LBB1_6
.LBB1_9:
	ldr	w9, [x19, #2116]
	cbnz	w9, .LBB1_3
// %bb.10:
	orr	w0, wzr, #0x1
	b	.LBB1_6
.Lfunc_end1:
	.size	mas_blk_flush_async_dispatch, .Lfunc_end1-mas_blk_flush_async_dispatch
                                        // -- End function
	.globl	mas_blk_flush_update    // -- Begin function mas_blk_flush_update
	.p2align	3
	.type	mas_blk_flush_update,@function
mas_blk_flush_update:                   // @mas_blk_flush_update
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	w20, w1
	mov	x19, x0
	bl	_mcount
	cbnz	w20, .LBB2_2
// %bb.1:
	ldr	x8, [x19]
	str	wzr, [x8, #2116]
.LBB2_2:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end2:
	.size	mas_blk_flush_update, .Lfunc_end2-mas_blk_flush_update
                                        // -- End function
	.globl	blk_power_off_flush     // -- Begin function blk_power_off_flush
	.p2align	3
	.type	blk_power_off_flush,@function
blk_power_off_flush:                    // @blk_power_off_flush
// %bb.0:
	str	x27, [sp, #-96]!        // 8-byte Folded Spill
	stp	x26, x25, [sp, #16]     // 16-byte Folded Spill
	stp	x24, x23, [sp, #32]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #48]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #64]     // 16-byte Folded Spill
	mov	w19, w0
	stp	x29, x30, [sp, #80]     // 16-byte Folded Spill
	add	x29, sp, #80            // =80
	bl	_mcount
	adrp	x0, .L.str.2
	adrp	x1, .L__func__.blk_power_off_flush
	add	x0, x0, :lo12:.L.str.2
	add	x1, x1, :lo12:.L__func__.blk_power_off_flush
	mov	w2, w19
	bl	printk
	adrp	x0, all_flush_q_lock
	add	x0, x0, :lo12:all_flush_q_lock
	bl	_raw_spin_lock_irqsave
	adrp	x26, all_flush_q_list
	add	x26, x26, :lo12:all_flush_q_list
	mov	x19, x0
	ldr	x27, [x26]
	cmp	x27, x26
	b.eq	.LBB3_9
// %bb.1:
	adrp	x20, .L.str.3
	adrp	x21, .L__func__.blk_power_off_flush
	adrp	x22, .L.str.4
	add	x20, x20, :lo12:.L.str.3
	add	x21, x21, :lo12:.L__func__.blk_power_off_flush
	add	x22, x22, :lo12:.L.str.4
	b	.LBB3_3
.LBB3_2:                                //   in Loop: Header=BB3_3 Depth=1
	add	x25, x9, #12            // =12
	mov	x0, x20
	mov	x1, x21
	mov	x2, x25
	bl	printk
	ldr	x8, [x24, #56]
	mov	x0, x23
	blr	x8
	mov	x0, x22
	mov	x1, x21
	mov	x2, x25
	bl	printk
	b	.LBB3_8
.LBB3_3:                                // =>This Inner Loop Header: Depth=1
	ldurb	w8, [x27, #-240]
	cbz	w8, .LBB3_8
// %bb.4:                               //   in Loop: Header=BB3_3 Depth=1
	sub	x23, x27, #2120         // =2120
	mov	x0, x23
	bl	mas_blk_get_lld
	cbz	x0, .LBB3_8
// %bb.5:                               //   in Loop: Header=BB3_3 Depth=1
	ldr	x8, [x0, #56]
	mov	x24, x0
	cbz	x8, .LBB3_8
// %bb.6:                               //   in Loop: Header=BB3_3 Depth=1
	ldur	x9, [x27, #-248]
	cbnz	x9, .LBB3_2
// %bb.7:                               //   in Loop: Header=BB3_3 Depth=1
	mov	x0, x23
	blr	x8
.LBB3_8:                                //   in Loop: Header=BB3_3 Depth=1
	ldr	x27, [x27]
	cmp	x27, x26
	b.ne	.LBB3_3
.LBB3_9:
	adrp	x0, all_flush_q_lock
	add	x0, x0, :lo12:all_flush_q_lock
	mov	x1, x19
	bl	_raw_spin_unlock_irqrestore
	adrp	x0, .L.str.5
	adrp	x1, .L__func__.blk_power_off_flush
	add	x0, x0, :lo12:.L.str.5
	add	x1, x1, :lo12:.L__func__.blk_power_off_flush
	bl	printk
	ldp	x29, x30, [sp, #80]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]     // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]     // 16-byte Folded Reload
	ldr	x27, [sp], #96          // 8-byte Folded Reload
	ret
.Lfunc_end3:
	.size	blk_power_off_flush, .Lfunc_end3-blk_power_off_flush
                                        // -- End function
	.globl	mas_blk_flush_list_register // -- Begin function mas_blk_flush_list_register
	.p2align	3
	.type	mas_blk_flush_list_register,@function
mas_blk_flush_list_register:            // @mas_blk_flush_list_register
// %bb.0:
	stp	x22, x21, [sp, #-48]!   // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	bl	_mcount
	adrp	x0, all_object_lock
	add	x0, x0, :lo12:all_object_lock
	bl	_raw_spin_lock_irqsave
	adrp	x21, all_object_list
	add	x21, x21, :lo12:all_object_list
	mov	x20, x0
	mov	x0, x19
	ldr	x22, [x21]
	mov	x1, x21
	mov	x2, x22
	bl	__list_add_valid
	tbz	w0, #0, .LBB4_2
// %bb.1:
	adrp	x8, all_object_list
	str	x19, [x22, #8]
	stp	x22, x21, [x19]
	str	x19, [x8, :lo12:all_object_list]
.LBB4_2:
	adrp	x0, all_object_lock
	add	x0, x0, :lo12:all_object_lock
	mov	x1, x20
	bl	_raw_spin_unlock_irqrestore
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldp	x22, x21, [sp], #48     // 16-byte Folded Reload
	ret
.Lfunc_end4:
	.size	mas_blk_flush_list_register, .Lfunc_end4-mas_blk_flush_list_register
                                        // -- End function
	.globl	mas_blk_flush_list_unregister // -- Begin function mas_blk_flush_list_unregister
	.p2align	3
	.type	mas_blk_flush_list_unregister,@function
mas_blk_flush_list_unregister:          // @mas_blk_flush_list_unregister
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	adrp	x0, all_object_lock
	add	x0, x0, :lo12:all_object_lock
	bl	_raw_spin_lock_irqsave
	mov	x20, x0
	mov	x0, x19
	bl	__list_del_entry_valid
	tbz	w0, #0, .LBB5_2
// %bb.1:
	ldp	x8, x9, [x19]
	str	x9, [x8, #8]
	str	x8, [x9]
.LBB5_2:
	adrp	x0, all_object_lock
	str	x19, [x19]
	add	x0, x0, :lo12:all_object_lock
	str	x19, [x19, #8]
	mov	x1, x20
	bl	_raw_spin_unlock_irqrestore
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end5:
	.size	mas_blk_flush_list_unregister, .Lfunc_end5-mas_blk_flush_list_unregister
                                        // -- End function
	.globl	mas_blk_order_panic_wait_flush // -- Begin function mas_blk_order_panic_wait_flush
	.p2align	3
	.type	mas_blk_order_panic_wait_flush,@function
mas_blk_order_panic_wait_flush:         // @mas_blk_order_panic_wait_flush
// %bb.0:
	str	x27, [sp, #-96]!        // 8-byte Folded Spill
	stp	x26, x25, [sp, #16]     // 16-byte Folded Spill
	stp	x24, x23, [sp, #32]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #48]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #64]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #80]     // 16-byte Folded Spill
	add	x29, sp, #80            // =80
	bl	_mcount
	adrp	x19, .L__func__.mas_blk_order_panic_wait_flush
	adrp	x0, .L.str.6
	add	x19, x19, :lo12:.L__func__.mas_blk_order_panic_wait_flush
	add	x0, x0, :lo12:.L.str.6
	mov	x1, x19
	bl	printk
	mov	w20, #35160
	adrp	x21, all_object_lock
	adrp	x25, all_object_list
	adrp	x22, .L.str.7
	mov	w26, wzr
	mov	w24, #200
	movk	w20, #65, lsl #16
	add	x21, x21, :lo12:all_object_lock
	add	x25, x25, :lo12:all_object_list
	add	x22, x22, :lo12:.L.str.7
.LBB6_1:                                // =>This Loop Header: Depth=1
                                        //     Child Loop BB6_3 Depth 2
	mov	x0, x20
	bl	__const_udelay
	mov	x0, x21
	bl	_raw_spin_lock_irqsave
	ldr	x27, [x25]
	mov	x23, x0
	cmp	x27, x25
	b.ne	.LBB6_3
	b	.LBB6_10
.LBB6_2:                                //   in Loop: Header=BB6_3 Depth=2
	ldr	x27, [x27]
	cmp	x27, x25
	b.eq	.LBB6_10
.LBB6_3:                                //   Parent Loop BB6_1 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	sub	x8, x27, #1484          // =1484
	ldr	w2, [x8]
	cmp	w2, #2                  // =2
	b.ne	.LBB6_9
// %bb.4:                               //   in Loop: Header=BB6_3 Depth=2
	sub	x8, x27, #1463          // =1463
	ldrb	w8, [x8]
	tbz	w8, #0, .LBB6_2
// %bb.5:                               //   in Loop: Header=BB6_3 Depth=2
	tbnz	w26, #0, .LBB6_7
// %bb.6:                               //   in Loop: Header=BB6_3 Depth=2
	sub	x0, x27, #1488          // =1488
	bl	ufs_order_panic_wait_datasync_handle
	b	.LBB6_8
.LBB6_7:                                //   in Loop: Header=BB6_3 Depth=2
	orr	w0, wzr, #0x1
.LBB6_8:                                //   in Loop: Header=BB6_3 Depth=2
	and	w26, w0, #0x1
	b	.LBB6_2
.LBB6_9:                                //   in Loop: Header=BB6_3 Depth=2
	mov	x0, x22
	mov	x1, x19
	bl	printk
	ldr	x27, [x27]
	cmp	x27, x25
	b.ne	.LBB6_3
.LBB6_10:                               //   in Loop: Header=BB6_1 Depth=1
	mov	x0, x21
	mov	x1, x23
	bl	_raw_spin_unlock_irqrestore
	tbnz	w26, #0, .LBB6_13
// %bb.11:                              //   in Loop: Header=BB6_1 Depth=1
	sub	w24, w24, #1            // =1
	cbnz	w24, .LBB6_1
// %bb.12:
	orr	w0, wzr, #0x1
	bl	blk_power_off_flush
	adrp	x0, .L.str.9
	add	x0, x0, :lo12:.L.str.9
	b	.LBB6_14
.LBB6_13:
	orr	w0, wzr, #0x1
	bl	blk_power_off_flush
	adrp	x0, .L.str.8
	add	x0, x0, :lo12:.L.str.8
.LBB6_14:
	adrp	x1, .L__func__.mas_blk_order_panic_wait_flush
	add	x1, x1, :lo12:.L__func__.mas_blk_order_panic_wait_flush
	bl	printk
	ldp	x29, x30, [sp, #80]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]     // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]     // 16-byte Folded Reload
	ldr	x27, [sp], #96          // 8-byte Folded Reload
	ret
.Lfunc_end6:
	.size	mas_blk_order_panic_wait_flush, .Lfunc_end6-mas_blk_order_panic_wait_flush
                                        // -- End function
	.globl	mas_blk_panic_flush     // -- Begin function mas_blk_panic_flush
	.p2align	3
	.type	mas_blk_panic_flush,@function
mas_blk_panic_flush:                    // @mas_blk_panic_flush
// %bb.0:
	stp	x24, x23, [sp, #-64]!   // 16-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	bl	_mcount
	mov	w0, wzr
	bl	blk_power_off_flush
	adrp	x0, all_object_lock
	add	x0, x0, :lo12:all_object_lock
	bl	_raw_spin_lock_irqsave
	adrp	x22, all_object_list
	add	x22, x22, :lo12:all_object_list
	mov	x19, x0
	ldr	x23, [x22]
	cmp	x23, x22
	b.eq	.LBB7_9
// %bb.1:
	adrp	x20, .L.str.7
	adrp	x21, .L__func__.mas_blk_panic_flush
	mov	w24, wzr
	add	x20, x20, :lo12:.L.str.7
	add	x21, x21, :lo12:.L__func__.mas_blk_panic_flush
	b	.LBB7_3
.LBB7_2:                                //   in Loop: Header=BB7_3 Depth=1
	mov	x0, x20
	mov	x1, x21
	bl	printk
	b	.LBB7_6
.LBB7_3:                                // =>This Inner Loop Header: Depth=1
	sub	x8, x23, #1484          // =1484
	ldr	w2, [x8]
	cmp	w2, #2                  // =2
	b.ne	.LBB7_2
// %bb.4:                               //   in Loop: Header=BB7_3 Depth=1
	sub	x8, x23, #1463          // =1463
	ldrb	w8, [x8]
	tbz	w8, #0, .LBB7_6
// %bb.5:                               //   in Loop: Header=BB7_3 Depth=1
	sub	x0, x23, #1488          // =1488
	bl	ufs_order_panic_datasync_handle
	orr	w24, wzr, #0x1
.LBB7_6:                                //   in Loop: Header=BB7_3 Depth=1
	ldr	x23, [x23]
	cmp	x23, x22
	b.ne	.LBB7_3
// %bb.7:
	adrp	x0, all_object_lock
	add	x0, x0, :lo12:all_object_lock
	mov	x1, x19
	bl	_raw_spin_unlock_irqrestore
	tbz	w24, #0, .LBB7_10
// %bb.8:
	bl	mas_blk_order_panic_wait_flush
	b	.LBB7_10
.LBB7_9:
	adrp	x0, all_object_lock
	add	x0, x0, :lo12:all_object_lock
	mov	x1, x19
	bl	_raw_spin_unlock_irqrestore
.LBB7_10:
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldp	x24, x23, [sp], #64     // 16-byte Folded Reload
	ret
.Lfunc_end7:
	.size	mas_blk_panic_flush, .Lfunc_end7-mas_blk_panic_flush
                                        // -- End function
	.globl	mas_blk_poweroff_flush_notifier_call // -- Begin function mas_blk_poweroff_flush_notifier_call
	.p2align	3
	.type	mas_blk_poweroff_flush_notifier_call,@function
mas_blk_poweroff_flush_notifier_call:   // @mas_blk_poweroff_flush_notifier_call
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	bl	_mcount
	cbz	x19, .LBB8_3
// %bb.1:
	cmp	x19, #1                 // =1
	b.ne	.LBB8_4
// %bb.2:
	adrp	x19, system_wq
	adrp	x2, mas_blk_order_power_off_work
	add	x2, x2, :lo12:mas_blk_order_power_off_work
	ldr	x1, [x19, :lo12:system_wq]
	mov	w3, #250
	orr	w0, wzr, #0x8
	bl	queue_delayed_work_on
	ldr	x1, [x19, :lo12:system_wq]
	adrp	x2, mas_blk_power_off_work
	add	x2, x2, :lo12:mas_blk_power_off_work
	mov	w3, #1500
	orr	w0, wzr, #0x8
	bl	queue_delayed_work_on
	b	.LBB8_4
.LBB8_3:
	adrp	x0, mas_blk_power_off_work
	add	x0, x0, :lo12:mas_blk_power_off_work
	bl	cancel_delayed_work
	adrp	x0, mas_blk_order_power_off_work
	add	x0, x0, :lo12:mas_blk_order_power_off_work
	bl	cancel_delayed_work
.LBB8_4:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	mov	w0, wzr
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end8:
	.size	mas_blk_poweroff_flush_notifier_call, .Lfunc_end8-mas_blk_poweroff_flush_notifier_call
                                        // -- End function
	.section	.init.text,"ax",@progbits
	.globl	mas_blk_flush_init      // -- Begin function mas_blk_flush_init
	.p2align	2
	.type	mas_blk_flush_init,@function
mas_blk_flush_init:                     // @mas_blk_flush_init
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	bl	_mcount
	adrp	x19, mas_blk_power_off_work
	add	x19, x19, :lo12:mas_blk_power_off_work
	adrp	x1, .L.str.10
	adrp	x2, mas_blk_flush_init.__key
	mov	x20, #68719476704
	add	x0, x19, #32            // =32
	add	x1, x1, :lo12:.L.str.10
	add	x2, x2, :lo12:mas_blk_flush_init.__key
	str	x20, [x19]
	mov	w3, wzr
	bl	lockdep_init_map
	adrp	x9, mas_blk_power_off_work_fn
	add	x8, x19, #8             // =8
	add	x9, x9, :lo12:mas_blk_power_off_work_fn
	add	x0, x19, #88            // =88
	str	x8, [x19, #8]
	adrp	x3, .L.str.12
	stp	x8, x9, [x19, #16]
	adrp	x19, delayed_work_timer_fn
	add	x19, x19, :lo12:delayed_work_timer_fn
	adrp	x4, mas_blk_flush_init.__key.11
	add	x3, x3, :lo12:.L.str.12
	add	x4, x4, :lo12:mas_blk_flush_init.__key.11
	orr	w2, wzr, #0x200000
	mov	x1, x19
	bl	init_timer_key
	adrp	x21, mas_blk_order_power_off_work
	add	x21, x21, :lo12:mas_blk_order_power_off_work
	adrp	x1, .L.str.14
	adrp	x2, mas_blk_flush_init.__key.13
	add	x0, x21, #32            // =32
	str	x20, [x21]
	add	x1, x1, :lo12:.L.str.14
	add	x2, x2, :lo12:mas_blk_flush_init.__key.13
	mov	w3, wzr
	bl	lockdep_init_map
	adrp	x9, mas_blk_order_power_off_work_fn
	adrp	x3, .L.str.16
	adrp	x4, mas_blk_flush_init.__key.15
	add	x8, x21, #8             // =8
	add	x9, x9, :lo12:mas_blk_order_power_off_work_fn
	add	x0, x21, #88            // =88
	add	x3, x3, :lo12:.L.str.16
	str	x8, [x21, #8]
	add	x4, x4, :lo12:mas_blk_flush_init.__key.15
	stp	x8, x9, [x21, #16]
	orr	w2, wzr, #0x200000
	mov	x1, x19
	bl	init_timer_key
	adrp	x0, mas_blk_poweroff_flush_nb
	add	x0, x0, :lo12:mas_blk_poweroff_flush_nb
	bl	power_key_register_notifier
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.Lfunc_end9:
	.size	mas_blk_flush_init, .Lfunc_end9-mas_blk_flush_init
                                        // -- End function
	.text
	.p2align	3               // -- Begin function mas_blk_power_off_work_fn
	.type	mas_blk_power_off_work_fn,@function
mas_blk_power_off_work_fn:              // @mas_blk_power_off_work_fn
// %bb.0:
	stp	x29, x30, [sp, #-16]!   // 16-byte Folded Spill
	orr	w0, wzr, #0x1
	mov	x29, sp
	bl	blk_power_off_flush
	ldp	x29, x30, [sp], #16     // 16-byte Folded Reload
	ret
.Lfunc_end10:
	.size	mas_blk_power_off_work_fn, .Lfunc_end10-mas_blk_power_off_work_fn
                                        // -- End function
	.p2align	3               // -- Begin function mas_blk_order_power_off_work_fn
	.type	mas_blk_order_power_off_work_fn,@function
mas_blk_order_power_off_work_fn:        // @mas_blk_order_power_off_work_fn
// %bb.0:
	str	x23, [sp, #-64]!        // 8-byte Folded Spill
	adrp	x0, all_object_lock
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	add	x0, x0, :lo12:all_object_lock
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	bl	_raw_spin_lock_irqsave
	adrp	x22, all_object_list
	add	x22, x22, :lo12:all_object_list
	mov	x19, x0
	ldr	x23, [x22]
	cmp	x23, x22
	b.eq	.LBB11_10
// %bb.1:
	adrp	x20, .L.str.7
	adrp	x21, .L__func__.mas_blk_order_poweroff_proc
	add	x20, x20, :lo12:.L.str.7
	add	x21, x21, :lo12:.L__func__.mas_blk_order_poweroff_proc
.LBB11_2:                               // =>This Inner Loop Header: Depth=1
	sub	x8, x23, #1484          // =1484
	ldr	w2, [x8]
	cmp	w2, #2                  // =2
	b.ne	.LBB11_8
// %bb.3:                               //   in Loop: Header=BB11_2 Depth=1
	sub	x8, x23, #1463          // =1463
	ldrb	w8, [x8]
	tbz	w8, #0, .LBB11_9
// %bb.4:                               //   in Loop: Header=BB11_2 Depth=1
	sub	x8, x23, #1480          // =1480
	ldr	x8, [x8]
	cbz	x8, .LBB11_9
// %bb.5:                               //   in Loop: Header=BB11_2 Depth=1
	ldr	x8, [x8, #1544]
	cbz	x8, .LBB11_9
// %bb.6:                               //   in Loop: Header=BB11_2 Depth=1
	ldr	x8, [x8, #32]
	cbz	x8, .LBB11_9
// %bb.7:                               //   in Loop: Header=BB11_2 Depth=1
	sub	x0, x23, #1488          // =1488
	blr	x8
	b	.LBB11_9
.LBB11_8:                               //   in Loop: Header=BB11_2 Depth=1
	mov	x0, x20
	mov	x1, x21
	bl	printk
.LBB11_9:                               //   in Loop: Header=BB11_2 Depth=1
	ldr	x23, [x23]
	cmp	x23, x22
	b.ne	.LBB11_2
.LBB11_10:
	adrp	x0, all_object_lock
	add	x0, x0, :lo12:all_object_lock
	mov	x1, x19
	bl	_raw_spin_unlock_irqrestore
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldr	x23, [sp], #64          // 8-byte Folded Reload
	ret
.Lfunc_end11:
	.size	mas_blk_order_power_off_work_fn, .Lfunc_end11-mas_blk_order_power_off_work_fn
                                        // -- End function
	.globl	mas_blk_flush_reduced_queue_unregister // -- Begin function mas_blk_flush_reduced_queue_unregister
	.p2align	3
	.type	mas_blk_flush_reduced_queue_unregister,@function
mas_blk_flush_reduced_queue_unregister: // @mas_blk_flush_reduced_queue_unregister
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	bl	_mcount
	ldr	w8, [x19, #2136]
	cbz	w8, .LBB12_6
// %bb.1:
	add	x21, x19, #2120         // =2120
	ldr	x8, [x21]
	cbz	x8, .LBB12_7
// %bb.2:
	ldr	x8, [x19, #2128]
	cbz	x8, .LBB12_7
// %bb.3:
	adrp	x0, all_flush_q_lock
	add	x0, x0, :lo12:all_flush_q_lock
	bl	_raw_spin_lock_irqsave
	mov	x20, x0
	mov	x0, x21
	bl	__list_del_entry_valid
	tbz	w0, #0, .LBB12_5
// %bb.4:
	ldr	x8, [x19, #2128]
	ldr	x9, [x19, #2120]
	str	x8, [x9, #8]
	str	x9, [x8]
.LBB12_5:
	mov	x8, #256
	movk	x8, #57005, lsl #48
	adrp	x0, all_flush_q_lock
	add	x9, x8, #256            // =256
	add	x0, x0, :lo12:all_flush_q_lock
	str	x8, [x19, #2120]
	mov	x1, x20
	str	x9, [x19, #2128]
	bl	_raw_spin_unlock_irqrestore
.LBB12_6:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.LBB12_7:
	adrp	x0, .L.str.29
	adrp	x1, .L.str.17
	add	x0, x0, :lo12:.L.str.29
	add	x1, x1, :lo12:.L.str.17
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.Lfunc_end12:
	.size	mas_blk_flush_reduced_queue_unregister, .Lfunc_end12-mas_blk_flush_reduced_queue_unregister
                                        // -- End function
	.globl	blk_mq_tagset_direct_flush_register // -- Begin function blk_mq_tagset_direct_flush_register
	.p2align	3
	.type	blk_mq_tagset_direct_flush_register,@function
blk_mq_tagset_direct_flush_register:    // @blk_mq_tagset_direct_flush_register
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	cbz	x20, .LBB13_3
// %bb.1:
	str	x19, [x20, #72]
.LBB13_2:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.LBB13_3:
	adrp	x0, .L.str.18
	adrp	x1, .L__func__.blk_mq_tagset_direct_flush_register
	add	x0, x0, :lo12:.L.str.18
	add	x1, x1, :lo12:.L__func__.blk_mq_tagset_direct_flush_register
	bl	printk
	b	.LBB13_2
.Lfunc_end13:
	.size	blk_mq_tagset_direct_flush_register, .Lfunc_end13-blk_mq_tagset_direct_flush_register
                                        // -- End function
	.globl	mas_blk_queue_async_flush_init // -- Begin function mas_blk_queue_async_flush_init
	.p2align	3
	.type	mas_blk_queue_async_flush_init,@function
mas_blk_queue_async_flush_init:         // @mas_blk_queue_async_flush_init
// %bb.0:
	str	x23, [sp, #-64]!        // 8-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	bl	_mcount
	mov	x0, x19
	bl	mas_blk_get_lld
	ldrb	w8, [x0, #24]
	tbz	w8, #2, .LBB14_12
// %bb.1:
	adrp	x21, blk_async_flush_workqueue
	mov	x20, x0
	ldr	x8, [x21, :lo12:blk_async_flush_workqueue]
	cbnz	x8, .LBB14_3
// %bb.2:
	adrp	x0, .L.str.20
	adrp	x3, mas_blk_queue_async_flush_init.__key
	adrp	x4, .L.str.19
	add	x0, x0, :lo12:.L.str.20
	add	x3, x3, :lo12:mas_blk_queue_async_flush_init.__key
	add	x4, x4, :lo12:.L.str.19
	orr	w1, wzr, #0x2
	mov	w2, wzr
	bl	__alloc_workqueue_key
	str	x0, [x21, :lo12:blk_async_flush_workqueue]
	cbz	x0, .LBB14_13
.LBB14_3:
	str	wzr, [x19, #2116]
	add	x21, x19, #2120         // =2120
	ldr	x8, [x19, #2120]
	cbnz	x8, .LBB14_6
// %bb.4:
	ldr	x8, [x19, #2128]
	cbnz	x8, .LBB14_6
// %bb.5:
	str	x21, [x19, #2120]
	str	x21, [x19, #2128]
.LBB14_6:
	adrp	x1, .L.str.23
	adrp	x2, mas_blk_queue_async_flush_init.__key.22
	mov	x8, #68719476704
	add	x0, x19, #1944          // =1944
	add	x1, x1, :lo12:.L.str.23
	add	x2, x2, :lo12:mas_blk_queue_async_flush_init.__key.22
	str	x8, [x19, #1912]
	mov	w3, wzr
	bl	lockdep_init_map
	adrp	x9, __cfi_mas_blk_flush_work_fn
	adrp	x1, delayed_work_timer_fn
	adrp	x3, .L.str.25
	adrp	x4, mas_blk_queue_async_flush_init.__key.24
	add	x8, x19, #1920          // =1920
	add	x9, x9, :lo12:__cfi_mas_blk_flush_work_fn
	add	x0, x19, #2000          // =2000
	add	x1, x1, :lo12:delayed_work_timer_fn
	str	x8, [x19, #1920]
	add	x3, x3, :lo12:.L.str.25
	str	x8, [x19, #1928]
	add	x4, x4, :lo12:mas_blk_queue_async_flush_init.__key.24
	str	x9, [x19, #1936]
	orr	w2, wzr, #0x200000
	bl	init_timer_key
	ldr	x8, [x20, #56]
	cbz	x8, .LBB14_11
// %bb.7:
	ldr	x8, [x21]
	cmp	x21, x8
	b.ne	.LBB14_11
// %bb.8:
	adrp	x0, all_flush_q_lock
	add	x0, x0, :lo12:all_flush_q_lock
	bl	_raw_spin_lock_irqsave
	adrp	x22, all_flush_q_list
	add	x22, x22, :lo12:all_flush_q_list
	mov	x20, x0
	mov	x0, x21
	ldr	x23, [x22]
	mov	x1, x22
	mov	x2, x23
	bl	__list_add_valid
	tbz	w0, #0, .LBB14_10
// %bb.9:
	adrp	x8, all_flush_q_list
	str	x21, [x23, #8]
	str	x23, [x19, #2120]
	str	x22, [x19, #2128]
	str	x21, [x8, :lo12:all_flush_q_list]
.LBB14_10:
	adrp	x0, all_flush_q_lock
	add	x0, x0, :lo12:all_flush_q_lock
	mov	x1, x20
	bl	_raw_spin_unlock_irqrestore
.LBB14_11:
	orr	w8, wzr, #0x1
	str	w8, [x19, #2136]
.LBB14_12:
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldr	x23, [sp], #64          // 8-byte Folded Reload
	ret
.LBB14_13:
	adrp	x0, .L.str.21
	adrp	x1, .L__func__.mas_blk_queue_async_flush_init
	add	x0, x0, :lo12:.L.str.21
	add	x1, x1, :lo12:.L__func__.mas_blk_queue_async_flush_init
	bl	printk
	b	.LBB14_12
.Lfunc_end14:
	.size	mas_blk_queue_async_flush_init, .Lfunc_end14-mas_blk_queue_async_flush_init
                                        // -- End function
	.globl	blk_flush_set_async     // -- Begin function blk_flush_set_async
	.p2align	3
	.type	blk_flush_set_async,@function
blk_flush_set_async:                    // @blk_flush_set_async
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	cbz	x19, .LBB15_2
// %bb.1:
	orr	w8, wzr, #0x1
	strb	w8, [x19, #154]
.LBB15_2:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end15:
	.size	blk_flush_set_async, .Lfunc_end15-blk_flush_set_async
                                        // -- End function
	.globl	blk_mq_tagset_flush_reduce_config // -- Begin function blk_mq_tagset_flush_reduce_config
	.p2align	3
	.type	blk_mq_tagset_flush_reduce_config,@function
blk_mq_tagset_flush_reduce_config:      // @blk_mq_tagset_flush_reduce_config
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	w20, w1
	mov	x19, x0
	bl	_mcount
	cbz	x19, .LBB16_3
// %bb.1:
	ldr	x8, [x19, #40]
	tst	w20, #0x1
	orr	x9, x8, #0x4
	and	x8, x8, #0xfffffffffffffffb
	csel	x8, x9, x8, ne
	str	x8, [x19, #40]
.LBB16_2:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.LBB16_3:
	adrp	x0, .L.str.18
	adrp	x1, .L__func__.blk_mq_tagset_flush_reduce_config
	add	x0, x0, :lo12:.L.str.18
	add	x1, x1, :lo12:.L__func__.blk_mq_tagset_flush_reduce_config
	bl	printk
	b	.LBB16_2
.Lfunc_end16:
	.size	blk_mq_tagset_flush_reduce_config, .Lfunc_end16-blk_mq_tagset_flush_reduce_config
                                        // -- End function
	.globl	blk_flush_async_support // -- Begin function blk_flush_async_support
	.p2align	3
	.type	blk_flush_async_support,@function
blk_flush_async_support:                // @blk_flush_async_support
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	cbz	x19, .LBB17_3
// %bb.1:
	ldr	x8, [x19, #280]
	ldr	x8, [x8, #1712]
	cbz	x8, .LBB17_4
// %bb.2:
	ldr	w0, [x8, #2136]
	b	.LBB17_5
.LBB17_3:
	adrp	x0, .L.str.26
	adrp	x1, .L__func__.blk_flush_async_support
	add	x0, x0, :lo12:.L.str.26
	add	x1, x1, :lo12:.L__func__.blk_flush_async_support
	bl	printk
.LBB17_4:
	mov	w0, wzr
.LBB17_5:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end17:
	.size	blk_flush_async_support, .Lfunc_end17-blk_flush_async_support
                                        // -- End function
	.type	.L.str,@object          // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"\0013[BLK-IO]%s: blkdev_get fail!\n"
	.size	.L.str, 32

	.type	.L__func__.mas_blk_flush_work_fn,@object // @__func__.mas_blk_flush_work_fn
.L__func__.mas_blk_flush_work_fn:
	.asciz	"mas_blk_flush_work_fn"
	.size	.L__func__.mas_blk_flush_work_fn, 22

	.type	.L.str.1,@object        // @.str.1
.L.str.1:
	.asciz	"\0013[BLK-IO]%s: blkdev_issue_flush fail!\n"
	.size	.L.str.1, 40

	.type	blk_async_flush_workqueue,@object // @blk_async_flush_workqueue
	.local	blk_async_flush_workqueue
	.comm	blk_async_flush_workqueue,8,8
	.type	.L.str.2,@object        // @.str.2
.L.str.2:
	.asciz	"\0013[BLK-IO]%s: emergency = %d\n"
	.size	.L.str.2, 30

	.type	.L__func__.blk_power_off_flush,@object // @__func__.blk_power_off_flush
.L__func__.blk_power_off_flush:
	.asciz	"blk_power_off_flush"
	.size	.L__func__.blk_power_off_flush, 20

	.type	all_flush_q_lock,@object // @all_flush_q_lock
	.data
	.p2align	3
all_flush_q_lock:
	.zero	4
	.word	3735899821              // 0xdead4ead
	.word	4294967295              // 0xffffffff
	.zero	4
	.xword	-1
	.xword	0
	.zero	16
	.xword	.L.str.27
	.word	0                       // 0x0
	.zero	4
	.xword	0                       // 0x0
	.xword	0                       // 0x0
	.size	all_flush_q_lock, 80

	.type	all_flush_q_list,@object // @all_flush_q_list
	.p2align	3
all_flush_q_list:
	.xword	all_flush_q_list
	.xword	all_flush_q_list
	.size	all_flush_q_list, 16

	.type	.L.str.3,@object        // @.str.3
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.3:
	.asciz	"\0013[BLK-IO]%s: emergency flush on %s\n"
	.size	.L.str.3, 37

	.type	.L.str.4,@object        // @.str.4
.L.str.4:
	.asciz	"\0013[BLK-IO]%s: emergency flush on %s done!\n"
	.size	.L.str.4, 43

	.type	.L.str.5,@object        // @.str.5
.L.str.5:
	.asciz	"\0013[BLK-IO]%s: done!\n"
	.size	.L.str.5, 21

	.type	all_object_lock,@object // @all_object_lock
	.data
	.p2align	3
all_object_lock:
	.zero	4
	.word	3735899821              // 0xdead4ead
	.word	4294967295              // 0xffffffff
	.zero	4
	.xword	-1
	.xword	0
	.zero	16
	.xword	.L.str.28
	.word	0                       // 0x0
	.zero	4
	.xword	0                       // 0x0
	.xword	0                       // 0x0
	.size	all_object_lock, 80

	.type	all_object_list,@object // @all_object_list
	.p2align	3
all_object_list:
	.xword	all_object_list
	.xword	all_object_list
	.size	all_object_list, 16

	.type	.L.str.6,@object        // @.str.6
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.6:
	.asciz	"\0013[BLK-IO]<%s> start\n"
	.size	.L.str.6, 22

	.type	.L__func__.mas_blk_order_panic_wait_flush,@object // @__func__.mas_blk_order_panic_wait_flush
.L__func__.mas_blk_order_panic_wait_flush:
	.asciz	"mas_blk_order_panic_wait_flush"
	.size	.L__func__.mas_blk_order_panic_wait_flush, 31

	.type	.L.str.7,@object        // @.str.7
.L.str.7:
	.asciz	"\0013[BLK-IO]<%s> type = %d\n"
	.size	.L.str.7, 26

	.type	.L.str.8,@object        // @.str.8
.L.str.8:
	.asciz	"\0013[BLK-IO]<%s> normal end\n"
	.size	.L.str.8, 27

	.type	.L.str.9,@object        // @.str.9
.L.str.9:
	.asciz	"\0013[BLK-IO]<%s> timeout end\n"
	.size	.L.str.9, 28

	.type	.L__func__.mas_blk_panic_flush,@object // @__func__.mas_blk_panic_flush
.L__func__.mas_blk_panic_flush:
	.asciz	"mas_blk_panic_flush"
	.size	.L__func__.mas_blk_panic_flush, 20

	.type	mas_blk_order_power_off_work,@object // @mas_blk_order_power_off_work
	.local	mas_blk_order_power_off_work
	.comm	mas_blk_order_power_off_work,200,8
	.type	mas_blk_power_off_work,@object // @mas_blk_power_off_work
	.local	mas_blk_power_off_work
	.comm	mas_blk_power_off_work,200,8
	.type	mas_blk_flush_init.__key,@object // @mas_blk_flush_init.__key
	.local	mas_blk_flush_init.__key
	.comm	mas_blk_flush_init.__key,8,1
	.type	.L.str.10,@object       // @.str.10
.L.str.10:
	.asciz	"(work_completion)(&(&mas_blk_power_off_work)->work)"
	.size	.L.str.10, 52

	.type	mas_blk_flush_init.__key.11,@object // @mas_blk_flush_init.__key.11
	.local	mas_blk_flush_init.__key.11
	.comm	mas_blk_flush_init.__key.11,8,1
	.type	.L.str.12,@object       // @.str.12
.L.str.12:
	.asciz	"&(&mas_blk_power_off_work)->timer"
	.size	.L.str.12, 34

	.type	mas_blk_flush_init.__key.13,@object // @mas_blk_flush_init.__key.13
	.local	mas_blk_flush_init.__key.13
	.comm	mas_blk_flush_init.__key.13,8,1
	.type	.L.str.14,@object       // @.str.14
.L.str.14:
	.asciz	"(work_completion)(&(&mas_blk_order_power_off_work)->work)"
	.size	.L.str.14, 58

	.type	mas_blk_flush_init.__key.15,@object // @mas_blk_flush_init.__key.15
	.local	mas_blk_flush_init.__key.15
	.comm	mas_blk_flush_init.__key.15,8,1
	.type	.L.str.16,@object       // @.str.16
.L.str.16:
	.asciz	"&(&mas_blk_order_power_off_work)->timer"
	.size	.L.str.16, 40

	.type	mas_blk_poweroff_flush_nb,@object // @mas_blk_poweroff_flush_nb
	.data
	.p2align	3
mas_blk_poweroff_flush_nb:
	.xword	__cfi_mas_blk_poweroff_flush_notifier_call
	.xword	0
	.word	0                       // 0x0
	.zero	4
	.size	mas_blk_poweroff_flush_nb, 24

	.type	__addressable___cfi_mas_blk_flush_init313,@object // @__addressable___cfi_mas_blk_flush_init313
	.section	.discard.addressable,"aw",@progbits
	.p2align	3
__addressable___cfi_mas_blk_flush_init313:
	.xword	__cfi_mas_blk_flush_init
	.size	__addressable___cfi_mas_blk_flush_init313, 8

	.type	.L.str.17,@object       // @.str.17
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.17:
	.asciz	"Invalid flush_queue_node!"
	.size	.L.str.17, 26

	.type	.L.str.18,@object       // @.str.18
.L.str.18:
	.asciz	"\0013[BLK-IO]%s: tag_set is NULL!\n"
	.size	.L.str.18, 32

	.type	.L__func__.blk_mq_tagset_direct_flush_register,@object // @__func__.blk_mq_tagset_direct_flush_register
.L__func__.blk_mq_tagset_direct_flush_register:
	.asciz	"blk_mq_tagset_direct_flush_register"
	.size	.L__func__.blk_mq_tagset_direct_flush_register, 36

	.type	mas_blk_queue_async_flush_init.__key,@object // @mas_blk_queue_async_flush_init.__key
	.local	mas_blk_queue_async_flush_init.__key
	.comm	mas_blk_queue_async_flush_init.__key,8,1
	.type	.L.str.19,@object       // @.str.19
.L.str.19:
	.asciz	"(wq_completion)\"async_flush\""
	.size	.L.str.19, 29

	.type	.L.str.20,@object       // @.str.20
.L.str.20:
	.asciz	"async_flush"
	.size	.L.str.20, 12

	.type	.L.str.21,@object       // @.str.21
.L.str.21:
	.asciz	"\0013[BLK-IO]%s: Failed to alloc workqueue!\n"
	.size	.L.str.21, 42

	.type	.L__func__.mas_blk_queue_async_flush_init,@object // @__func__.mas_blk_queue_async_flush_init
.L__func__.mas_blk_queue_async_flush_init:
	.asciz	"mas_blk_queue_async_flush_init"
	.size	.L__func__.mas_blk_queue_async_flush_init, 31

	.type	mas_blk_queue_async_flush_init.__key.22,@object // @mas_blk_queue_async_flush_init.__key.22
	.local	mas_blk_queue_async_flush_init.__key.22
	.comm	mas_blk_queue_async_flush_init.__key.22,8,1
	.type	.L.str.23,@object       // @.str.23
.L.str.23:
	.asciz	"(work_completion)(&(&mas_queue->flush_work)->work)"
	.size	.L.str.23, 51

	.type	mas_blk_queue_async_flush_init.__key.24,@object // @mas_blk_queue_async_flush_init.__key.24
	.local	mas_blk_queue_async_flush_init.__key.24
	.comm	mas_blk_queue_async_flush_init.__key.24,8,1
	.type	.L.str.25,@object       // @.str.25
.L.str.25:
	.asciz	"&(&mas_queue->flush_work)->timer"
	.size	.L.str.25, 33

	.type	.L__func__.blk_mq_tagset_flush_reduce_config,@object // @__func__.blk_mq_tagset_flush_reduce_config
.L__func__.blk_mq_tagset_flush_reduce_config:
	.asciz	"blk_mq_tagset_flush_reduce_config"
	.size	.L__func__.blk_mq_tagset_flush_reduce_config, 34

	.type	.L.str.26,@object       // @.str.26
.L.str.26:
	.asciz	"\0013[BLK-IO]%s: bi_bdev is NULL!\n"
	.size	.L.str.26, 32

	.type	.L__func__.blk_flush_async_support,@object // @__func__.blk_flush_async_support
.L__func__.blk_flush_async_support:
	.asciz	"blk_flush_async_support"
	.size	.L__func__.blk_flush_async_support, 24

	.type	.L.str.27,@object       // @.str.27
.L.str.27:
	.asciz	"all_flush_q_lock"
	.size	.L.str.27, 17

	.type	.L.str.28,@object       // @.str.28
.L.str.28:
	.asciz	"all_object_lock"
	.size	.L.str.28, 16

	.type	.L__func__.mas_blk_order_poweroff_proc,@object // @__func__.mas_blk_order_poweroff_proc
.L__func__.mas_blk_order_poweroff_proc:
	.asciz	"mas_blk_order_poweroff_proc"
	.size	.L__func__.mas_blk_order_poweroff_proc, 28

	.type	.L.str.29,@object       // @.str.29
.L.str.29:
	.asciz	"\0013[BLK-IO]%s\n"
	.size	.L.str.29, 14


	.ident	"Snapdragon LLVM ARM Compiler 8.0.12 for Android NDK (based on llvm.org 7.0+)"
	.section	".note.GNU-stack","",@progbits
