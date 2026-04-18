	.text
	.file	"mas_ufs.c"
	.globl	mas_ufshcd_prepare_req_desc_hdr // -- Begin function mas_ufshcd_prepare_req_desc_hdr
	.p2align	3
	.type	mas_ufshcd_prepare_req_desc_hdr,@function
mas_ufshcd_prepare_req_desc_hdr:        // @mas_ufshcd_prepare_req_desc_hdr
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	ldr	x8, [x20, #64]
	cbz	x8, .LBB0_5
// %bb.1:
	ldr	x9, [x8, #432]
	cbz	x9, .LBB0_3
// %bb.2:
	ldrb	w9, [x9, #240]
	tbnz	w9, #0, .LBB0_6
.LBB0_3:
	ldr	x8, [x8, #432]
	cbz	x8, .LBB0_5
// %bb.4:
	ldrb	w8, [x8, #240]
	tbnz	w8, #1, .LBB0_7
.LBB0_5:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.LBB0_6:
	ldr	w8, [x19]
	orr	w8, w8, #0x2
	str	w8, [x19]
	ldr	x8, [x20, #64]
	cbnz	x8, .LBB0_3
	b	.LBB0_5
.LBB0_7:
	ldr	w8, [x19]
	orr	w8, w8, #0x4
	str	w8, [x19]
	b	.LBB0_5
.Lfunc_end0:
	.size	mas_ufshcd_prepare_req_desc_hdr, .Lfunc_end0-mas_ufshcd_prepare_req_desc_hdr
                                        // -- End function
	.globl	mas_ufshcd_slave_config // -- Begin function mas_ufshcd_slave_config
	.p2align	3
	.type	mas_ufshcd_slave_config,@function
mas_ufshcd_slave_config:                // @mas_ufshcd_slave_config
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	bl	_mcount
	mov	x0, x19
	bl	mas_ufs_manual_bkops_config
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end1:
	.size	mas_ufshcd_slave_config, .Lfunc_end1-mas_ufshcd_slave_config
                                        // -- End function
	.globl	ufshcd_send_scsi_sync_cache_init // -- Begin function ufshcd_send_scsi_sync_cache_init
	.p2align	3
	.type	ufshcd_send_scsi_sync_cache_init,@function
ufshcd_send_scsi_sync_cache_init:       // @ufshcd_send_scsi_sync_cache_init
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	bl	_mcount
	adrp	x19, sync_cache_buffer
	ldr	x8, [x19, :lo12:sync_cache_buffer]
	cbnz	x8, .LBB2_2
// %bb.1:
	adrp	x8, kmalloc_caches
	add	x8, x8, :lo12:kmalloc_caches
	mov	w1, #32960
	movk	w1, #96, lsl #16
	ldr	x0, [x8, #56]
	orr	w2, wzr, #0x60
	bl	kmem_cache_alloc_trace
	str	x0, [x19, :lo12:sync_cache_buffer]
	cbz	x0, .LBB2_4
.LBB2_2:
	mov	w0, wzr
.LBB2_3:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.LBB2_4:
	mov	w0, #-12
	b	.LBB2_3
.Lfunc_end2:
	.size	ufshcd_send_scsi_sync_cache_init, .Lfunc_end2-ufshcd_send_scsi_sync_cache_init
                                        // -- End function
	.globl	ufshcd_send_scsi_sync_cache_deinit // -- Begin function ufshcd_send_scsi_sync_cache_deinit
	.p2align	3
	.type	ufshcd_send_scsi_sync_cache_deinit,@function
ufshcd_send_scsi_sync_cache_deinit:     // @ufshcd_send_scsi_sync_cache_deinit
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	bl	_mcount
	adrp	x19, sync_cache_buffer
	ldr	x0, [x19, :lo12:sync_cache_buffer]
	cbz	x0, .LBB3_2
// %bb.1:
	bl	kfree
	str	xzr, [x19, :lo12:sync_cache_buffer]
.LBB3_2:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end3:
	.size	ufshcd_send_scsi_sync_cache_deinit, .Lfunc_end3-ufshcd_send_scsi_sync_cache_deinit
                                        // -- End function
	.globl	__ufshcd_wait_for_doorbell_clr // -- Begin function __ufshcd_wait_for_doorbell_clr
	.p2align	3
	.type	__ufshcd_wait_for_doorbell_clr,@function
__ufshcd_wait_for_doorbell_clr:         // @__ufshcd_wait_for_doorbell_clr
// %bb.0:
	str	x23, [sp, #-64]!        // 8-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	bl	_mcount
	bl	ktime_get
	ldr	x8, [x19]
	mov	x20, x0
	orr	w0, wzr, #0x1
	add	x21, x8, #120           // =120
	mov	x1, x21
	bl	uncached_logk
	//APP
	b .+4

	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	b .+4

	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	.if 1 == 1
661:
	ldr w21, [x21]
662:
.pushsection .altinstructions,"a"
 .word 661b - .
 .if 0 == 0
 .word 663f - .
 .else
 .word 0- .
 .endif
 .hword 1
 .byte 662b-661b
 .byte 664f-663f
.popsection
 .if 0 == 0
.pushsection .altinstr_replacement, "a"
663:
	ldar w21, [x21]
664:
	.popsection
	.org	. - (664b-663b) + (662b-661b)
	.org	. - (662b-661b) + (664b-663b)
.else
	663:
	664:
	.endif
.endif

	//NO_APP
	cbz	w0, .LBB4_2
// %bb.1:
	//APP
	dsb sy
	//NO_APP
	//APP
	isb
	//NO_APP
.LBB4_2:
	mov	w8, w21
	//APP
	dsb ld
	//NO_APP
	orr	w0, wzr, #0x1
	//APP
	eor	x8, x8, x8
cbnz	x8, .
	//NO_APP
	ldr	x8, [x19]
	add	x22, x8, #88            // =88
	mov	x1, x22
	bl	uncached_logk
	//APP
	b .+4

	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	b .+4

	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	.if 1 == 1
661:
	ldr w4, [x22]
662:
.pushsection .altinstructions,"a"
 .word 661b - .
 .if 0 == 0
 .word 663f - .
 .else
 .word 0- .
 .endif
 .hword 1
 .byte 662b-661b
 .byte 664f-663f
.popsection
 .if 0 == 0
.pushsection .altinstr_replacement, "a"
663:
	ldar w4, [x22]
664:
	.popsection
	.org	. - (664b-663b) + (662b-661b)
	.org	. - (662b-661b) + (664b-663b)
.else
	663:
	664:
	.endif
.endif

	//NO_APP
	cbz	w0, .LBB4_4
// %bb.3:
	//APP
	dsb sy
	//NO_APP
	//APP
	isb
	//NO_APP
.LBB4_4:
	mov	w8, w4
	//APP
	dsb ld
	//NO_APP
	orr	w9, w4, w21
	//APP
	eor	x8, x8, x8
cbnz	x8, .
	//NO_APP
	cbz	w9, .LBB4_13
// %bb.5:
	ldr	x0, [x19, #5272]
	adrp	x1, .L.str.26
	adrp	x2, .L.str
	add	x1, x1, :lo12:.L.str.26
	add	x2, x2, :lo12:.L.str
	mov	w3, w21
	bl	_dev_err
	mov	w23, #38888
	movk	w23, #30517, lsl #16
.LBB4_6:                                // =>This Inner Loop Header: Depth=1
	ldr	x8, [x19]
	orr	w0, wzr, #0x1
	add	x21, x8, #120           // =120
	mov	x1, x21
	bl	uncached_logk
	//APP
	b .+4

	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	b .+4

	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	.if 1 == 1
661:
	ldr w21, [x21]
662:
.pushsection .altinstructions,"a"
 .word 661b - .
 .if 0 == 0
 .word 663f - .
 .else
 .word 0- .
 .endif
 .hword 1
 .byte 662b-661b
 .byte 664f-663f
.popsection
 .if 0 == 0
.pushsection .altinstr_replacement, "a"
663:
	ldar w21, [x21]
664:
	.popsection
	.org	. - (664b-663b) + (662b-661b)
	.org	. - (662b-661b) + (664b-663b)
.else
	663:
	664:
	.endif
.endif

	//NO_APP
	cbz	w0, .LBB4_8
// %bb.7:                               //   in Loop: Header=BB4_6 Depth=1
	//APP
	dsb sy
	//NO_APP
	//APP
	isb
	//NO_APP
.LBB4_8:                                //   in Loop: Header=BB4_6 Depth=1
	mov	w8, w21
	//APP
	dsb ld
	//NO_APP
	orr	w0, wzr, #0x1
	//APP
	eor	x8, x8, x8
cbnz	x8, .
	//NO_APP
	ldr	x8, [x19]
	add	x22, x8, #88            // =88
	mov	x1, x22
	bl	uncached_logk
	//APP
	b .+4

	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	b .+4

	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	.if 1 == 1
661:
	ldr w22, [x22]
662:
.pushsection .altinstructions,"a"
 .word 661b - .
 .if 0 == 0
 .word 663f - .
 .else
 .word 0- .
 .endif
 .hword 1
 .byte 662b-661b
 .byte 664f-663f
.popsection
 .if 0 == 0
.pushsection .altinstr_replacement, "a"
663:
	ldar w22, [x22]
664:
	.popsection
	.org	. - (664b-663b) + (662b-661b)
	.org	. - (662b-661b) + (664b-663b)
.else
	663:
	664:
	.endif
.endif

	//NO_APP
	cbz	w0, .LBB4_10
// %bb.9:                               //   in Loop: Header=BB4_6 Depth=1
	//APP
	dsb sy
	//NO_APP
	//APP
	isb
	//NO_APP
.LBB4_10:                               //   in Loop: Header=BB4_6 Depth=1
	mov	w8, w22
	//APP
	dsb ld
	//NO_APP
	//APP
	eor	x8, x8, x8
cbnz	x8, .
	//NO_APP
	bl	ktime_get
	sub	x8, x0, x20
	cmp	x8, x23
	b.ge	.LBB4_14
// %bb.11:                              //   in Loop: Header=BB4_6 Depth=1
	orr	w8, w22, w21
	cbnz	w8, .LBB4_6
// %bb.12:
	mov	w20, wzr
	b	.LBB4_15
.LBB4_13:
	mov	w20, wzr
	b	.LBB4_16
.LBB4_14:
	ldr	x0, [x19, #5272]
	adrp	x1, .L.str.1
	add	x1, x1, :lo12:.L.str.1
	bl	_dev_err
	orr	w20, wzr, #0xfffffffb
.LBB4_15:
	ldr	x0, [x19, #5272]
	adrp	x1, .L.str.26
	adrp	x2, .L.str.2
	add	x1, x1, :lo12:.L.str.26
	add	x2, x2, :lo12:.L.str.2
	mov	w3, w21
	mov	w4, w22
	bl	_dev_err
.LBB4_16:
	mov	w0, w20
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldr	x23, [sp], #64          // 8-byte Folded Reload
	ret
.Lfunc_end4:
	.size	__ufshcd_wait_for_doorbell_clr, .Lfunc_end4-__ufshcd_wait_for_doorbell_clr
                                        // -- End function
	.globl	ufshcd_direct_flush_test // -- Begin function ufshcd_direct_flush_test
	.p2align	3
	.type	ufshcd_direct_flush_test,@function
ufshcd_direct_flush_test:               // @ufshcd_direct_flush_test
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	adrp	x20, .L__func__.ufshcd_direct_flush_test
	adrp	x0, .L.str.3
	add	x20, x20, :lo12:.L__func__.ufshcd_direct_flush_test
	add	x0, x0, :lo12:.L.str.3
	mov	w2, #281
	mov	x1, x20
	bl	printk
	ldr	x0, [x19, #672]
	bl	ufshcd_direct_flush
	mov	w19, w0
	adrp	x0, .L.str.4
	add	x0, x0, :lo12:.L.str.4
	mov	w2, #283
	mov	x1, x20
	bl	printk
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	mov	w0, w19
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end5:
	.size	ufshcd_direct_flush_test, .Lfunc_end5-ufshcd_direct_flush_test
                                        // -- End function
	.globl	ufshcd_direct_flush     // -- Begin function ufshcd_direct_flush
	.p2align	3
	.type	ufshcd_direct_flush,@function
ufshcd_direct_flush:                    // @ufshcd_direct_flush
// %bb.0:
	stp	x28, x27, [sp, #-96]!   // 16-byte Folded Spill
	stp	x26, x25, [sp, #16]     // 16-byte Folded Spill
	stp	x24, x23, [sp, #32]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #48]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #64]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #80]     // 16-byte Folded Spill
	add	x29, sp, #80            // =80
	sub	sp, sp, #640            // =640
	adrp	x8, __stack_chk_guard
	mov	x19, x0
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	stur	x8, [x29, #-96]
	bl	_mcount
	cbz	x19, .LBB6_30
// %bb.1:
	ldr	x24, [x19]
	mov	w8, #5144
	adds	x20, x24, x8
	b.eq	.LBB6_31
// %bb.2:
	mov	w8, #32728
	ldrb	w8, [x24, x8]
	cbnz	w8, .LBB6_4
// %bb.3:
	ldr	w8, [x24, #10544]
	cbz	w8, .LBB6_7
.LBB6_4:
	ldr	x0, [x24, #10416]
	adrp	x1, .L.str.7
	adrp	x2, .L__func__.ufshcd_direct_flush
	add	x1, x1, :lo12:.L.str.7
	add	x2, x2, :lo12:.L__func__.ufshcd_direct_flush
	bl	_dev_err
	mov	w22, wzr
.LBB6_5:
	adrp	x9, __stack_chk_guard
	ldur	x8, [x29, #-96]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB6_52
// %bb.6:
	mov	w0, w22
	add	sp, sp, #640            // =640
	ldp	x29, x30, [sp, #80]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]     // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]     // 16-byte Folded Reload
	ldp	x28, x27, [sp], #96     // 16-byte Folded Reload
	ret
.LBB6_7:
	mov	w23, #34464
	movk	w23, #1, lsl #16
	mov	w22, #42950
.LBB6_8:                                // =>This Inner Loop Header: Depth=1
	//APP
	mrs	x21, daif		// arch_local_irq_save
msr	daifset, #2
	//NO_APP
	bl	trace_hardirqs_off
	ldr	x8, [x24, #10408]
	ldr	x0, [x8, #128]
	bl	_raw_spin_trylock
	cbnz	w0, .LBB6_14
// %bb.9:                               //   in Loop: Header=BB6_8 Depth=1
	sxtb	w8, w21
	tbnz	w8, #31, .LBB6_11
// %bb.10:                              //   in Loop: Header=BB6_8 Depth=1
	bl	trace_hardirqs_on
	//APP
	msr	daif, x21		// arch_local_irq_restore
	//NO_APP
	b	.LBB6_12
.LBB6_11:                               //   in Loop: Header=BB6_8 Depth=1
	//APP
	msr	daif, x21		// arch_local_irq_restore
	//NO_APP
	bl	trace_hardirqs_off
.LBB6_12:                               //   in Loop: Header=BB6_8 Depth=1
	mov	x0, x22
	bl	__const_udelay
	subs	w23, w23, #1            // =1
	b.ne	.LBB6_8
// %bb.13:
	ldr	x0, [x24, #10416]
	adrp	x1, .L.str.8
	adrp	x2, .L__func__.ufshcd_direct_flush
	add	x1, x1, :lo12:.L.str.8
	add	x2, x2, :lo12:.L__func__.ufshcd_direct_flush
	bl	_dev_err
	orr	w22, wzr, #0xfffffffb
	b	.LBB6_5
.LBB6_14:
	mov	x0, x19
	bl	scsi_device_get
	mov	w22, w0
	cbnz	w0, .LBB6_18
// %bb.15:
	ldr	w8, [x19, #3688]
	cmp	w8, #7                  // =7
	b.hi	.LBB6_18
// %bb.16:
	orr	w9, wzr, #0x1
	mov	w10, #208
	lsl	w8, w9, w8
	tst	w8, w10
	b.eq	.LBB6_18
// %bb.17:
	ldr	x0, [x24, #10416]
	adrp	x1, .L.str.9
	adrp	x2, .L__func__.ufshcd_direct_flush
	add	x1, x1, :lo12:.L.str.9
	add	x2, x2, :lo12:.L__func__.ufshcd_direct_flush
	mov	w3, wzr
	bl	_dev_err
	mov	w22, #-19
.LBB6_18:
	ldr	w3, [x20, #5924]
	cmp	w3, #2                  // =2
	b.eq	.LBB6_20
// %bb.19:
	ldr	x0, [x24, #10416]
	adrp	x1, .L.str.10
	adrp	x2, .L__func__.ufshcd_direct_flush
	add	x1, x1, :lo12:.L.str.10
	add	x2, x2, :lo12:.L__func__.ufshcd_direct_flush
	bl	_dev_err
	mov	w22, #4181
.LBB6_20:
	ldr	x8, [x24, #10408]
	mov	x1, x21
	ldr	x0, [x8, #128]
	bl	_raw_spin_unlock_irqrestore
	cbnz	w22, .LBB6_29
// %bb.21:
	mov	w8, #53
	str	xzr, [sp, #64]
	mov	w2, #544
	strh	wzr, [sp, #72]
	add	x0, sp, #80             // =80
	mov	w1, wzr
	strb	w8, [sp, #64]
	bl	memset
	adrp	x8, sync_cache_buffer
	add	x0, sp, #80             // =80
	add	x2, sp, #64             // =64
	ldr	x3, [x8, :lo12:sync_cache_buffer]
	orr	w4, wzr, #0x3
	mov	x1, x19
	mov	x5, xzr
	mov	w6, wzr
	mov	w7, wzr
	bl	ufshcd_compose_scsi_cmd
	str	wzr, [sp, #60]
	str	wzr, [sp, #56]
	ldr	x0, [x24, #10408]
	bl	scsi_block_requests
	ldr	x0, [x24, #10416]
	orr	w1, wzr, #0x4
	bl	__pm_runtime_resume
	ldr	x8, [x24, #10408]
	ldr	x0, [x8, #128]
	bl	_raw_spin_lock_irqsave
	mov	w8, #32344
	add	x25, x24, x8
	mov	x21, x0
	mov	w26, wzr
	ldrb	w8, [x25]
	tbz	w8, #0, .LBB6_24
// %bb.22:
	mov	w8, #31664
	ldr	w8, [x24, x8]
	cmp	w8, #1                  // =1
	b.ne	.LBB6_28
// %bb.23:
	mov	w8, #31696
	orr	w9, wzr, #0x1
	ldrb	w26, [x24, x8]
	strb	w9, [x24, x8]
.LBB6_24:
	mov	x0, x20
	bl	__ufshcd_wait_for_doorbell_clr
	cbz	w0, .LBB6_33
// %bb.25:
	ldr	x0, [x24, #10416]
	adrp	x1, .L.str.29
	add	x1, x1, :lo12:.L.str.29
	bl	_dev_err
.LBB6_26:
	ldrb	w8, [x25]
	tbz	w8, #0, .LBB6_28
.LBB6_27:
	mov	w8, #31696
	strb	w26, [x24, x8]
.LBB6_28:
	ldr	x8, [x24, #10408]
	mov	x1, x21
	ldr	x0, [x8, #128]
	bl	_raw_spin_unlock_irqrestore
	ldr	x0, [x24, #10416]
	mov	w1, #13
	bl	__pm_runtime_suspend
	ldr	x0, [x24, #10408]
	bl	scsi_unblock_requests
	ldr	x0, [x24, #10416]
	adrp	x1, .L.str.28
	ldr	x3, [x19, #208]
	adrp	x2, .L__func__.ufshcd_send_scsi_sync_cache_on_specified_disk
	add	x1, x1, :lo12:.L.str.28
	add	x2, x2, :lo12:.L__func__.ufshcd_send_scsi_sync_cache_on_specified_disk
	mov	w4, wzr
	bl	_dev_err
	mov	w22, wzr
.LBB6_29:
	mov	x0, x19
	bl	scsi_device_put
	b	.LBB6_5
.LBB6_30:
	adrp	x0, .L.str.5
	add	x0, x0, :lo12:.L.str.5
	b	.LBB6_32
.LBB6_31:
	adrp	x0, .L.str.6
	add	x0, x0, :lo12:.L.str.6
.LBB6_32:
	adrp	x1, .L__func__.ufshcd_direct_flush
	add	x1, x1, :lo12:.L__func__.ufshcd_direct_flush
	bl	printk
	mov	w22, #-19
	b	.LBB6_5
.LBB6_33:
	ldr	x8, [x20]
	orr	w0, wzr, #0x1
	add	x22, x8, #36            // =36
	mov	x1, x22
	bl	uncached_logk
	//APP
	b .+4

	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	b .+4

	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	.if 1 == 1
661:
	ldr w8, [x22]
662:
.pushsection .altinstructions,"a"
 .word 661b - .
 .if 0 == 0
 .word 663f - .
 .else
 .word 0- .
 .endif
 .hword 1
 .byte 662b-661b
 .byte 664f-663f
.popsection
 .if 0 == 0
.pushsection .altinstr_replacement, "a"
663:
	ldar w8, [x22]
664:
	.popsection
	.org	. - (664b-663b) + (662b-661b)
	.org	. - (662b-661b) + (664b-663b)
.else
	663:
	664:
	.endif
.endif

	//NO_APP
	cbz	w0, .LBB6_35
// %bb.34:
	//APP
	dsb sy
	//NO_APP
	//APP
	isb
	//NO_APP
.LBB6_35:
	mov	w9, w8
	str	x21, [sp, #48]          // 8-byte Folded Spill
	//APP
	dsb ld
	//NO_APP
	//APP
	eor	x9, x9, x9
cbnz	x9, .
	//NO_APP
	str	w8, [sp, #60]
	ldr	w8, [sp, #60]
	cbz	w8, .LBB6_38
// %bb.36:
	//APP
	dsb st
	//NO_APP
	orr	w0, wzr, #0x2
	ldr	x8, [x20]
	add	x22, x8, #36            // =36
	mov	x1, x22
	bl	uncached_logk
	mov	w8, wzr
	//APP
	b .+4

	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	b .+4

	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	str w8, [x22]
	//NO_APP
	cbz	w0, .LBB6_38
// %bb.37:
	//APP
	dsb sy
	//NO_APP
	//APP
	isb
	//NO_APP
.LBB6_38:
	ldr	x8, [x24, #10560]
	ldr	w9, [x24, #10588]
	mvn	x10, x8
	rbit	x10, x10
	clz	x27, x10
	cmp	w9, w27
	b.le	.LBB6_49
// %bb.39:
	mov	w9, #10560
	cmn	x8, #1                  // =1
	add	x22, x24, x9
	ldr	x9, [x24, #10552]
	cset	w8, eq
	lsl	x28, x8, #3
	orr	w11, wzr, #0x1
	ldr	x8, [x22, x28]
	add	x1, x9, x27, lsl #7
	add	x10, sp, #80            // =80
	lsl	x23, x11, x27
	mov	x21, x1
	orr	x8, x8, x23
	orr	w9, wzr, #0x60
	mov	x0, x20
	str	x8, [x22, x28]
	str	x10, [x21, #64]!
	str	w9, [x1, #80]
	mov	w9, #49408
	ldr	x8, [sp, #520]
	str	w27, [x1, #92]
	str	x8, [x1, #72]
	ldr	x8, [sp, #136]
	ldr	x8, [x8, #208]
	strb	wzr, [x1, #97]
	str	wzr, [x1, #88]
	and	x10, x8, #0xff00
	orr	w11, w8, #0x80
	and	w8, w8, #0x7f
	cmp	x10, x9
	csel	w8, w11, w8, eq
	strb	w8, [x1, #96]
	bl	ufshcd_compose_upiu
	cbnz	w0, .LBB6_49
// %bb.40:
	mov	w8, #10576
	str	x22, [sp, #32]          // 8-byte Folded Spill
	add	x9, x24, x8
	str	w26, [sp, #44]          // 4-byte Folded Spill
	//APP
	dsb st
	//NO_APP
	orr	w0, wzr, #0x2
	ldr	x8, [x9, x28]
	stp	x23, x28, [sp, #16]     // 16-byte Folded Spill
	str	x9, [sp, #8]            // 8-byte Folded Spill
	orr	x8, x8, x23
	str	x8, [x9, x28]
	//APP
	dsb st
	//NO_APP
	ldr	x8, [x24, #5144]
	add	x22, x8, #88            // =88
	mov	x1, x22
	bl	uncached_logk
	orr	w8, wzr, #0x1
	//APP
	b .+4

	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	b .+4

	//NO_APP
	//APP
	nop
	//NO_APP
	lsl	w28, w8, w27
	//APP
	str w28, [x22]
	//NO_APP
	cbz	w0, .LBB6_42
// %bb.41:
	//APP
	dsb sy
	//NO_APP
	//APP
	isb
	//NO_APP
.LBB6_42:
	mov	w26, #19264
	//APP
	dsb st
	//NO_APP
	mov	w22, #18142
	movk	w26, #76, lsl #16
	movk	w22, #3, lsl #16
.LBB6_43:                               // =>This Inner Loop Header: Depth=1
	ldr	x8, [x20]
	orr	w0, wzr, #0x1
	add	x23, x8, #88            // =88
	mov	x1, x23
	bl	uncached_logk
	//APP
	b .+4

	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	b .+4

	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	.if 1 == 1
661:
	ldr w8, [x23]
662:
.pushsection .altinstructions,"a"
 .word 661b - .
 .if 0 == 0
 .word 663f - .
 .else
 .word 0- .
 .endif
 .hword 1
 .byte 662b-661b
 .byte 664f-663f
.popsection
 .if 0 == 0
.pushsection .altinstr_replacement, "a"
663:
	ldar w8, [x23]
664:
	.popsection
	.org	. - (664b-663b) + (662b-661b)
	.org	. - (662b-661b) + (664b-663b)
.else
	663:
	664:
	.endif
.endif

	//NO_APP
	cbz	w0, .LBB6_45
// %bb.44:                              //   in Loop: Header=BB6_43 Depth=1
	//APP
	dsb sy
	//NO_APP
	//APP
	isb
	//NO_APP
.LBB6_45:                               //   in Loop: Header=BB6_43 Depth=1
	mov	w9, w8
	//APP
	dsb ld
	//NO_APP
	//APP
	eor	x9, x9, x9
cbnz	x9, .
	//NO_APP
	str	w8, [sp, #56]
	ldr	w8, [sp, #56]
	tst	w8, w28
	b.eq	.LBB6_47
// %bb.46:                              //   in Loop: Header=BB6_43 Depth=1
	mov	x0, x22
	bl	__const_udelay
	subs	x26, x26, #50           // =50
	b.ne	.LBB6_43
	b	.LBB6_48
.LBB6_47:
	ldr	x10, [sp, #8]           // 8-byte Folded Reload
	orr	w9, wzr, #0x1
	lsl	x9, x9, x27
	ldr	x8, [x10]
	eor	x8, x8, x9
	str	x8, [x10]
.LBB6_48:
	str	xzr, [x21]
	ldp	x10, x9, [sp, #24]      // 16-byte Folded Reload
	ldr	x11, [sp, #16]          // 8-byte Folded Reload
	ldr	w26, [sp, #44]          // 4-byte Folded Reload
	ldr	x8, [x9, x10]
	bic	x8, x8, x11
	str	x8, [x9, x10]
.LBB6_49:
	ldr	w8, [sp, #60]
	ldr	x21, [sp, #48]          // 8-byte Folded Reload
	cbz	w8, .LBB6_26
// %bb.50:
	//APP
	dsb st
	//NO_APP
	orr	w0, wzr, #0x2
	ldr	x8, [x20]
	add	x20, x8, #36            // =36
	mov	x1, x20
	bl	uncached_logk
	//APP
	b .+4

	//NO_APP
	//APP
	nop
	//NO_APP
	//APP
	b .+4

	//NO_APP
	//APP
	nop
	//NO_APP
	ldr	w8, [sp, #60]
	//APP
	str w8, [x20]
	//NO_APP
	cbz	w0, .LBB6_26
// %bb.51:
	//APP
	dsb sy
	//NO_APP
	//APP
	isb
	//NO_APP
	ldrb	w8, [x25]
	tbnz	w8, #0, .LBB6_27
	b	.LBB6_28
.LBB6_52:
	bl	__stack_chk_fail
.Lfunc_end6:
	.size	ufshcd_direct_flush, .Lfunc_end6-ufshcd_direct_flush
                                        // -- End function
	.globl	ufshcd_dump_status      // -- Begin function ufshcd_dump_status
	.p2align	3
	.type	ufshcd_dump_status,@function
ufshcd_dump_status:                     // @ufshcd_dump_status
// %bb.0:
	stp	x24, x23, [sp, #-64]!   // 16-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	w20, w1
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	mov	x19, x0
	bl	_mcount
	ldr	x0, [x19, #10416]
	adrp	x1, .L.str.11
	ldr	x2, [x19, #10560]
	add	x1, x1, :lo12:.L.str.11
	bl	_dev_err
	cmp	w20, #1                 // =1
	b.ne	.LBB7_4
// %bb.1:
	mov	w8, #10576
	ldrsw	x1, [x19, #10588]
	add	x20, x19, x8
	mov	x0, x20
	mov	x2, xzr
	bl	find_next_bit
	ldr	w8, [x19, #10588]
	mov	x2, x0
	cmp	w8, w2
	b.le	.LBB7_4
// %bb.2:
	mov	x22, #63439
	movk	x22, #58195, lsl #16
	movk	x22, #39845, lsl #32
	adrp	x21, .L.str.12
	movk	x22, #8388, lsl #48
	orr	x23, xzr, #0x100000000
	add	x21, x21, :lo12:.L.str.12
.LBB7_3:                                // =>This Inner Loop Header: Depth=1
	ldr	x8, [x19, #10552]
	lsl	x24, x2, #32
	ldr	x0, [x19, #10416]
	mov	x1, x21
                                        // kill: def $w2 killed $w2 killed $x2
	add	x8, x8, x24, asr #25
	ldp	x9, x8, [x8, #104]
	smulh	x9, x9, x22
	smulh	x8, x8, x22
	asr	x10, x9, #7
	asr	x11, x8, #7
	add	x3, x10, x9, lsr #63
	add	x4, x11, x8, lsr #63
	bl	_dev_err
	ldrsw	x1, [x19, #10588]
	add	x8, x24, x23
	mov	x0, x20
	asr	x2, x8, #32
	bl	find_next_bit
	ldr	w8, [x19, #10588]
	mov	x2, x0
	cmp	w8, w2
	b.gt	.LBB7_3
.LBB7_4:
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldp	x24, x23, [sp], #64     // 16-byte Folded Reload
	ret
.Lfunc_end7:
	.size	ufshcd_dump_status, .Lfunc_end7-ufshcd_dump_status
                                        // -- End function
	.globl	ufshcd_send_scsi_request_sense // -- Begin function ufshcd_send_scsi_request_sense
	.p2align	3
	.type	ufshcd_send_scsi_request_sense,@function
ufshcd_send_scsi_request_sense:         // @ufshcd_send_scsi_request_sense
// %bb.0:
	stp	x28, x25, [sp, #-80]!   // 16-byte Folded Spill
	stp	x24, x23, [sp, #16]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #32]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #48]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #64]     // 16-byte Folded Spill
	add	x29, sp, #64            // =64
	sub	sp, sp, #592            // =592
	adrp	x8, __stack_chk_guard
	mov	w22, w3
	mov	w21, w2
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	mov	x23, x1
	mov	x20, x0
	stur	x8, [x29, #-72]
	bl	_mcount
	adrp	x25, kmalloc_caches
	add	x25, x25, :lo12:kmalloc_caches
	mov	w24, #32960
	movk	w24, #96, lsl #16
	ldr	x0, [x25, #56]
	orr	w8, wzr, #0x60
	orr	w9, wzr, #0x3
	orr	w2, wzr, #0x60
	mov	w1, w24
	strh	w8, [sp, #36]
	str	w9, [sp, #32]
	bl	kmem_cache_alloc_trace
	cbz	x0, .LBB8_5
// %bb.1:
	mov	x19, x0
	ldr	x0, [x25, #96]
	orr	w2, wzr, #0x1000
	mov	w1, w24
	bl	kmem_cache_alloc_trace
	cbz	x0, .LBB8_6
// %bb.2:
	mov	x24, x0
	mov	x0, sp
	orr	w2, wzr, #0x1000
	mov	x1, x24
	bl	sg_init_one
	mov	w2, #544
	add	x0, sp, #40             // =40
	mov	w1, wzr
	bl	memset
	add	x0, sp, #40             // =40
	add	x2, sp, #32             // =32
	orr	w4, wzr, #0x2
	mov	x5, sp
	orr	w6, wzr, #0x1
	orr	w7, wzr, #0x1000
	mov	x1, x23
	mov	x3, x19
	bl	ufshcd_compose_scsi_cmd
	and	w3, w22, #0x1
	add	x1, sp, #40             // =40
	mov	x0, x20
	mov	w2, w21
	bl	ufshcd_queuecommand_directly
	mov	w21, w0
	cbz	w0, .LBB8_4
// %bb.3:
	ldr	x0, [x20, #5272]
	adrp	x1, .L.str.13
	adrp	x2, .L__func__.ufshcd_send_scsi_request_sense
	add	x1, x1, :lo12:.L.str.13
	add	x2, x2, :lo12:.L__func__.ufshcd_send_scsi_request_sense
	mov	w3, w21
	bl	_dev_err
.LBB8_4:
	mov	x0, x24
	bl	kfree
	b	.LBB8_7
.LBB8_5:
	mov	w21, #-12
	b	.LBB8_8
.LBB8_6:
	mov	w21, #-12
.LBB8_7:
	mov	x0, x19
	bl	kfree
.LBB8_8:
	adrp	x9, __stack_chk_guard
	ldur	x8, [x29, #-72]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB8_10
// %bb.9:
	mov	w0, w21
	add	sp, sp, #592            // =592
	ldp	x29, x30, [sp, #64]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]     // 16-byte Folded Reload
	ldp	x28, x25, [sp], #80     // 16-byte Folded Reload
	ret
.LBB8_10:
	bl	__stack_chk_fail
.Lfunc_end8:
	.size	ufshcd_send_scsi_request_sense, .Lfunc_end8-ufshcd_send_scsi_request_sense
                                        // -- End function
	.globl	ufshcd_send_scsi_ssu    // -- Begin function ufshcd_send_scsi_ssu
	.p2align	3
	.type	ufshcd_send_scsi_ssu,@function
ufshcd_send_scsi_ssu:                   // @ufshcd_send_scsi_ssu
// %bb.0:
	stp	x28, x23, [sp, #-64]!   // 16-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	sub	sp, sp, #560            // =560
	adrp	x8, __stack_chk_guard
	mov	w20, w3
	mov	x22, x2
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	mov	x23, x1
	mov	x19, x0
	stur	x8, [x29, #-56]
	bl	_mcount
	adrp	x8, kmalloc_caches
	add	x8, x8, :lo12:kmalloc_caches
	mov	w1, #32960
	movk	w1, #96, lsl #16
	ldr	x0, [x8, #56]
	orr	w2, wzr, #0x60
	bl	kmem_cache_alloc_trace
	cbz	x0, .LBB9_4
// %bb.1:
	mov	x21, x0
	mov	w2, #544
	add	x0, sp, #8              // =8
	mov	w1, wzr
	bl	memset
	add	x0, sp, #8              // =8
	orr	w4, wzr, #0x3
	mov	x1, x23
	mov	x2, x22
	mov	x3, x21
	mov	x5, xzr
	mov	w6, wzr
	mov	w7, wzr
	bl	ufshcd_compose_scsi_cmd
	add	x1, sp, #8              // =8
	orr	w3, wzr, #0x1
	mov	x0, x19
	mov	w2, w20
	bl	ufshcd_queuecommand_directly
	mov	w20, w0
	cbz	w0, .LBB9_3
// %bb.2:
	ldr	x0, [x19, #5272]
	adrp	x1, .L.str.13
	adrp	x2, .L__func__.ufshcd_send_scsi_ssu
	add	x1, x1, :lo12:.L.str.13
	add	x2, x2, :lo12:.L__func__.ufshcd_send_scsi_ssu
	mov	w3, w20
	bl	_dev_err
.LBB9_3:
	mov	x0, x21
	bl	kfree
	b	.LBB9_5
.LBB9_4:
	mov	w20, #-12
.LBB9_5:
	adrp	x9, __stack_chk_guard
	ldur	x8, [x29, #-56]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB9_7
// %bb.6:
	mov	w0, w20
	add	sp, sp, #560            // =560
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldp	x28, x23, [sp], #64     // 16-byte Folded Reload
	ret
.LBB9_7:
	bl	__stack_chk_fail
.Lfunc_end9:
	.size	ufshcd_send_scsi_ssu, .Lfunc_end9-ufshcd_send_scsi_ssu
                                        // -- End function
	.globl	ufshcd_send_scsi_sync_cache // -- Begin function ufshcd_send_scsi_sync_cache
	.p2align	3
	.type	ufshcd_send_scsi_sync_cache,@function
ufshcd_send_scsi_sync_cache:            // @ufshcd_send_scsi_sync_cache
// %bb.0:
	str	x28, [sp, #-96]!        // 8-byte Folded Spill
	stp	x26, x25, [sp, #16]     // 16-byte Folded Spill
	stp	x24, x23, [sp, #32]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #48]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #64]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #80]     // 16-byte Folded Spill
	add	x29, sp, #80            // =80
	sub	sp, sp, #576            // =576
	adrp	x8, __stack_chk_guard
	mov	x22, x1
	mov	x21, x0
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	stur	x8, [x29, #-88]
	bl	_mcount
	strh	wzr, [sp, #16]
	str	xzr, [sp, #8]
	cbz	x22, .LBB10_10
// %bb.1:
	adrp	x23, kmalloc_caches
	add	x23, x23, :lo12:kmalloc_caches
	mov	w20, #32960
	movk	w20, #96, lsl #16
	ldr	x0, [x23, #96]
	mov	w8, #53
	mov	w2, #3704
	mov	w1, w20
	strb	w8, [sp, #8]
	bl	kmem_cache_alloc_trace
	mov	x19, x0
	cbz	x0, .LBB10_11
// %bb.2:
	ldr	x0, [x23, #56]
	orr	w2, wzr, #0x60
	mov	w1, w20
	bl	kmem_cache_alloc_trace
	mov	x20, x0
	cbz	x0, .LBB10_12
// %bb.3:
	mov	w2, #544
	add	x0, sp, #24             // =24
	mov	w1, wzr
	bl	memset
	mov	w8, #25961
	ldr	x9, [x22]
	add	x24, x21, x8
	ldrb	w8, [x24]
	str	x9, [x19]
	cbz	w8, .LBB10_9
// %bb.4:
	mov	x25, xzr
	orr	w26, wzr, #0x1
	mov	w23, #2000
.LBB10_5:                               // =>This Inner Loop Header: Depth=1
	ldr	x9, [x21, #25968]
	ldrb	w9, [x9, x26]
	cbnz	w9, .LBB10_8
// %bb.6:                               //   in Loop: Header=BB10_5 Depth=1
	add	x0, sp, #24             // =24
	str	x25, [x19, #208]
	add	x2, sp, #8              // =8
	orr	w4, wzr, #0x3
	mov	x1, x19
	mov	x3, x20
	mov	x5, xzr
	mov	w6, wzr
	mov	w7, wzr
	bl	ufshcd_compose_scsi_cmd
	add	x1, sp, #24             // =24
	orr	w3, wzr, #0x1
	mov	x0, x21
	mov	w2, w23
	bl	ufshcd_queuecommand_directly
	cbnz	w0, .LBB10_16
// %bb.7:                               //   in Loop: Header=BB10_5 Depth=1
	ldrb	w8, [x24]
.LBB10_8:                               //   in Loop: Header=BB10_5 Depth=1
	add	x25, x25, #1            // =1
	add	x26, x26, #2            // =2
	cmp	x25, w8, uxtb
	b.lo	.LBB10_5
.LBB10_9:
	mov	w22, wzr
	b	.LBB10_13
.LBB10_10:
	mov	w22, #-19
	b	.LBB10_14
.LBB10_11:
	mov	x20, xzr
.LBB10_12:
	mov	w22, #-12
.LBB10_13:
	mov	x0, x19
	bl	kfree
	mov	x0, x20
	bl	kfree
.LBB10_14:
	adrp	x9, __stack_chk_guard
	ldur	x8, [x29, #-88]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB10_17
// %bb.15:
	mov	w0, w22
	add	sp, sp, #576            // =576
	ldp	x29, x30, [sp, #80]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]     // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]     // 16-byte Folded Reload
	ldr	x28, [sp], #96          // 8-byte Folded Reload
	ret
.LBB10_16:
	mov	w22, w0
	ldr	x0, [x21, #5272]
	ldr	x3, [x19, #208]
	adrp	x1, .L.str.14
	adrp	x2, .L__func__.ufshcd_send_scsi_sync_cache
	add	x1, x1, :lo12:.L.str.14
	add	x2, x2, :lo12:.L__func__.ufshcd_send_scsi_sync_cache
	mov	w4, w22
	bl	_dev_err
	b	.LBB10_13
.LBB10_17:
	bl	__stack_chk_fail
.Lfunc_end10:
	.size	ufshcd_send_scsi_sync_cache, .Lfunc_end10-ufshcd_send_scsi_sync_cache
                                        // -- End function
	.globl	mas_ufs_populate_mgc_dt // -- Begin function mas_ufs_populate_mgc_dt
	.p2align	3
	.type	mas_ufs_populate_mgc_dt,@function
mas_ufs_populate_mgc_dt:                // @mas_ufs_populate_mgc_dt
// %bb.0:
	sub	sp, sp, #160            // =160
	adrp	x8, __stack_chk_guard
	stp	x28, x27, [sp, #64]     // 16-byte Folded Spill
	stp	x26, x25, [sp, #80]     // 16-byte Folded Spill
	stp	x24, x23, [sp, #96]     // 16-byte Folded Spill
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	stp	x22, x21, [sp, #112]    // 16-byte Folded Spill
	stp	x20, x19, [sp, #128]    // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #144]    // 16-byte Folded Spill
	add	x29, sp, #144           // =144
	str	x8, [sp, #56]
	bl	_mcount
	ldr	x8, [x19, #5272]
	mov	w9, #28640
	add	x10, x19, x9
	mov	w9, #28656
	add	x9, x19, x9
	ldr	x22, [x8, #1120]
	mov	x1, xzr
	str	x10, [x19, #28640]
	stp	x9, x10, [sp]           // 16-byte Folded Spill
	str	x10, [x19, #28648]
	mov	x0, x22
	str	x9, [x19, #28656]
	str	x9, [x19, #28664]
	bl	of_get_next_child
	cbz	x0, .LBB11_23
// %bb.1:
	add	x8, sp, #32             // =32
	adrp	x26, .L.str.15
	adrp	x27, .L.str.17
	adrp	x28, .L.str.16
	mov	x23, x0
	add	x24, x8, #8             // =8
	add	x8, x8, #16             // =16
	add	x26, x26, :lo12:.L.str.15
	add	x27, x27, :lo12:.L.str.17
	add	x28, x28, :lo12:.L.str.16
	str	x8, [sp, #16]           // 8-byte Folded Spill
	b	.LBB11_19
.LBB11_2:                               //   in Loop: Header=BB11_19 Depth=1
	ldr	x20, [sp, #32]
	mov	x0, x27
	mov	x1, x20
	bl	strcmp
	cbz	w0, .LBB11_5
// %bb.3:                               //   in Loop: Header=BB11_19 Depth=1
	adrp	x0, .L.str.18
	add	x0, x0, :lo12:.L.str.18
	mov	x1, x20
	bl	strcmp
	cbnz	w0, .LBB11_20
// %bb.4:                               //   in Loop: Header=BB11_19 Depth=1
	mov	w20, wzr
	b	.LBB11_6
.LBB11_5:                               //   in Loop: Header=BB11_19 Depth=1
	orr	w20, wzr, #0x1
.LBB11_6:                               //   in Loop: Header=BB11_19 Depth=1
	adrp	x1, .L.str.19
	add	x2, sp, #28             // =28
	orr	w3, wzr, #0x1
	mov	x0, x23
	add	x1, x1, :lo12:.L.str.19
	mov	x4, xzr
	bl	of_property_read_variable_u32_array
	tbnz	w0, #31, .LBB11_9
// %bb.7:                               //   in Loop: Header=BB11_19 Depth=1
	adrp	x1, .L.str.21
	mov	x0, x23
	add	x1, x1, :lo12:.L.str.21
	mov	x2, x24
	bl	of_property_read_string
	cbz	w0, .LBB11_10
// %bb.8:                               //   in Loop: Header=BB11_19 Depth=1
	ldr	x0, [x19, #5272]
	adrp	x1, .L.str.22
	ldr	x2, [x23]
	add	x1, x1, :lo12:.L.str.22
	b	.LBB11_21
.LBB11_9:                               //   in Loop: Header=BB11_19 Depth=1
	ldr	x0, [x19, #5272]
	adrp	x1, .L.str.20
	ldr	x2, [x23]
	add	x1, x1, :lo12:.L.str.20
	b	.LBB11_21
.LBB11_10:                              //   in Loop: Header=BB11_19 Depth=1
	adrp	x1, .L.str.23
	ldr	x2, [sp, #16]           // 8-byte Folded Reload
	mov	x0, x23
	add	x1, x1, :lo12:.L.str.23
	bl	of_property_read_string
	mov	w8, w0
	ldr	x0, [x19, #5272]
	cbz	w8, .LBB11_12
// %bb.11:                              //   in Loop: Header=BB11_19 Depth=1
	ldr	x2, [x23]
	adrp	x1, .L.str.24
	add	x1, x1, :lo12:.L.str.24
	b	.LBB11_21
.LBB11_12:                              //   in Loop: Header=BB11_19 Depth=1
	mov	w2, #32960
	mov	w1, #40
	movk	w2, #96, lsl #16
	bl	devm_kmalloc
	cbz	x0, .LBB11_25
// %bb.13:                              //   in Loop: Header=BB11_19 Depth=1
	ldr	w8, [sp, #28]
	mov	x25, x0
	ldp	x9, x10, [sp, #40]
	add	x21, x0, #24            // =24
	strh	w8, [x0]
	stp	x9, x10, [x0, #8]
	str	x21, [x0, #24]
	str	x21, [x0, #32]
	cbz	w20, .LBB11_16
// %bb.14:                              //   in Loop: Header=BB11_19 Depth=1
	ldr	x1, [sp, #8]            // 8-byte Folded Reload
	mov	x0, x21
	ldr	x20, [x1]
	mov	x2, x20
	bl	__list_add_valid
	tbz	w0, #0, .LBB11_22
// %bb.15:                              //   in Loop: Header=BB11_19 Depth=1
	ldr	x8, [sp, #8]            // 8-byte Folded Reload
	b	.LBB11_18
.LBB11_16:                              //   in Loop: Header=BB11_19 Depth=1
	ldr	x1, [sp]                // 8-byte Folded Reload
	mov	x0, x21
	ldr	x20, [x1]
	mov	x2, x20
	bl	__list_add_valid
	tbz	w0, #0, .LBB11_22
// %bb.17:                              //   in Loop: Header=BB11_19 Depth=1
	ldr	x8, [sp]                // 8-byte Folded Reload
.LBB11_18:                              //   in Loop: Header=BB11_19 Depth=1
	str	x21, [x20, #8]
	str	x20, [x25, #24]
	str	x8, [x25, #32]
	str	x21, [x8]
	b	.LBB11_22
.LBB11_19:                              // =>This Inner Loop Header: Depth=1
	add	x2, sp, #32             // =32
	mov	x0, x23
	mov	x1, x26
	bl	of_property_read_string
	cbz	w0, .LBB11_2
.LBB11_20:                              //   in Loop: Header=BB11_19 Depth=1
	ldr	x0, [x19, #5272]
	mov	x1, x28
	ldr	x2, [x23]
.LBB11_21:                              //   in Loop: Header=BB11_19 Depth=1
	bl	_dev_err
.LBB11_22:                              //   in Loop: Header=BB11_19 Depth=1
	mov	x0, x22
	mov	x1, x23
	bl	of_get_next_child
	mov	x23, x0
	cbnz	x0, .LBB11_19
.LBB11_23:
	adrp	x9, __stack_chk_guard
	ldr	x8, [sp, #56]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB11_26
// %bb.24:
	ldp	x29, x30, [sp, #144]    // 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]    // 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]    // 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]     // 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]     // 16-byte Folded Reload
	ldp	x28, x27, [sp, #64]     // 16-byte Folded Reload
	add	sp, sp, #160            // =160
	ret
.LBB11_25:
	ldr	x0, [x19, #5272]
	adrp	x1, .L.str.25
	adrp	x2, .L__func__.mas_ufs_populate_mgc_dt
	add	x1, x1, :lo12:.L.str.25
	add	x2, x2, :lo12:.L__func__.mas_ufs_populate_mgc_dt
	mov	w3, #592
	bl	_dev_err
	b	.LBB11_23
.LBB11_26:
	bl	__stack_chk_fail
.Lfunc_end11:
	.size	mas_ufs_populate_mgc_dt, .Lfunc_end11-mas_ufs_populate_mgc_dt
                                        // -- End function
	.globl	ufshcd_mas_mq_init      // -- Begin function ufshcd_mas_mq_init
	.p2align	3
	.type	ufshcd_mas_mq_init,@function
ufshcd_mas_mq_init:                     // @ufshcd_mas_mq_init
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldrh	w8, [x19, #2400]
	mov	w10, #191
	ldr	x9, [x19, #2376]
	mov	x11, #1
	movk	x11, #192, lsl #32
	mov	x12, #274877907008
	orr	w8, w8, #0x800
	orr	x9, x9, x10
	str	x11, [x19, #2360]
	orr	w10, wzr, #0xc0
	str	x12, [x19, #2368]
	strh	w8, [x19, #2400]
	str	x9, [x19, #2376]
	str	w10, [x19, #2332]
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end12:
	.size	ufshcd_mas_mq_init, .Lfunc_end12-ufshcd_mas_mq_init
                                        // -- End function
	.type	sync_cache_buffer,@object // @sync_cache_buffer
	.local	sync_cache_buffer
	.comm	sync_cache_buffer,8,8
	.type	.L.str,@object          // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"begin"
	.size	.L.str, 6

	.type	.L.str.1,@object        // @.str.1
.L.str.1:
	.asciz	"wait doorbell clean timeout\n"
	.size	.L.str.1, 29

	.type	.L.str.2,@object        // @.str.2
.L.str.2:
	.asciz	"end"
	.size	.L.str.2, 4

	.type	.L.str.3,@object        // @.str.3
.L.str.3:
	.asciz	"\0013%s %d++\n"
	.size	.L.str.3, 11

	.type	.L__func__.ufshcd_direct_flush_test,@object // @__func__.ufshcd_direct_flush_test
.L__func__.ufshcd_direct_flush_test:
	.asciz	"ufshcd_direct_flush_test"
	.size	.L__func__.ufshcd_direct_flush_test, 25

	.type	.L.str.4,@object        // @.str.4
.L.str.4:
	.asciz	"\0013%s %d--\n"
	.size	.L.str.4, 11

	.type	.L.str.5,@object        // @.str.5
.L.str.5:
	.asciz	"\0013%s, sdev is null!\n"
	.size	.L.str.5, 21

	.type	.L__func__.ufshcd_direct_flush,@object // @__func__.ufshcd_direct_flush
.L__func__.ufshcd_direct_flush:
	.asciz	"ufshcd_direct_flush"
	.size	.L__func__.ufshcd_direct_flush, 20

	.type	.L.str.6,@object        // @.str.6
.L.str.6:
	.asciz	"\0013%s, hba is null!\n"
	.size	.L.str.6, 20

	.type	.L.str.7,@object        // @.str.7
.L.str.7:
	.asciz	"%s sys has suspended!\n"
	.size	.L.str.7, 23

	.type	.L.str.8,@object        // @.str.8
.L.str.8:
	.asciz	"%s, can't get the hostlock!\n"
	.size	.L.str.8, 29

	.type	.L.str.9,@object        // @.str.9
.L.str.9:
	.asciz	"%s, scsi_device_get error or device not online, %d\n"
	.size	.L.str.9, 52

	.type	.L.str.10,@object       // @.str.10
.L.str.10:
	.asciz	"%s, ufshcd_state = %d\n"
	.size	.L.str.10, 23

	.type	.L.str.11,@object       // @.str.11
.L.str.11:
	.asciz	"ufshcd: lrb_in_use = 0x%lx\n"
	.size	.L.str.11, 28

	.type	.L.str.12,@object       // @.str.12
.L.str.12:
	.asciz	"UPIU[%d] - issue time %lld - complete time %lld\n"
	.size	.L.str.12, 49

	.type	.Lufshcd_send_scsi_request_sense.cmd,@object // @ufshcd_send_scsi_request_sense.cmd
	.section	.rodata,"a",@progbits
.Lufshcd_send_scsi_request_sense.cmd:
	.asciz	"\003\000\000\000`"
	.size	.Lufshcd_send_scsi_request_sense.cmd, 6

	.type	.L.str.13,@object       // @.str.13
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.13:
	.asciz	"%s: failed with err %d\n"
	.size	.L.str.13, 24

	.type	.L__func__.ufshcd_send_scsi_request_sense,@object // @__func__.ufshcd_send_scsi_request_sense
.L__func__.ufshcd_send_scsi_request_sense:
	.asciz	"ufshcd_send_scsi_request_sense"
	.size	.L__func__.ufshcd_send_scsi_request_sense, 31

	.type	.L__func__.ufshcd_send_scsi_ssu,@object // @__func__.ufshcd_send_scsi_ssu
.L__func__.ufshcd_send_scsi_ssu:
	.asciz	"ufshcd_send_scsi_ssu"
	.size	.L__func__.ufshcd_send_scsi_ssu, 21

	.type	.L.str.14,@object       // @.str.14
.L.str.14:
	.asciz	"%s: failed for lun %llu, ret = %d\n"
	.size	.L.str.14, 35

	.type	.L__func__.ufshcd_send_scsi_sync_cache,@object // @__func__.ufshcd_send_scsi_sync_cache
.L__func__.ufshcd_send_scsi_sync_cache:
	.asciz	"ufshcd_send_scsi_sync_cache"
	.size	.L__func__.ufshcd_send_scsi_sync_cache, 28

	.type	.L.str.15,@object       // @.str.15
.L.str.15:
	.asciz	"compatible"
	.size	.L.str.15, 11

	.type	.L.str.16,@object       // @.str.16
.L.str.16:
	.asciz	"check the compatible %s\n"
	.size	.L.str.16, 25

	.type	.L.str.17,@object       // @.str.17
.L.str.17:
	.asciz	"white"
	.size	.L.str.17, 6

	.type	.L.str.18,@object       // @.str.18
.L.str.18:
	.asciz	"black"
	.size	.L.str.18, 6

	.type	.L.str.19,@object       // @.str.19
.L.str.19:
	.asciz	"manufacturer_id"
	.size	.L.str.19, 16

	.type	.L.str.20,@object       // @.str.20
.L.str.20:
	.asciz	"check the manufacturer_id %s\n"
	.size	.L.str.20, 30

	.type	.L.str.21,@object       // @.str.21
.L.str.21:
	.asciz	"model"
	.size	.L.str.21, 6

	.type	.L.str.22,@object       // @.str.22
.L.str.22:
	.asciz	"check the model %s\n"
	.size	.L.str.22, 20

	.type	.L.str.23,@object       // @.str.23
.L.str.23:
	.asciz	"rev"
	.size	.L.str.23, 4

	.type	.L.str.24,@object       // @.str.24
.L.str.24:
	.asciz	"check the rev %s\n"
	.size	.L.str.24, 18

	.type	.L.str.25,@object       // @.str.25
.L.str.25:
	.asciz	"%s %d Failed to alloc bkops_id\n"
	.size	.L.str.25, 32

	.type	.L__func__.mas_ufs_populate_mgc_dt,@object // @__func__.mas_ufs_populate_mgc_dt
.L__func__.mas_ufs_populate_mgc_dt:
	.asciz	"mas_ufs_populate_mgc_dt"
	.size	.L__func__.mas_ufs_populate_mgc_dt, 24

	.type	.L.str.26,@object       // @.str.26
.L.str.26:
	.asciz	"wait door bell clean %s:tm_doorbell:0x%x, tr_doorbell:0x%x\n"
	.size	.L.str.26, 60

	.type	.L.str.28,@object       // @.str.28
.L.str.28:
	.asciz	"UFS:<%s> Emergency sync cache lun=%llu ret = %d\n"
	.size	.L.str.28, 49

	.type	.L__func__.ufshcd_send_scsi_sync_cache_on_specified_disk,@object // @__func__.ufshcd_send_scsi_sync_cache_on_specified_disk
.L__func__.ufshcd_send_scsi_sync_cache_on_specified_disk:
	.asciz	"ufshcd_send_scsi_sync_cache_on_specified_disk"
	.size	.L__func__.ufshcd_send_scsi_sync_cache_on_specified_disk, 46

	.type	.L.str.29,@object       // @.str.29
.L.str.29:
	.asciz	"wait doorbell clear timeout\n"
	.size	.L.str.29, 29


	.ident	"Snapdragon LLVM ARM Compiler 8.0.12 for Android NDK (based on llvm.org 7.0+)"
	.section	".note.GNU-stack","",@progbits
