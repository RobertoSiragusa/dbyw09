	.text
	.file	"mas_blk_dump.c"
	.globl	mas_blk_dump_request    // -- Begin function mas_blk_dump_request
	.p2align	3
	.type	mas_blk_dump_request,@function
mas_blk_dump_request:                   // @mas_blk_dump_request
// %bb.0:
	stp	x28, x27, [sp, #-96]!   // 16-byte Folded Spill
	stp	x26, x25, [sp, #16]     // 16-byte Folded Spill
	stp	x24, x23, [sp, #32]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #48]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #64]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #80]     // 16-byte Folded Spill
	add	x29, sp, #80            // =80
	sub	sp, sp, #560            // =560
	adrp	x8, __stack_chk_guard
	sub	x22, x29, #96           // =96
	mov	w19, w1
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	mov	x20, x0
	str	x8, [x22]
	bl	_mcount
	ldr	w1, [x20, #20]
	add	x2, sp, #20             // =20
	and	x0, x1, #0xff
                                        // kill: def $w1 killed $w1 killed $x1
	bl	mas_blk_io_type
	ldr	w8, [x20, #20]
	adrp	x9, .L.str.18
	adrp	x10, .L.str.17
	ldr	w7, [x20, #252]
	add	x9, x9, :lo12:.L.str.18
	add	x10, x10, :lo12:.L.str.17
	cmp	w19, #1                 // =1
	and	w8, w8, #0xfe
	csel	x19, x10, x9, eq
	adrp	x9, .L.str.21
	orr	w8, w8, #0x1
	adrp	x10, .L.str.20
	add	x9, x9, :lo12:.L.str.21
	add	x10, x10, :lo12:.L.str.20
	adrp	x11, .L.str.19
	cmp	w8, #35                 // =35
	add	x11, x11, :lo12:.L.str.19
	csel	x9, x10, x9, eq
	cmp	w8, #33                 // =33
	ldp	w5, w8, [x20, #40]
	adrp	x2, .L.str
	mov	x4, x0
	csel	x6, x11, x9, eq
	add	x2, x2, :lo12:.L.str
	str	w8, [sp]
	add	x0, sp, #32             // =32
	orr	w1, wzr, #0x200
	mov	x3, x20
	orr	w24, wzr, #0x200
	add	x25, sp, #32            // =32
	bl	snprintf
	ldr	x8, [x20, #240]
	mov	w9, w0
	adrp	x2, .L.str.1
	mov	w21, w0
	add	x0, x25, x9
	sub	x1, x24, x9
	and	x3, x8, #0x1
	and	x4, x8, #0x2
	add	x2, x2, :lo12:.L.str.1
	bl	snprintf
	ldr	x5, [x20, #208]
	add	w23, w0, w21
	add	x0, x25, x23
	sub	x1, x24, x23
	cbz	x5, .LBB0_2
// %bb.1:
	ldr	w3, [x20, #216]
	adrp	x2, .L.str.2
	add	x4, x20, #224           // =224
	add	x2, x2, :lo12:.L.str.2
	bl	snprintf
	b	.LBB0_3
.LBB0_2:
	adrp	x2, .L.str.3
	add	x2, x2, :lo12:.L.str.3
	bl	snprintf
.LBB0_3:
	add	x24, x20, #272          // =272
	adrp	x27, req_stage_cfg
	adrp	x20, .L.str.4
	mov	x21, xzr
	add	w23, w0, w23
	add	x25, sp, #32            // =32
	orr	w26, wzr, #0x200
	add	x27, x27, :lo12:req_stage_cfg
	add	x20, x20, :lo12:.L.str.4
.LBB0_4:                                // =>This Inner Loop Header: Depth=1
	ldr	x4, [x24]
	cbz	x4, .LBB0_6
// %bb.5:                               //   in Loop: Header=BB0_4 Depth=1
	mov	w8, w23
	ldr	x3, [x27]
	add	x0, x25, x8
	sub	x1, x26, x8
	mov	x2, x20
	bl	snprintf
	add	w23, w0, w23
.LBB0_6:                                //   in Loop: Header=BB0_4 Depth=1
	add	x21, x21, #1            // =1
	add	x24, x24, #8            // =8
	add	x27, x27, #16           // =16
	cmp	x21, #15                // =15
	b.ne	.LBB0_4
// %bb.7:
	adrp	x0, .L.str.5
	strb	wzr, [sp, #543]
	add	x0, x0, :lo12:.L.str.5
	add	x2, sp, #32             // =32
	mov	x1, x19
	bl	printk
	adrp	x9, __stack_chk_guard
	ldr	x8, [x22]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB0_9
// %bb.8:
	add	sp, sp, #560            // =560
	ldp	x29, x30, [sp, #80]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]     // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]     // 16-byte Folded Reload
	ldp	x28, x27, [sp], #96     // 16-byte Folded Reload
	ret
.LBB0_9:
	bl	__stack_chk_fail
.Lfunc_end0:
	.size	mas_blk_dump_request, .Lfunc_end0-mas_blk_dump_request
                                        // -- End function
	.globl	mas_blk_dump_bio        // -- Begin function mas_blk_dump_bio
	.p2align	3
	.type	mas_blk_dump_bio,@function
mas_blk_dump_bio:                       // @mas_blk_dump_bio
// %bb.0:
	stp	x28, x25, [sp, #-80]!   // 16-byte Folded Spill
	stp	x24, x23, [sp, #16]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #32]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #48]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #64]     // 16-byte Folded Spill
	add	x29, sp, #64            // =64
	sub	sp, sp, #544            // =544
	adrp	x8, __stack_chk_guard
	sub	x23, x29, #72           // =72
	mov	w19, w1
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	mov	x20, x0
	str	x8, [x23]
	bl	_mcount
	ldr	w1, [x20, #16]
	add	x2, sp, #12             // =12
	and	x0, x1, #0xff
                                        // kill: def $w1 killed $w1 killed $x1
	bl	mas_blk_io_type
	ldr	w5, [x20, #48]
	adrp	x2, .L.str.6
	mov	x4, x0
	add	x2, x2, :lo12:.L.str.6
	add	x0, sp, #24             // =24
	orr	w1, wzr, #0x200
	mov	x3, x20
	adrp	x8, .L.str.18
	adrp	x9, .L.str.17
	add	x8, x8, :lo12:.L.str.18
	add	x9, x9, :lo12:.L.str.17
	cmp	w19, #1                 // =1
	csel	x21, x9, x8, eq
	add	x24, sp, #24            // =24
	bl	snprintf
	ldr	x8, [x20, #120]
	mov	w22, w0
	cbz	x8, .LBB1_2
// %bb.1:
	orr	w25, wzr, #0x200
	ldr	w3, [x20, #128]
	adrp	x2, .L.str.7
	sxtw	x8, w22
	add	x0, x24, x8
	sub	x1, x25, x8
	add	x4, x20, #136           // =136
	add	x2, x2, :lo12:.L.str.7
	bl	snprintf
	ldr	x3, [x20, #120]
	add	w22, w0, w22
	adrp	x2, .L.str.8
	sxtw	x8, w22
	add	x0, x24, x8
	sub	x1, x25, x8
	add	x2, x2, :lo12:.L.str.8
	bl	snprintf
	add	w22, w0, w22
.LBB1_2:
	orr	w9, wzr, #0x200
	adrp	x2, .L.str.3
	sxtw	x8, w22
	add	x0, x24, x8
	sub	x1, x9, x8
	add	x2, x2, :lo12:.L.str.3
	bl	snprintf
	ldr	x4, [x20, #160]
	add	w22, w0, w22
	cbnz	x4, .LBB1_11
// %bb.3:
	ldr	x4, [x20, #168]
	cbnz	x4, .LBB1_12
.LBB1_4:
	ldr	x4, [x20, #176]
	cbnz	x4, .LBB1_13
.LBB1_5:
	ldr	x4, [x20, #184]
	cbz	x4, .LBB1_7
.LBB1_6:
	add	x9, sp, #24             // =24
	sxtw	x8, w22
	add	x0, x9, x8
	adrp	x9, bio_stage_cfg
	add	x9, x9, :lo12:bio_stage_cfg
	orr	w10, wzr, #0x200
	adrp	x2, .L.str.9
	ldr	x3, [x9, #48]
	sub	x1, x10, x8
	add	x2, x2, :lo12:.L.str.9
	bl	snprintf
	add	w22, w0, w22
.LBB1_7:
	add	x8, sp, #24             // =24
	strb	wzr, [x8, w22, sxtw]
	bl	ktime_get
	mov	x3, x0
	adrp	x0, .L.str.10
	add	x0, x0, :lo12:.L.str.10
	add	x2, sp, #24             // =24
	mov	x1, x21
	bl	printk
	ldr	x0, [x20, #112]
	cbz	x0, .LBB1_9
// %bb.8:
	mov	w1, w19
	bl	mas_blk_dump_request
.LBB1_9:
	adrp	x9, __stack_chk_guard
	ldr	x8, [x23]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB1_14
// %bb.10:
	add	sp, sp, #544            // =544
	ldp	x29, x30, [sp, #64]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]     // 16-byte Folded Reload
	ldp	x28, x25, [sp], #80     // 16-byte Folded Reload
	ret
.LBB1_11:
	adrp	x9, bio_stage_cfg
	add	x10, sp, #24            // =24
	sxtw	x8, w22
	add	x0, x10, x8
	ldr	x3, [x9, :lo12:bio_stage_cfg]
	orr	w10, wzr, #0x200
	adrp	x2, .L.str.9
	sub	x1, x10, x8
	add	x2, x2, :lo12:.L.str.9
	bl	snprintf
	add	w22, w0, w22
	ldr	x4, [x20, #168]
	cbz	x4, .LBB1_4
.LBB1_12:
	add	x9, sp, #24             // =24
	sxtw	x8, w22
	add	x0, x9, x8
	adrp	x9, bio_stage_cfg
	add	x9, x9, :lo12:bio_stage_cfg
	orr	w10, wzr, #0x200
	adrp	x2, .L.str.9
	ldr	x3, [x9, #16]
	sub	x1, x10, x8
	add	x2, x2, :lo12:.L.str.9
	bl	snprintf
	add	w22, w0, w22
	ldr	x4, [x20, #176]
	cbz	x4, .LBB1_5
.LBB1_13:
	add	x9, sp, #24             // =24
	sxtw	x8, w22
	add	x0, x9, x8
	adrp	x9, bio_stage_cfg
	add	x9, x9, :lo12:bio_stage_cfg
	orr	w10, wzr, #0x200
	adrp	x2, .L.str.9
	ldr	x3, [x9, #32]
	sub	x1, x10, x8
	add	x2, x2, :lo12:.L.str.9
	bl	snprintf
	add	w22, w0, w22
	ldr	x4, [x20, #184]
	cbnz	x4, .LBB1_6
	b	.LBB1_7
.LBB1_14:
	bl	__stack_chk_fail
.Lfunc_end1:
	.size	mas_blk_dump_bio, .Lfunc_end1-mas_blk_dump_bio
                                        // -- End function
	.p2align	3               // -- Begin function mas_blk_io_type
	.type	mas_blk_io_type,@function
mas_blk_io_type:                        // @mas_blk_io_type
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x2
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	w20, w1
	mov	x21, x0
	bl	_mcount
	cmp	x21, #7                 // =7
	b.hi	.LBB2_35
// %bb.1:
	adrp	x8, .LJTI2_0
	add	x8, x8, :lo12:.LJTI2_0
	adr	x9, .LBB2_2
	ldrb	w10, [x8, x21]
	add	x9, x9, x10, lsl #2
	br	x9
.LBB2_2:
	mov	w8, #82
	b	.LBB2_8
.LBB2_3:
	mov	w8, #87
	b	.LBB2_8
.LBB2_4:
	mov	w8, #70
	b	.LBB2_8
.LBB2_5:
	mov	w8, #68
	b	.LBB2_8
.LBB2_6:
	mov	w8, #69
	b	.LBB2_8
.LBB2_7:
	mov	w8, #84
.LBB2_8:
	orr	w9, wzr, #0x1
	strb	w8, [x19]
.LBB2_9:
	mov	w8, w20
	add	x10, x19, x9
	tbnz	w8, #17, .LBB2_11
// %bb.10:
	mov	w11, wzr
	mov	w12, #10
	tbnz	w8, #11, .LBB2_12
	b	.LBB2_13
.LBB2_11:
	mov	w12, #65
	orr	w11, wzr, #0x1
	strb	w12, [x10]
	mov	w12, #10
	tbz	w8, #11, .LBB2_13
.LBB2_12:
	mov	w13, #83
	strb	w13, [x10, w11, uxtw]
	add	w11, w11, #1            // =1
.LBB2_13:
	sub	w13, w12, w9
	tbz	w8, #12, .LBB2_16
// %bb.14:
	cmp	w11, w13
	b.ge	.LBB2_16
// %bb.15:
	mov	w14, #77
	strb	w14, [x10, w11, uxtw]
	add	w11, w11, #1            // =1
.LBB2_16:
	tbz	w8, #18, .LBB2_19
// %bb.17:
	cmp	w11, w13
	b.ge	.LBB2_19
// %bb.18:
	mov	w13, #70
	strb	w13, [x10, w11, uxtw]
	add	w11, w11, #1            // =1
.LBB2_19:
	add	w9, w11, w9
	mov	w10, wzr
	add	x11, x19, x9
	sub	w12, w12, w9
	tbz	w8, #21, .LBB2_22
// %bb.20:
	cmp	w12, #1                 // =1
	b.lt	.LBB2_22
// %bb.21:
	mov	w13, #72
	orr	w10, wzr, #0x1
	strb	w13, [x11]
.LBB2_22:
	tbz	w8, #23, .LBB2_25
// %bb.23:
	cmp	w10, w12
	b.ge	.LBB2_25
// %bb.24:
	mov	w13, #67
	strb	w13, [x11, w10, uxtw]
	add	w10, w10, #1            // =1
.LBB2_25:
	tbz	w8, #25, .LBB2_28
// %bb.26:
	cmp	w10, w12
	b.ge	.LBB2_28
// %bb.27:
	mov	w13, #90
	strb	w13, [x11, w10, uxtw]
	add	w10, w10, #1            // =1
.LBB2_28:
	tbz	w8, #24, .LBB2_31
// %bb.29:
	cmp	w10, w12
	b.ge	.LBB2_31
// %bb.30:
	mov	w13, #86
	strb	w13, [x11, w10, uxtw]
	add	w10, w10, #1            // =1
.LBB2_31:
	tbz	w8, #28, .LBB2_34
// %bb.32:
	cmp	w10, w12
	b.ge	.LBB2_34
// %bb.33:
	mov	w8, #84
	strb	w8, [x11, w10, uxtw]
	add	w10, w10, #1            // =1
.LBB2_34:
	add	w8, w10, w9
	mov	x0, x19
	strb	wzr, [x19, w8, uxtw]
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.LBB2_35:
	adrp	x0, .L.str.22
	adrp	x1, .L__func__.mas_blk_io_type_op
	add	x0, x0, :lo12:.L.str.22
	add	x1, x1, :lo12:.L__func__.mas_blk_io_type_op
	bl	printk
	mov	w9, wzr
	b	.LBB2_9
.Lfunc_end2:
	.size	mas_blk_io_type, .Lfunc_end2-mas_blk_io_type
	.section	.rodata,"a",@progbits
.LJTI2_0:
	.byte	(.LBB2_2-.LBB2_2)>>2
	.byte	(.LBB2_3-.LBB2_2)>>2
	.byte	(.LBB2_4-.LBB2_2)>>2
	.byte	(.LBB2_5-.LBB2_2)>>2
	.byte	(.LBB2_35-.LBB2_2)>>2
	.byte	(.LBB2_6-.LBB2_2)>>2
	.byte	(.LBB2_35-.LBB2_2)>>2
	.byte	(.LBB2_7-.LBB2_2)>>2
                                        // -- End function
	.text
	.globl	mas_blk_dump_queue_status2 // -- Begin function mas_blk_dump_queue_status2
	.p2align	3
	.type	mas_blk_dump_queue_status2,@function
mas_blk_dump_queue_status2:             // @mas_blk_dump_queue_status2
// %bb.0:
	str	x28, [sp, #-80]!        // 8-byte Folded Spill
	stp	x24, x23, [sp, #16]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #32]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #48]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #64]     // 16-byte Folded Spill
	add	x29, sp, #64            // =64
	sub	sp, sp, #528            // =528
	adrp	x8, __stack_chk_guard
	mov	w22, w2
	mov	x19, x1
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	mov	x21, x0
	stur	x8, [x29, #-72]
	bl	_mcount
	adrp	x8, .L.str.23
	add	x8, x8, :lo12:.L.str.23
	ldur	x9, [x8, #7]
	ldr	x8, [x8]
	stur	x9, [sp, #15]
	str	x8, [sp, #8]
	cbz	x19, .LBB3_16
// %bb.1:
	cmp	w22, #1                 // =1
	b.lt	.LBB3_16
// %bb.2:
	adrp	x2, .L.str.24
	add	x2, x2, :lo12:.L.str.24
	add	x3, sp, #8              // =8
	mov	x0, x19
	sxtw	x1, w22
	bl	snprintf
	mov	w20, w0
.LBB3_3:
	ldr	w8, [x21, #2140]
	sub	w24, w22, w20
	cbz	w8, .LBB3_5
// %bb.4:
	ldr	w3, [x21, #2144]
	adrp	x2, .L.str.26
	add	x2, x2, :lo12:.L.str.26
	add	x0, sp, #8              // =8
	orr	w1, wzr, #0x200
	bl	snprintf
	b	.LBB3_6
.LBB3_5:
	adrp	x8, .L.str.27
	add	x8, x8, :lo12:.L.str.27
	ldur	x9, [x8, #22]
	ldp	x11, x10, [x8, #8]
	ldr	x8, [x8]
	stur	x9, [sp, #30]
	stp	x11, x10, [sp, #16]
	str	x8, [sp, #8]
.LBB3_6:
	add	x23, x19, w20, sxtw
	cmp	w24, #1                 // =1
	b.lt	.LBB3_17
// %bb.7:
	cbz	x23, .LBB3_17
// %bb.8:
	adrp	x2, .L.str.24
	add	x2, x2, :lo12:.L.str.24
	add	x3, sp, #8              // =8
	mov	x0, x23
	sxtw	x1, w24
	bl	snprintf
	mov	w22, w0
.LBB3_9:
	ldr	w8, [x21, #2136]
	adrp	x9, .L.str.29
	adrp	x10, .L.str.30
	add	x9, x9, :lo12:.L.str.29
	add	x10, x10, :lo12:.L.str.30
	cmp	w8, #0                  // =0
	adrp	x2, .L.str.28
	csel	x3, x10, x9, eq
	add	x2, x2, :lo12:.L.str.28
	add	x0, sp, #8              // =8
	orr	w1, wzr, #0x200
	bl	snprintf
	sub	w8, w24, w22
	cmp	w8, #1                  // =1
	b.lt	.LBB3_18
// %bb.10:
	add	x0, x23, w22, sxtw
	cbz	x0, .LBB3_18
// %bb.11:
	adrp	x2, .L.str.24
	add	x2, x2, :lo12:.L.str.24
	add	x3, sp, #8              // =8
	sxtw	x1, w8
	bl	snprintf
.LBB3_12:
	add	w8, w22, w20
	add	w0, w8, w0
	cbz	x19, .LBB3_14
// %bb.13:
	strb	wzr, [x19, w0, sxtw]
.LBB3_14:
	adrp	x9, __stack_chk_guard
	ldur	x8, [x29, #-72]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB3_19
// %bb.15:
	add	sp, sp, #528            // =528
	ldp	x29, x30, [sp, #64]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]     // 16-byte Folded Reload
	ldr	x28, [sp], #80          // 8-byte Folded Reload
	ret
.LBB3_16:
	adrp	x0, .L.str.25
	add	x0, x0, :lo12:.L.str.25
	add	x1, sp, #8              // =8
	bl	printk
	mov	w20, wzr
	b	.LBB3_3
.LBB3_17:
	adrp	x0, .L.str.25
	add	x0, x0, :lo12:.L.str.25
	add	x1, sp, #8              // =8
	bl	printk
	mov	w22, wzr
	b	.LBB3_9
.LBB3_18:
	adrp	x0, .L.str.25
	add	x0, x0, :lo12:.L.str.25
	add	x1, sp, #8              // =8
	bl	printk
	mov	w0, wzr
	b	.LBB3_12
.LBB3_19:
	bl	__stack_chk_fail
.Lfunc_end3:
	.size	mas_blk_dump_queue_status2, .Lfunc_end3-mas_blk_dump_queue_status2
                                        // -- End function
	.globl	mas_blk_dump_queue_status // -- Begin function mas_blk_dump_queue_status
	.p2align	3
	.type	mas_blk_dump_queue_status,@function
mas_blk_dump_queue_status:              // @mas_blk_dump_queue_status
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	w19, w1
	mov	x20, x0
	bl	_mcount
	ldr	x8, [x20, #1872]
	cbnz	x8, .LBB4_2
.LBB4_1:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.LBB4_2:
	adrp	x9, .L.str.18
	ldr	w4, [x8, #1520]
	adrp	x10, .L.str.17
	ldr	w5, [x8, #1524]
	add	x9, x9, :lo12:.L.str.18
	add	x10, x10, :lo12:.L.str.17
	cmp	w19, #1                 // =1
	csel	x1, x10, x9, eq
	ldrb	w9, [x20, #1880]
	add	x2, x8, #12             // =12
	adrp	x8, .L.str.12
	adrp	x10, .L.str.13
	add	x8, x8, :lo12:.L.str.12
	add	x10, x10, :lo12:.L.str.13
	cmp	w9, #0                  // =0
	adrp	x0, .L.str.11
	csel	x3, x10, x8, eq
	add	x0, x0, :lo12:.L.str.11
	bl	printk
	adrp	x0, .L.str.14
	add	x0, x0, :lo12:.L.str.14
	mov	x1, x20
	bl	printk
	cmp	w19, #1                 // =1
	b.ne	.LBB4_4
// %bb.3:
	mov	x0, x20
	mov	x1, xzr
	mov	w2, wzr
	bl	mas_blk_dump_queue_status2
.LBB4_4:
	ldr	x8, [x20, #2304]
	cbz	x8, .LBB4_1
// %bb.5:
	ldr	x8, [x8, #160]
	cbz	x8, .LBB4_1
// %bb.6:
	mov	x0, x20
	mov	w1, w19
	blr	x8
	b	.LBB4_1
.Lfunc_end4:
	.size	mas_blk_dump_queue_status, .Lfunc_end4-mas_blk_dump_queue_status
                                        // -- End function
	.globl	mas_blk_dump_lld_status // -- Begin function mas_blk_dump_lld_status
	.p2align	3
	.type	mas_blk_dump_lld_status,@function
mas_blk_dump_lld_status:                // @mas_blk_dump_lld_status
// %bb.0:
	stp	x28, x27, [sp, #-96]!   // 16-byte Folded Spill
	stp	x26, x25, [sp, #16]     // 16-byte Folded Spill
	stp	x24, x23, [sp, #32]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #48]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #64]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #80]     // 16-byte Folded Spill
	add	x29, sp, #80            // =80
	sub	sp, sp, #528            // =528
	adrp	x8, __stack_chk_guard
	mov	w21, w2
	mov	x19, x1
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	mov	x20, x0
	stur	x8, [x29, #-96]
	bl	_mcount
	adrp	x8, .L.str.31
	add	x8, x8, :lo12:.L.str.31
	ldur	x9, [x8, #5]
	ldr	x8, [x8]
	stur	x9, [sp, #5]
	str	x8, [sp]
	cbz	x19, .LBB5_30
// %bb.1:
	cmp	w21, #1                 // =1
	b.lt	.LBB5_30
// %bb.2:
	adrp	x2, .L.str.24
	add	x2, x2, :lo12:.L.str.24
	mov	x3, sp
	mov	x0, x19
	sxtw	x1, w21
	bl	snprintf
	mov	w22, w0
.LBB5_3:
	ldr	x8, [x20, #24]
	adrp	x24, .L.str.29
	adrp	x25, .L.str.30
	add	x24, x24, :lo12:.L.str.29
	add	x25, x25, :lo12:.L.str.30
	tst	x8, #0x1
	adrp	x2, .L.str.32
	csel	x3, x25, x24, eq
	add	x2, x2, :lo12:.L.str.32
	mov	x0, sp
	orr	w1, wzr, #0x200
	bl	snprintf
	sub	w8, w21, w22
	cmp	w8, #1                  // =1
	b.lt	.LBB5_31
// %bb.4:
	add	x0, x19, w22, sxtw
	cbz	x0, .LBB5_31
// %bb.5:
	adrp	x2, .L.str.24
	add	x2, x2, :lo12:.L.str.24
	mov	x3, sp
	sxtw	x1, w8
	bl	snprintf
.LBB5_6:
	ldrb	w8, [x20, #24]
	add	w22, w0, w22
	sub	w23, w21, w22
	tbnz	w8, #1, .LBB5_16
// %bb.7:
	adrp	x8, .L.str.34
	strb	wzr, [sp, #26]
	add	x8, x8, :lo12:.L.str.34
	mov	w10, #2661
	ldr	x11, [x8]
	ldp	x8, x9, [x8, #8]
	strh	w10, [sp, #24]
	str	x11, [sp]
	stp	x8, x9, [sp, #8]
	cmp	w23, #1                 // =1
	b.lt	.LBB5_17
.LBB5_8:
	add	x0, x19, w22, sxtw
	cbz	x0, .LBB5_17
// %bb.9:
	adrp	x2, .L.str.24
	add	x2, x2, :lo12:.L.str.24
	mov	x3, sp
	sxtw	x1, w23
	bl	snprintf
.LBB5_10:
	ldr	x8, [x20, #24]
	adrp	x2, .L.str.35
	add	w26, w0, w22
	add	x2, x2, :lo12:.L.str.35
	mov	x0, sp
	tst	x8, #0x8
	csel	x3, x25, x24, eq
	orr	w1, wzr, #0x200
	add	x22, x19, w26, sxtw
	sub	w27, w21, w26
	bl	snprintf
	cmp	w27, #1                 // =1
	b.lt	.LBB5_32
// %bb.11:
	cbz	x22, .LBB5_32
// %bb.12:
	adrp	x2, .L.str.24
	add	x2, x2, :lo12:.L.str.24
	mov	x3, sp
	mov	x0, x22
	sxtw	x1, w27
	bl	snprintf
	mov	w23, w0
.LBB5_13:
	ldr	w8, [x20, #704]
	cmp	w8, #1                  // =1
	b.eq	.LBB5_18
// %bb.14:
	cbnz	w8, .LBB5_26
// %bb.15:
	adrp	x8, .L.str.36
	add	x8, x8, :lo12:.L.str.36
	b	.LBB5_19
.LBB5_16:
	ldr	w3, [x20, #48]
	adrp	x2, .L.str.33
	add	x2, x2, :lo12:.L.str.33
	mov	x0, sp
	orr	w1, wzr, #0x200
	bl	snprintf
	cmp	w23, #1                 // =1
	b.ge	.LBB5_8
.LBB5_17:
	adrp	x0, .L.str.25
	add	x0, x0, :lo12:.L.str.25
	mov	x1, sp
	bl	printk
	mov	w0, wzr
	b	.LBB5_10
.LBB5_18:
	adrp	x8, .L.str.37
	add	x8, x8, :lo12:.L.str.37
.LBB5_19:
	ldur	x9, [x8, #6]
	ldr	x8, [x8]
	stur	x9, [sp, #6]
	str	x8, [sp]
	sub	w8, w27, w23
	cmp	w8, #1                  // =1
	b.lt	.LBB5_59
// %bb.20:
	add	x0, x22, w23, sxtw
	cbz	x0, .LBB5_59
// %bb.21:
	adrp	x2, .L.str.24
	add	x2, x2, :lo12:.L.str.24
	mov	x3, sp
	sxtw	x1, w8
	bl	snprintf
.LBB5_22:
	ldr	w3, [x20, #512]
	adrp	x2, .L.str.38
	add	w23, w0, w23
	add	x2, x2, :lo12:.L.str.38
	mov	x0, sp
	orr	w1, wzr, #0x200
	bl	snprintf
	sub	w8, w27, w23
	cmp	w8, #1                  // =1
	b.lt	.LBB5_60
// %bb.23:
	add	x0, x22, w23, sxtw
	cbz	x0, .LBB5_60
// %bb.24:
	adrp	x2, .L.str.24
	add	x2, x2, :lo12:.L.str.24
	mov	x3, sp
	sxtw	x1, w8
	bl	snprintf
.LBB5_25:
	add	w23, w0, w23
.LBB5_26:
	adrp	x8, .L.str.39
	add	x8, x8, :lo12:.L.str.39
	add	w26, w23, w26
	sub	w27, w21, w26
	ldp	x8, x9, [x8]
	add	x23, x19, w26, sxtw
	cmp	w27, #1                 // =1
	stp	x8, x9, [sp]
	b.lt	.LBB5_33
// %bb.27:
	cbz	x23, .LBB5_33
// %bb.28:
	adrp	x2, .L.str.24
	add	x2, x2, :lo12:.L.str.24
	mov	x3, sp
	mov	x0, x23
	sxtw	x1, w27
	bl	snprintf
	mov	w22, w0
	ldrb	w8, [x20, #24]
	tbnz	w8, #5, .LBB5_34
.LBB5_29:
	adrp	x8, .L.str.41
	strb	wzr, [sp, #18]
	add	x8, x8, :lo12:.L.str.41
	mov	w9, #2674
	ldp	x8, x10, [x8]
	strh	w9, [sp, #16]
	str	x10, [sp, #8]
	b	.LBB5_35
.LBB5_30:
	adrp	x0, .L.str.25
	add	x0, x0, :lo12:.L.str.25
	mov	x1, sp
	bl	printk
	mov	w22, wzr
	b	.LBB5_3
.LBB5_31:
	adrp	x0, .L.str.25
	add	x0, x0, :lo12:.L.str.25
	mov	x1, sp
	bl	printk
	mov	w0, wzr
	b	.LBB5_6
.LBB5_32:
	adrp	x0, .L.str.25
	add	x0, x0, :lo12:.L.str.25
	mov	x1, sp
	bl	printk
	mov	w23, wzr
	b	.LBB5_13
.LBB5_33:
	adrp	x0, .L.str.25
	add	x0, x0, :lo12:.L.str.25
	mov	x1, sp
	bl	printk
	mov	w22, wzr
	ldrb	w8, [x20, #24]
	tbz	w8, #5, .LBB5_29
.LBB5_34:
	mov	x8, #16717
	movk	x8, #8275, lsl #16
	movk	x8, #20813, lsl #32
	movk	x8, #10, lsl #48
.LBB5_35:
	str	x8, [sp]
	sub	w8, w27, w22
	cmp	w8, #1                  // =1
	b.lt	.LBB5_54
// %bb.36:
	add	x0, x23, w22, sxtw
	cbz	x0, .LBB5_54
// %bb.37:
	adrp	x2, .L.str.24
	add	x2, x2, :lo12:.L.str.24
	mov	x3, sp
	sxtw	x1, w8
	bl	snprintf
.LBB5_38:
	ldr	x9, [x20, #24]
	add	w8, w22, w26
	adrp	x2, .L.str.28
	add	w23, w8, w0
	add	x2, x2, :lo12:.L.str.28
	tst	x9, #0x4
	csel	x3, x25, x24, eq
	mov	x0, sp
	orr	w1, wzr, #0x200
	add	x22, x19, w23, sxtw
	sub	w26, w21, w23
	bl	snprintf
	cmp	w26, #1                 // =1
	b.lt	.LBB5_55
// %bb.39:
	cbz	x22, .LBB5_55
// %bb.40:
	adrp	x2, .L.str.24
	add	x2, x2, :lo12:.L.str.24
	mov	x3, sp
	mov	x0, x22
	sxtw	x1, w26
	bl	snprintf
	mov	w21, w0
.LBB5_41:
	ldr	x8, [x20, #24]
	adrp	x2, .L.str.42
	add	x2, x2, :lo12:.L.str.42
	mov	x0, sp
	orr	w1, wzr, #0x200
	tst	x8, #0x10
	csel	x3, x25, x24, eq
	bl	snprintf
	sub	w8, w26, w21
	cmp	w8, #1                  // =1
	b.lt	.LBB5_56
// %bb.42:
	add	x0, x22, w21, sxtw
	cbz	x0, .LBB5_56
// %bb.43:
	adrp	x2, .L.str.24
	add	x2, x2, :lo12:.L.str.24
	mov	x3, sp
	sxtw	x1, w8
	bl	snprintf
.LBB5_44:
	ldrsb	w8, [x20, #24]
	adrp	x2, .L.str.43
	add	w21, w0, w21
	add	x2, x2, :lo12:.L.str.43
	mov	x0, sp
	cmp	w8, #0                  // =0
	csel	x3, x24, x25, lt
	orr	w1, wzr, #0x200
	bl	snprintf
	sub	w8, w26, w21
	cmp	w8, #1                  // =1
	b.lt	.LBB5_57
// %bb.45:
	add	x0, x22, w21, sxtw
	cbz	x0, .LBB5_57
// %bb.46:
	adrp	x2, .L.str.24
	add	x2, x2, :lo12:.L.str.24
	mov	x3, sp
	sxtw	x1, w8
	bl	snprintf
.LBB5_47:
	ldr	x8, [x20, #24]
	adrp	x2, .L.str.44
	add	w20, w0, w21
	add	x2, x2, :lo12:.L.str.44
	mov	x0, sp
	tst	x8, #0x100
	csel	x3, x25, x24, eq
	orr	w1, wzr, #0x200
	bl	snprintf
	sub	w8, w26, w20
	cmp	w8, #1                  // =1
	b.lt	.LBB5_58
// %bb.48:
	add	x0, x22, w20, sxtw
	cbz	x0, .LBB5_58
// %bb.49:
	adrp	x2, .L.str.24
	add	x2, x2, :lo12:.L.str.24
	mov	x3, sp
	sxtw	x1, w8
	bl	snprintf
.LBB5_50:
	add	w8, w20, w23
	add	w0, w8, w0
	cbz	x19, .LBB5_52
// %bb.51:
	strb	wzr, [x19, w0, sxtw]
.LBB5_52:
	adrp	x9, __stack_chk_guard
	ldur	x8, [x29, #-96]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB5_61
// %bb.53:
	add	sp, sp, #528            // =528
	ldp	x29, x30, [sp, #80]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]     // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]     // 16-byte Folded Reload
	ldp	x28, x27, [sp], #96     // 16-byte Folded Reload
	ret
.LBB5_54:
	adrp	x0, .L.str.25
	add	x0, x0, :lo12:.L.str.25
	mov	x1, sp
	bl	printk
	mov	w0, wzr
	b	.LBB5_38
.LBB5_55:
	adrp	x0, .L.str.25
	add	x0, x0, :lo12:.L.str.25
	mov	x1, sp
	bl	printk
	mov	w21, wzr
	b	.LBB5_41
.LBB5_56:
	adrp	x0, .L.str.25
	add	x0, x0, :lo12:.L.str.25
	mov	x1, sp
	bl	printk
	mov	w0, wzr
	b	.LBB5_44
.LBB5_57:
	adrp	x0, .L.str.25
	add	x0, x0, :lo12:.L.str.25
	mov	x1, sp
	bl	printk
	mov	w0, wzr
	b	.LBB5_47
.LBB5_58:
	adrp	x0, .L.str.25
	add	x0, x0, :lo12:.L.str.25
	mov	x1, sp
	bl	printk
	mov	w0, wzr
	b	.LBB5_50
.LBB5_59:
	adrp	x0, .L.str.25
	add	x0, x0, :lo12:.L.str.25
	mov	x1, sp
	bl	printk
	mov	w0, wzr
	b	.LBB5_22
.LBB5_60:
	adrp	x0, .L.str.25
	add	x0, x0, :lo12:.L.str.25
	mov	x1, sp
	bl	printk
	mov	w0, wzr
	b	.LBB5_25
.LBB5_61:
	bl	__stack_chk_fail
.Lfunc_end5:
	.size	mas_blk_dump_lld_status, .Lfunc_end5-mas_blk_dump_lld_status
                                        // -- End function
	.globl	mas_blk_panic_dump      // -- Begin function mas_blk_panic_dump
	.p2align	3
	.type	mas_blk_panic_dump,@function
mas_blk_panic_dump:                     // @mas_blk_panic_dump
// %bb.0:
	stp	x28, x27, [sp, #-96]!   // 16-byte Folded Spill
	stp	x26, x25, [sp, #16]     // 16-byte Folded Spill
	stp	x24, x23, [sp, #32]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #48]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #64]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #80]     // 16-byte Folded Spill
	add	x29, sp, #80            // =80
	bl	_mcount
	adrp	x27, dump_list
	add	x27, x27, :lo12:dump_list
	ldr	x28, [x27]
	cmp	x28, x27
	b.eq	.LBB6_22
// %bb.1:
	adrp	x21, .L.str.11
	adrp	x22, .L.str.17
	adrp	x23, .L.str.14
	adrp	x24, .L.str.45
	add	x21, x21, :lo12:.L.str.11
	add	x22, x22, :lo12:.L.str.17
	add	x23, x23, :lo12:.L.str.14
	add	x24, x24, :lo12:.L.str.45
	b	.LBB6_14
.LBB6_2:                                //   in Loop: Header=BB6_14 Depth=1
	mov	x0, x26
	mov	x1, xzr
	mov	w2, wzr
	bl	mas_blk_dump_lld_status
	ldr	x1, [x26, #1168]
	mov	x0, x24
	ldr	x2, [x26, #1176]
	bl	printk
	ldr	x8, [x26, #40]
	orr	w1, wzr, #0x1
	mov	x0, x25
	blr	x8
	str	xzr, [x26, #40]
	b	.LBB6_15
.LBB6_3:                                //   in Loop: Header=BB6_14 Depth=1
	sub	x9, x28, #272           // =272
	ldr	w4, [x8, #1520]
	ldr	w5, [x8, #1524]
	add	x2, x8, #12             // =12
	adrp	x8, .L.str.12
	ldrb	w9, [x9]
	add	x8, x8, :lo12:.L.str.12
	mov	x0, x21
	mov	x1, x22
	cmp	w9, #0                  // =0
	adrp	x9, .L.str.13
	add	x9, x9, :lo12:.L.str.13
	csel	x3, x9, x8, eq
	bl	printk
	mov	x0, x23
	mov	x1, x25
	bl	printk
	mov	x0, x25
	mov	x1, xzr
	mov	w2, wzr
	bl	mas_blk_dump_queue_status2
	ldr	x8, [x28, #152]
	cbz	x8, .LBB6_16
// %bb.4:                               //   in Loop: Header=BB6_14 Depth=1
	ldr	x8, [x8, #160]
	cbz	x8, .LBB6_16
// %bb.5:                               //   in Loop: Header=BB6_14 Depth=1
	orr	w1, wzr, #0x1
	mov	x0, x25
	blr	x8
	b	.LBB6_16
.LBB6_6:                                //   in Loop: Header=BB6_14 Depth=1
	adrp	x0, .L.str.46
	add	x0, x0, :lo12:.L.str.46
	bl	printk
	ldr	x20, [x19]
	cmp	x19, x20
	b.ne	.LBB6_8
	b	.LBB6_17
.LBB6_7:                                //   in Loop: Header=BB6_8 Depth=2
	ldr	x20, [x20]
	cmp	x19, x20
	b.eq	.LBB6_17
.LBB6_8:                                //   Parent Loop BB6_14 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	ldur	x8, [x20, #-248]
	cmp	x8, x25
	b.ne	.LBB6_7
// %bb.9:                               //   in Loop: Header=BB6_8 Depth=2
	sub	x0, x20, #352           // =352
	orr	w1, wzr, #0x1
	bl	mas_blk_dump_bio
	b	.LBB6_7
.LBB6_10:                               //   in Loop: Header=BB6_14 Depth=1
	adrp	x0, .L.str.47
	add	x0, x0, :lo12:.L.str.47
	bl	printk
	ldr	x19, [x26]
	cmp	x26, x19
	b.ne	.LBB6_12
	b	.LBB6_18
.LBB6_11:                               //   in Loop: Header=BB6_12 Depth=2
	ldr	x19, [x19]
	cmp	x26, x19
	b.eq	.LBB6_18
.LBB6_12:                               //   Parent Loop BB6_14 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
	sub	x0, x19, #440           // =440
	ldr	x8, [x0]
	cmp	x8, x25
	b.ne	.LBB6_11
// %bb.13:                              //   in Loop: Header=BB6_12 Depth=2
	orr	w1, wzr, #0x1
	bl	mas_blk_dump_request
	b	.LBB6_11
.LBB6_14:                               // =>This Loop Header: Depth=1
                                        //     Child Loop BB6_8 Depth 2
                                        //     Child Loop BB6_12 Depth 2
	sub	x25, x28, #2152         // =2152
	mov	x0, x25
	bl	mas_blk_get_lld
	ldr	x8, [x0, #40]
	mov	x26, x0
	cbnz	x8, .LBB6_2
.LBB6_15:                               //   in Loop: Header=BB6_14 Depth=1
	sub	x8, x28, #280           // =280
	ldr	x8, [x8]
	cbnz	x8, .LBB6_3
.LBB6_16:                               //   in Loop: Header=BB6_14 Depth=1
	ldr	x8, [x26, #1184]
	add	x19, x26, #1184         // =1184
	cmp	x19, x8
	b.ne	.LBB6_6
.LBB6_17:                               //   in Loop: Header=BB6_14 Depth=1
	ldr	x8, [x26, #1200]
	add	x26, x26, #1200         // =1200
	cmp	x26, x8
	b.ne	.LBB6_10
.LBB6_18:                               //   in Loop: Header=BB6_14 Depth=1
	ldr	x8, [x28, #152]
	cbz	x8, .LBB6_21
// %bb.19:                              //   in Loop: Header=BB6_14 Depth=1
	ldr	x8, [x8, #168]
	cbz	x8, .LBB6_21
// %bb.20:                              //   in Loop: Header=BB6_14 Depth=1
	orr	w1, wzr, #0x1
	mov	x0, x25
	blr	x8
.LBB6_21:                               //   in Loop: Header=BB6_14 Depth=1
	ldr	x28, [x28]
	cmp	x28, x27
	b.ne	.LBB6_14
.LBB6_22:
	ldp	x29, x30, [sp, #80]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]     // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]     // 16-byte Folded Reload
	ldp	x28, x27, [sp], #96     // 16-byte Folded Reload
	ret
.Lfunc_end6:
	.size	mas_blk_panic_dump, .Lfunc_end6-mas_blk_panic_dump
                                        // -- End function
	.globl	mas_blk_panic_notify    // -- Begin function mas_blk_panic_notify
	.p2align	3
	.type	mas_blk_panic_notify,@function
mas_blk_panic_notify:                   // @mas_blk_panic_notify
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	bl	_mcount
	bl	ktime_get
	adrp	x19, .L__func__.mas_blk_panic_notify
	mov	x2, x0
	adrp	x0, .L.str.15
	add	x19, x19, :lo12:.L__func__.mas_blk_panic_notify
	add	x0, x0, :lo12:.L.str.15
	mov	x1, x19
	bl	printk
	bl	mas_blk_panic_dump
	adrp	x0, .L.str.16
	add	x0, x0, :lo12:.L.str.16
	mov	x1, x19
	bl	printk
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	mov	w0, wzr
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end7:
	.size	mas_blk_panic_notify, .Lfunc_end7-mas_blk_panic_notify
                                        // -- End function
	.globl	mas_blk_dump_register_queue // -- Begin function mas_blk_dump_register_queue
	.p2align	3
	.type	mas_blk_dump_register_queue,@function
mas_blk_dump_register_queue:            // @mas_blk_dump_register_queue
// %bb.0:
	stp	x22, x21, [sp, #-48]!   // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	bl	_mcount
	mov	x0, x19
	bl	mas_blk_get_lld
	ldrb	w8, [x0, #24]
	tbz	w8, #0, .LBB8_5
// %bb.1:
	ldr	x8, [x19, #2152]
	add	x20, x19, #2152         // =2152
	cmp	x20, x8
	b.ne	.LBB8_5
// %bb.2:
	adrp	x0, dump_list_lock
	add	x0, x0, :lo12:dump_list_lock
	bl	_raw_spin_lock
	adrp	x22, dump_list
	add	x22, x22, :lo12:dump_list
	mov	x0, x20
	mov	x2, x22
	ldr	x21, [x22, #8]
	mov	x1, x21
	bl	__list_add_valid
	tbz	w0, #0, .LBB8_4
// %bb.3:
	str	x20, [x22, #8]
	str	x22, [x19, #2152]
	str	x21, [x19, #2160]
	str	x20, [x21]
.LBB8_4:
	adrp	x0, dump_list_lock
	add	x0, x0, :lo12:dump_list_lock
	bl	_raw_spin_unlock
.LBB8_5:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldp	x22, x21, [sp], #48     // 16-byte Folded Reload
	ret
.Lfunc_end8:
	.size	mas_blk_dump_register_queue, .Lfunc_end8-mas_blk_dump_register_queue
                                        // -- End function
	.globl	mas_blk_dump_unregister_queue // -- Begin function mas_blk_dump_unregister_queue
	.p2align	3
	.type	mas_blk_dump_unregister_queue,@function
mas_blk_dump_unregister_queue:          // @mas_blk_dump_unregister_queue
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x20, x0
	bl	_mcount
	adrp	x0, dump_list_lock
	add	x0, x0, :lo12:dump_list_lock
	bl	_raw_spin_lock
	adrp	x8, dump_list
	ldr	x9, [x8, :lo12:dump_list]
	adrp	x8, dump_list
	add	x8, x8, :lo12:dump_list
.LBB9_1:                                // =>This Inner Loop Header: Depth=1
	cmp	x9, x8
	b.eq	.LBB9_6
// %bb.2:                               //   in Loop: Header=BB9_1 Depth=1
	mov	x19, x9
	ldr	x9, [x9]
	sub	x10, x19, #2152         // =2152
	cmp	x10, x20
	b.ne	.LBB9_1
// %bb.3:
	mov	x0, x19
	bl	__list_del_entry_valid
	tbz	w0, #0, .LBB9_5
// %bb.4:
	ldp	x8, x9, [x19]
	str	x9, [x8, #8]
	str	x8, [x9]
.LBB9_5:
	mov	x8, #256
	movk	x8, #57005, lsl #48
	add	x9, x8, #256            // =256
	stp	x8, x9, [x19]
.LBB9_6:
	adrp	x0, dump_list_lock
	add	x0, x0, :lo12:dump_list_lock
	bl	_raw_spin_unlock
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end9:
	.size	mas_blk_dump_unregister_queue, .Lfunc_end9-mas_blk_dump_unregister_queue
                                        // -- End function
	.section	.init.text,"ax",@progbits
	.globl	mas_blk_dump_init       // -- Begin function mas_blk_dump_init
	.p2align	2
	.type	mas_blk_dump_init,@function
mas_blk_dump_init:                      // @mas_blk_dump_init
// %bb.0:
	stp	x29, x30, [sp, #-16]!   // 16-byte Folded Spill
	mov	x29, sp
	bl	_mcount
	adrp	x0, panic_notifier_list
	adrp	x1, mas_blk_panic_nb
	add	x0, x0, :lo12:panic_notifier_list
	add	x1, x1, :lo12:mas_blk_panic_nb
	bl	atomic_notifier_chain_register
	ldp	x29, x30, [sp], #16     // 16-byte Folded Reload
	ret
.Lfunc_end10:
	.size	mas_blk_dump_init, .Lfunc_end10-mas_blk_dump_init
                                        // -- End function
	.text
	.globl	blk_mq_tagset_dump_register // -- Begin function blk_mq_tagset_dump_register
	.p2align	3
	.type	blk_mq_tagset_dump_register,@function
blk_mq_tagset_dump_register:            // @blk_mq_tagset_dump_register
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	ldr	x8, [x20, #40]
	str	x19, [x20, #56]
	orr	x8, x8, #0x1
	str	x8, [x20, #40]
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end11:
	.size	blk_mq_tagset_dump_register, .Lfunc_end11-blk_mq_tagset_dump_register
                                        // -- End function
	.globl	blk_queue_dump_register // -- Begin function blk_queue_dump_register
	.p2align	3
	.type	blk_queue_dump_register,@function
blk_queue_dump_register:                // @blk_queue_dump_register
// %bb.0:
	stp	x22, x21, [sp, #-48]!   // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x20, x1
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x19, x0
	bl	_mcount
	mov	x0, x19
	bl	mas_blk_get_lld
	ldr	x8, [x0, #24]
	str	x20, [x0, #40]
	orr	x8, x8, #0x1
	str	x8, [x0, #24]
	mov	x0, x19
	bl	mas_blk_get_lld
	ldrb	w8, [x0, #24]
	tbz	w8, #0, .LBB12_5
// %bb.1:
	ldr	x8, [x19, #2152]
	add	x20, x19, #2152         // =2152
	cmp	x20, x8
	b.ne	.LBB12_5
// %bb.2:
	adrp	x0, dump_list_lock
	add	x0, x0, :lo12:dump_list_lock
	bl	_raw_spin_lock
	adrp	x22, dump_list
	add	x22, x22, :lo12:dump_list
	mov	x0, x20
	mov	x2, x22
	ldr	x21, [x22, #8]
	mov	x1, x21
	bl	__list_add_valid
	tbz	w0, #0, .LBB12_4
// %bb.3:
	str	x20, [x22, #8]
	str	x22, [x19, #2152]
	str	x21, [x19, #2160]
	str	x20, [x21]
.LBB12_4:
	adrp	x0, dump_list_lock
	add	x0, x0, :lo12:dump_list_lock
	bl	_raw_spin_unlock
.LBB12_5:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldp	x22, x21, [sp], #48     // 16-byte Folded Reload
	ret
.Lfunc_end12:
	.size	blk_queue_dump_register, .Lfunc_end12-blk_queue_dump_register
                                        // -- End function
	.type	.L.str,@object          // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"rq: 0x%pK, type:%s len:%u %s requeue_reason: %d tag: %d "
	.size	.L.str, 57

	.type	.L.str.1,@object        // @.str.1
.L.str.1:
	.asciz	"rq_hoq_flag: %llx rq_cp_flag: %llx "
	.size	.L.str.1, 36

	.type	.L.str.2,@object        // @.str.2
.L.str.2:
	.asciz	"disp_pid: %d %s, task: 0x%pK\n"
	.size	.L.str.2, 30

	.type	.L.str.3,@object        // @.str.3
.L.str.3:
	.asciz	"\n"
	.size	.L.str.3, 2

	.type	.L.str.4,@object        // @.str.4
.L.str.4:
	.asciz	"%s: %lld "
	.size	.L.str.4, 10

	.type	.L.str.5,@object        // @.str.5
.L.str.5:
	.asciz	"\0013[BLK-IO]%s: %s\n"
	.size	.L.str.5, 18

	.type	.L.str.6,@object        // @.str.6
.L.str.6:
	.asciz	"bio: 0x%pK, type:%s len:%u "
	.size	.L.str.6, 28

	.type	.L.str.7,@object        // @.str.7
.L.str.7:
	.asciz	"disp_pid: %d %s"
	.size	.L.str.7, 16

	.type	.L.str.8,@object        // @.str.8
.L.str.8:
	.asciz	", task: 0x%pK"
	.size	.L.str.8, 14

	.type	.L.str.9,@object        // @.str.9
.L.str.9:
	.asciz	"<%s:%lld> "
	.size	.L.str.9, 11

	.type	.L.str.10,@object       // @.str.10
.L.str.10:
	.asciz	"\0013[BLK-IO]%s %s,current: %lld\n"
	.size	.L.str.10, 31

	.type	.L.str.11,@object       // @.str.11
.L.str.11:
	.asciz	"\0013[BLK-IO]%s: bdev %s, ptable %s, r_inflt: %d w_inflt: %d"
	.size	.L.str.11, 58

	.type	.L.str.12,@object       // @.str.12
.L.str.12:
	.asciz	"exist"
	.size	.L.str.12, 6

	.type	.L.str.13,@object       // @.str.13
.L.str.13:
	.asciz	"none"
	.size	.L.str.13, 5

	.type	.L.str.14,@object       // @.str.14
.L.str.14:
	.asciz	"\0013[BLK-IO]q: 0x%pK"
	.size	.L.str.14, 19

	.type	dump_list,@object       // @dump_list
	.data
	.p2align	3
dump_list:
	.xword	dump_list
	.xword	dump_list
	.size	dump_list, 16

	.type	.L.str.15,@object       // @.str.15
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.15:
	.asciz	"\0013[BLK-IO]%s: ++ current = %lld\n"
	.size	.L.str.15, 33

	.type	.L__func__.mas_blk_panic_notify,@object // @__func__.mas_blk_panic_notify
.L__func__.mas_blk_panic_notify:
	.asciz	"mas_blk_panic_notify"
	.size	.L__func__.mas_blk_panic_notify, 21

	.type	.L.str.16,@object       // @.str.16
.L.str.16:
	.asciz	"\0013[BLK-IO]%s: --\n"
	.size	.L.str.16, 18

	.type	dump_list_lock,@object  // @dump_list_lock
	.data
	.p2align	3
dump_list_lock:
	.zero	4
	.word	3735899821              // 0xdead4ead
	.word	4294967295              // 0xffffffff
	.zero	4
	.xword	-1
	.xword	0
	.zero	16
	.xword	.L.str.48
	.word	0                       // 0x0
	.zero	4
	.xword	0                       // 0x0
	.xword	0                       // 0x0
	.size	dump_list_lock, 80

	.type	mas_blk_panic_nb,@object // @mas_blk_panic_nb
	.p2align	3
mas_blk_panic_nb:
	.xword	__cfi_mas_blk_panic_notify
	.xword	0
	.word	0                       // 0x0
	.zero	4
	.size	mas_blk_panic_nb, 24

	.type	.L.str.17,@object       // @.str.17
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.17:
	.asciz	"dump"
	.size	.L.str.17, 5

	.type	.L.str.18,@object       // @.str.18
.L.str.18:
	.asciz	"io_latency"
	.size	.L.str.18, 11

	.type	.L.str.19,@object       // @.str.19
.L.str.19:
	.asciz	"TYPE_BLOCK_PC"
	.size	.L.str.19, 14

	.type	.L.str.20,@object       // @.str.20
.L.str.20:
	.asciz	"TYPE_DRV_PRIV"
	.size	.L.str.20, 14

	.type	.L.str.21,@object       // @.str.21
.L.str.21:
	.asciz	"TYPE_FS"
	.size	.L.str.21, 8

	.type	.L.str.22,@object       // @.str.22
.L.str.22:
	.asciz	"\0014[BLK-IO]%s: Unknown OP!\n"
	.size	.L.str.22, 27

	.type	.L__func__.mas_blk_io_type_op,@object // @__func__.mas_blk_io_type_op
.L__func__.mas_blk_io_type_op:
	.asciz	"mas_blk_io_type_op"
	.size	.L__func__.mas_blk_io_type_op, 19

	.type	.L.str.23,@object       // @.str.23
.L.str.23:
	.asciz	"Queue Status:\n"
	.size	.L.str.23, 15

	.type	.L.str.24,@object       // @.str.24
.L.str.24:
	.asciz	"%s"
	.size	.L.str.24, 3

	.type	.L.str.25,@object       // @.str.25
.L.str.25:
	.asciz	"\0013[BLK-IO]%s"
	.size	.L.str.25, 13

	.type	.L.str.26,@object       // @.str.26
.L.str.26:
	.asciz	"\tIO Latency Warning: enable\tThreshold(ms): %u\n"
	.size	.L.str.26, 47

	.type	.L.str.27,@object       // @.str.27
.L.str.27:
	.asciz	"\tIO Latency Warning: disable\n"
	.size	.L.str.27, 30

	.type	.L.str.28,@object       // @.str.28
.L.str.28:
	.asciz	"\tFlush Reduce: %s\n"
	.size	.L.str.28, 19

	.type	.L.str.29,@object       // @.str.29
.L.str.29:
	.asciz	"enable"
	.size	.L.str.29, 7

	.type	.L.str.30,@object       // @.str.30
.L.str.30:
	.asciz	"disable"
	.size	.L.str.30, 8

	.type	.L.str.31,@object       // @.str.31
.L.str.31:
	.asciz	"LLD Status:\n"
	.size	.L.str.31, 13

	.type	.L.str.32,@object       // @.str.32
.L.str.32:
	.asciz	"\tPanic Dump: %s\n"
	.size	.L.str.32, 17

	.type	.L.str.33,@object       // @.str.33
.L.str.33:
	.asciz	"\tLatency Warning:enable\tThreshold(ms):%u\n"
	.size	.L.str.33, 42

	.type	.L.str.34,@object       // @.str.34
.L.str.34:
	.asciz	"\tLatency Warning: disable\n"
	.size	.L.str.34, 27

	.type	.L.str.35,@object       // @.str.35
.L.str.35:
	.asciz	"\tBusy/Idle Notifier: %s\t"
	.size	.L.str.35, 25

	.type	.L.str.36,@object       // @.str.36
.L.str.36:
	.asciz	"\tState: BUSY\t"
	.size	.L.str.36, 14

	.type	.L.str.37,@object       // @.str.37
.L.str.37:
	.asciz	"\tState: IDLE\t"
	.size	.L.str.37, 14

	.type	.L.str.38,@object       // @.str.38
.L.str.38:
	.asciz	"\tIO Count: %d\n"
	.size	.L.str.38, 15

	.type	.L.str.39,@object       // @.str.39
.L.str.39:
	.asciz	"\tIO Scheduler: "
	.size	.L.str.39, 16

	.type	.L.str.41,@object       // @.str.41
.L.str.41:
	.asciz	"Default Scheduler\n"
	.size	.L.str.41, 19

	.type	.L.str.42,@object       // @.str.42
.L.str.42:
	.asciz	"\tInline Crypto: %s\n"
	.size	.L.str.42, 20

	.type	.L.str.43,@object       // @.str.43
.L.str.43:
	.asciz	"\tUFS command priority: %s\n"
	.size	.L.str.43, 27

	.type	.L.str.44,@object       // @.str.44
.L.str.44:
	.asciz	"\tUFS order preserving: %s\n"
	.size	.L.str.44, 27

	.type	.L.str.45,@object       // @.str.45
.L.str.45:
	.asciz	"\0013[BLK-IO]bio_count = %llu req_count = %llu\n"
	.size	.L.str.45, 45

	.type	.L.str.46,@object       // @.str.46
.L.str.46:
	.asciz	"\0013[BLK-IO]bio_list:\n"
	.size	.L.str.46, 21

	.type	.L.str.47,@object       // @.str.47
.L.str.47:
	.asciz	"\0013[BLK-IO]req_list:\n"
	.size	.L.str.47, 21

	.type	.L.str.48,@object       // @.str.48
.L.str.48:
	.asciz	"dump_list_lock"
	.size	.L.str.48, 15


	.ident	"Snapdragon LLVM ARM Compiler 8.0.12 for Android NDK (based on llvm.org 7.0+)"
	.section	".note.GNU-stack","",@progbits
