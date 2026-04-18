	.text
	.file	"mas_bkops_sysfs.c"
	.globl	mas_bkops_stat_open     // -- Begin function mas_bkops_stat_open
	.p2align	3
	.type	mas_bkops_stat_open,@function
mas_bkops_stat_open:                    // @mas_bkops_stat_open
// %bb.0:
	sub	sp, sp, #144            // =144
	adrp	x8, __stack_chk_guard
	stp	x28, x27, [sp, #48]     // 16-byte Folded Spill
	stp	x26, x25, [sp, #64]     // 16-byte Folded Spill
	stp	x24, x23, [sp, #80]     // 16-byte Folded Spill
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	stp	x22, x21, [sp, #96]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #112]    // 16-byte Folded Spill
	mov	x19, x1
	stp	x29, x30, [sp, #128]    // 16-byte Folded Spill
	add	x29, sp, #128           // =128
	mov	x20, x0
	str	x8, [sp, #40]
	bl	_mcount
	adrp	x8, kmalloc_caches
	ldr	x26, [x20, #1208]
	add	x8, x8, :lo12:kmalloc_caches
	mov	w1, #32960
	movk	w1, #96, lsl #16
	ldr	x0, [x8, #96]
	orr	w2, wzr, #0x1000
	bl	kmem_cache_alloc_trace
	cbz	x0, .LBB0_4
// %bb.1:
	ldr	w3, [x26, #360]
	adrp	x2, .L.str.13
	add	x2, x2, :lo12:.L.str.13
	str	x19, [sp]               // 8-byte Folded Spill
	orr	w1, wzr, #0x1000
	mov	x20, x0
	orr	w22, wzr, #0x1000
	bl	snprintf
	mov	w21, w0
	ldr	w3, [x26, #364]
	adrp	x2, .L.str.14
	sxtw	x8, w21
	add	x0, x20, x8
	sub	x1, x22, x8
	add	x2, x2, :lo12:.L.str.14
	bl	snprintf
	ldr	w3, [x26, #368]
	add	w19, w0, w21
	adrp	x2, .L.str.15
	sxtw	x8, w19
	add	x0, x20, x8
	sub	x1, x22, x8
	add	x2, x2, :lo12:.L.str.15
	bl	snprintf
	ldr	w3, [x26, #372]
	add	w19, w0, w19
	adrp	x2, .L.str.16
	sxtw	x8, w19
	add	x0, x20, x8
	sub	x1, x22, x8
	add	x2, x2, :lo12:.L.str.16
	bl	snprintf
	ldr	w3, [x26, #376]
	add	w19, w0, w19
	adrp	x2, .L.str.17
	sxtw	x8, w19
	add	x0, x20, x8
	sub	x1, x22, x8
	add	x2, x2, :lo12:.L.str.17
	bl	snprintf
	add	w19, w0, w19
	adrp	x2, .L.str.18
	sxtw	x8, w19
	add	x0, x20, x8
	sub	x1, x22, x8
	add	x2, x2, :lo12:.L.str.18
	bl	snprintf
	ldr	w8, [x26, #552]
	add	w19, w19, w0
	sxtw	x9, w19
	add	x23, x20, x9
	sub	x24, x22, x9
	mov	w22, wzr
	cbz	w8, .LBB0_5
// %bb.2:
	adrp	x21, .L.str.19
	mov	x25, xzr
	add	x27, x26, #512          // =512
	mov	x1, x24
	mov	x0, x23
	add	x21, x21, :lo12:.L.str.19
.LBB0_3:                                // =>This Inner Loop Header: Depth=1
	ldr	x8, [x26, #560]
	mov	x2, x21
	ldr	w4, [x27, x25, lsl #2]
	ldr	x3, [x8, x25, lsl #3]
	bl	snprintf
	ldr	w8, [x26, #552]
	add	w22, w0, w22
	add	x25, x25, #1            // =1
	sxtw	x9, w22
	add	x0, x23, x9
	sub	x1, x24, x9
	cmp	x25, x8
	b.lo	.LBB0_3
	b	.LBB0_6
.LBB0_4:
	mov	w0, #-12
	b	.LBB0_71
.LBB0_5:
	mov	x0, x23
	mov	x1, x24
.LBB0_6:
	adrp	x21, .L.str.18
	add	x21, x21, :lo12:.L.str.18
	mov	x2, x21
	mov	x28, #58368
	movk	x28, #21515, lsl #16
	mov	w27, #51712
	movk	x28, #2, lsl #32
	movk	w27, #15258, lsl #16
	bl	snprintf
	add	w8, w22, w19
	ldr	w3, [x26, #380]
	add	w19, w8, w0
	orr	w25, wzr, #0x1000
	sxtw	x8, w19
	add	x22, x20, x8
	sub	x23, x25, x8
	adrp	x2, .L.str.20
	add	x2, x2, :lo12:.L.str.20
	mov	x0, x22
	mov	x1, x23
	bl	snprintf
	mov	w24, w0
	ldr	w3, [x26, #384]
	adrp	x2, .L.str.21
	sxtw	x8, w24
	add	x0, x22, x8
	sub	x1, x23, x8
	add	x2, x2, :lo12:.L.str.21
	bl	snprintf
	ldr	w3, [x26, #388]
	add	w24, w0, w24
	adrp	x2, .L.str.22
	sxtw	x8, w24
	add	x0, x22, x8
	sub	x1, x23, x8
	add	x2, x2, :lo12:.L.str.22
	bl	snprintf
	ldr	w3, [x26, #392]
	add	w24, w0, w24
	adrp	x2, .L.str.23
	sxtw	x8, w24
	add	x0, x22, x8
	sub	x1, x23, x8
	add	x2, x2, :lo12:.L.str.23
	bl	snprintf
	ldr	w3, [x26, #396]
	add	w24, w0, w24
	adrp	x2, .L.str.24
	sxtw	x8, w24
	add	x0, x22, x8
	sub	x1, x23, x8
	add	x2, x2, :lo12:.L.str.24
	bl	snprintf
	ldr	w3, [x26, #400]
	add	w24, w0, w24
	adrp	x2, .L.str.25
	sxtw	x8, w24
	add	x0, x22, x8
	sub	x1, x23, x8
	add	x2, x2, :lo12:.L.str.25
	bl	snprintf
	add	w24, w0, w24
	sxtw	x8, w24
	add	x0, x22, x8
	sub	x1, x23, x8
	mov	x2, x21
	bl	snprintf
	add	w8, w0, w19
	ldr	w3, [x26, #404]
	add	w19, w8, w24
	sxtw	x8, w19
	add	x22, x20, x8
	sub	x23, x25, x8
	adrp	x2, .L.str.26
	add	x2, x2, :lo12:.L.str.26
	mov	x0, x22
	mov	x1, x23
	bl	snprintf
	mov	w24, w0
	ldr	w3, [x26, #408]
	adrp	x2, .L.str.27
	sxtw	x8, w24
	add	x0, x22, x8
	sub	x1, x23, x8
	add	x2, x2, :lo12:.L.str.27
	bl	snprintf
	ldr	w3, [x26, #412]
	add	w24, w0, w24
	adrp	x2, .L.str.28
	sxtw	x8, w24
	add	x0, x22, x8
	sub	x1, x23, x8
	add	x2, x2, :lo12:.L.str.28
	bl	snprintf
	add	w24, w0, w24
	sxtw	x8, w24
	add	x0, x22, x8
	sub	x1, x23, x8
	mov	x2, x21
	bl	snprintf
	ldr	x3, [x26, #424]
	add	w8, w0, w19
	add	w19, w8, w24
	sxtw	x8, w19
	add	x21, x20, x8
	sub	x22, x25, x8
	cmp	x3, #11                 // =11
	b.hs	.LBB0_8
// %bb.7:
	adrp	x2, .L.str.36
	add	x2, x2, :lo12:.L.str.36
	add	x0, sp, #8              // =8
	orr	w1, wzr, #0x20
	bl	snprintf
	b	.LBB0_14
.LBB0_8:
	cmp	x3, x28
	b.hs	.LBB0_11
// %bb.9:
	mov	w8, #38528
	movk	w8, #152, lsl #16
	cmp	x3, x8
	b.hs	.LBB0_12
// %bb.10:
	lsr	x8, x3, #4
	cmp	x8, #625                // =625
	orr	w8, wzr, #0x2
	mov	w9, #1000
	cinc	x8, x8, lo
	csinc	x9, x9, xzr, hs
	b	.LBB0_13
.LBB0_11:
	mov	x8, xzr
	mov	x9, x27
	b	.LBB0_13
.LBB0_12:
	mov	w9, #16960
	orr	w8, wzr, #0x1
	movk	w9, #15, lsl #16
.LBB0_13:
	adrp	x10, time_unit
	udiv	x3, x3, x9
	add	x10, x10, :lo12:time_unit
	adrp	x2, .L.str.37
	add	x2, x2, :lo12:.L.str.37
	ldr	x4, [x10, x8, lsl #3]
	add	x0, sp, #8              // =8
	orr	w1, wzr, #0x20
	bl	snprintf
.LBB0_14:
	adrp	x2, .L.str.29
	strb	wzr, [sp, #39]
	add	x2, x2, :lo12:.L.str.29
	add	x3, sp, #8              // =8
	mov	x0, x21
	mov	x1, x22
	bl	snprintf
	ldr	x3, [x26, #432]
	mov	w23, w0
	sxtw	x8, w23
	add	x24, x21, x8
	sub	x25, x22, x8
	cmp	x3, #11                 // =11
	b.hs	.LBB0_16
// %bb.15:
	adrp	x2, .L.str.36
	add	x2, x2, :lo12:.L.str.36
	add	x0, sp, #8              // =8
	orr	w1, wzr, #0x20
	bl	snprintf
	b	.LBB0_22
.LBB0_16:
	cmp	x3, x28
	b.hs	.LBB0_19
// %bb.17:
	mov	w8, #38528
	movk	w8, #152, lsl #16
	cmp	x3, x8
	b.hs	.LBB0_20
// %bb.18:
	lsr	x8, x3, #4
	cmp	x8, #625                // =625
	orr	w8, wzr, #0x2
	mov	w9, #1000
	cinc	x8, x8, lo
	csinc	x9, x9, xzr, hs
	b	.LBB0_21
.LBB0_19:
	mov	x8, xzr
	mov	x9, x27
	b	.LBB0_21
.LBB0_20:
	mov	w9, #16960
	orr	w8, wzr, #0x1
	movk	w9, #15, lsl #16
.LBB0_21:
	adrp	x10, time_unit
	udiv	x3, x3, x9
	add	x10, x10, :lo12:time_unit
	adrp	x2, .L.str.37
	add	x2, x2, :lo12:.L.str.37
	ldr	x4, [x10, x8, lsl #3]
	add	x0, sp, #8              // =8
	orr	w1, wzr, #0x20
	bl	snprintf
.LBB0_22:
	adrp	x2, .L.str.30
	strb	wzr, [sp, #39]
	add	x2, x2, :lo12:.L.str.30
	add	x3, sp, #8              // =8
	mov	x0, x24
	mov	x1, x25
	bl	snprintf
	ldr	x3, [x26, #440]
	add	w25, w0, w23
	sxtw	x8, w25
	add	x23, x21, x8
	sub	x24, x22, x8
	cmp	x3, #11                 // =11
	b.hs	.LBB0_24
// %bb.23:
	adrp	x2, .L.str.36
	add	x2, x2, :lo12:.L.str.36
	add	x0, sp, #8              // =8
	orr	w1, wzr, #0x20
	bl	snprintf
	b	.LBB0_30
.LBB0_24:
	cmp	x3, x28
	b.hs	.LBB0_27
// %bb.25:
	mov	w8, #38528
	movk	w8, #152, lsl #16
	cmp	x3, x8
	b.hs	.LBB0_28
// %bb.26:
	lsr	x8, x3, #4
	cmp	x8, #625                // =625
	orr	w8, wzr, #0x2
	mov	w9, #1000
	cinc	x8, x8, lo
	csinc	x9, x9, xzr, hs
	b	.LBB0_29
.LBB0_27:
	mov	x8, xzr
	mov	x9, x27
	b	.LBB0_29
.LBB0_28:
	mov	w9, #16960
	orr	w8, wzr, #0x1
	movk	w9, #15, lsl #16
.LBB0_29:
	adrp	x10, time_unit
	udiv	x3, x3, x9
	add	x10, x10, :lo12:time_unit
	adrp	x2, .L.str.37
	add	x2, x2, :lo12:.L.str.37
	ldr	x4, [x10, x8, lsl #3]
	add	x0, sp, #8              // =8
	orr	w1, wzr, #0x20
	bl	snprintf
.LBB0_30:
	adrp	x2, .L.str.31
	strb	wzr, [sp, #39]
	add	x2, x2, :lo12:.L.str.31
	add	x3, sp, #8              // =8
	mov	x0, x23
	mov	x1, x24
	bl	snprintf
	ldr	x3, [x26, #448]
	add	w25, w0, w25
	sxtw	x8, w25
	add	x23, x21, x8
	sub	x24, x22, x8
	cmp	x3, #11                 // =11
	b.hs	.LBB0_32
// %bb.31:
	adrp	x2, .L.str.36
	add	x2, x2, :lo12:.L.str.36
	add	x0, sp, #8              // =8
	orr	w1, wzr, #0x20
	bl	snprintf
	b	.LBB0_38
.LBB0_32:
	cmp	x3, x28
	b.hs	.LBB0_35
// %bb.33:
	mov	w8, #38528
	movk	w8, #152, lsl #16
	cmp	x3, x8
	b.hs	.LBB0_36
// %bb.34:
	lsr	x8, x3, #4
	cmp	x8, #625                // =625
	orr	w8, wzr, #0x2
	mov	w9, #1000
	cinc	x8, x8, lo
	csinc	x9, x9, xzr, hs
	b	.LBB0_37
.LBB0_35:
	mov	x8, xzr
	mov	x9, x27
	b	.LBB0_37
.LBB0_36:
	mov	w9, #16960
	orr	w8, wzr, #0x1
	movk	w9, #15, lsl #16
.LBB0_37:
	adrp	x10, time_unit
	udiv	x3, x3, x9
	add	x10, x10, :lo12:time_unit
	adrp	x2, .L.str.37
	add	x2, x2, :lo12:.L.str.37
	ldr	x4, [x10, x8, lsl #3]
	add	x0, sp, #8              // =8
	orr	w1, wzr, #0x20
	bl	snprintf
.LBB0_38:
	adrp	x2, .L.str.32
	strb	wzr, [sp, #39]
	add	x2, x2, :lo12:.L.str.32
	add	x3, sp, #8              // =8
	mov	x0, x23
	mov	x1, x24
	bl	snprintf
	ldr	x3, [x26, #456]
	add	w25, w0, w25
	sxtw	x8, w25
	add	x23, x21, x8
	sub	x24, x22, x8
	cmp	x3, #11                 // =11
	b.hs	.LBB0_40
// %bb.39:
	adrp	x2, .L.str.36
	add	x2, x2, :lo12:.L.str.36
	add	x0, sp, #8              // =8
	orr	w1, wzr, #0x20
	bl	snprintf
	b	.LBB0_46
.LBB0_40:
	cmp	x3, x28
	b.hs	.LBB0_43
// %bb.41:
	mov	w8, #38528
	movk	w8, #152, lsl #16
	cmp	x3, x8
	b.hs	.LBB0_44
// %bb.42:
	lsr	x8, x3, #4
	cmp	x8, #625                // =625
	orr	w8, wzr, #0x2
	mov	w9, #1000
	cinc	x8, x8, lo
	csinc	x9, x9, xzr, hs
	b	.LBB0_45
.LBB0_43:
	mov	x8, xzr
	mov	x9, x27
	b	.LBB0_45
.LBB0_44:
	mov	w9, #16960
	orr	w8, wzr, #0x1
	movk	w9, #15, lsl #16
.LBB0_45:
	adrp	x10, time_unit
	udiv	x3, x3, x9
	add	x10, x10, :lo12:time_unit
	adrp	x2, .L.str.37
	add	x2, x2, :lo12:.L.str.37
	ldr	x4, [x10, x8, lsl #3]
	add	x0, sp, #8              // =8
	orr	w1, wzr, #0x20
	bl	snprintf
.LBB0_46:
	adrp	x2, .L.str.33
	strb	wzr, [sp, #39]
	add	x2, x2, :lo12:.L.str.33
	add	x3, sp, #8              // =8
	mov	x0, x23
	mov	x1, x24
	bl	snprintf
	ldr	x3, [x26, #464]
	add	w25, w0, w25
	sxtw	x8, w25
	add	x23, x21, x8
	sub	x24, x22, x8
	cmp	x3, #11                 // =11
	b.hs	.LBB0_48
// %bb.47:
	adrp	x2, .L.str.36
	add	x2, x2, :lo12:.L.str.36
	add	x0, sp, #8              // =8
	orr	w1, wzr, #0x20
	bl	snprintf
	b	.LBB0_54
.LBB0_48:
	cmp	x3, x28
	b.hs	.LBB0_51
// %bb.49:
	mov	w8, #38528
	movk	w8, #152, lsl #16
	cmp	x3, x8
	b.hs	.LBB0_52
// %bb.50:
	lsr	x8, x3, #4
	cmp	x8, #625                // =625
	orr	w8, wzr, #0x2
	mov	w9, #1000
	cinc	x8, x8, lo
	csinc	x9, x9, xzr, hs
	b	.LBB0_53
.LBB0_51:
	mov	x8, xzr
	mov	x9, x27
	b	.LBB0_53
.LBB0_52:
	mov	w9, #16960
	orr	w8, wzr, #0x1
	movk	w9, #15, lsl #16
.LBB0_53:
	adrp	x10, time_unit
	udiv	x3, x3, x9
	add	x10, x10, :lo12:time_unit
	adrp	x2, .L.str.37
	add	x2, x2, :lo12:.L.str.37
	ldr	x4, [x10, x8, lsl #3]
	add	x0, sp, #8              // =8
	orr	w1, wzr, #0x20
	bl	snprintf
.LBB0_54:
	adrp	x2, .L.str.34
	strb	wzr, [sp, #39]
	add	x2, x2, :lo12:.L.str.34
	add	x3, sp, #8              // =8
	mov	x0, x23
	mov	x1, x24
	bl	snprintf
	add	w23, w0, w25
	adrp	x2, .L.str.18
	sxtw	x8, w23
	add	x0, x21, x8
	sub	x1, x22, x8
	add	x2, x2, :lo12:.L.str.18
	bl	snprintf
	ldr	x3, [x26, #472]
	add	w9, w0, w19
	orr	w8, wzr, #0x1000
	add	w9, w9, w23
	sxtw	x9, w9
	add	x21, x20, x9
	sub	x22, x8, x9
	cmp	x3, #11                 // =11
	b.hs	.LBB0_56
// %bb.55:
	adrp	x2, .L.str.36
	add	x2, x2, :lo12:.L.str.36
	add	x0, sp, #8              // =8
	orr	w1, wzr, #0x20
	bl	snprintf
	b	.LBB0_62
.LBB0_56:
	cmp	x3, x28
	b.hs	.LBB0_59
// %bb.57:
	mov	w8, #38528
	movk	w8, #152, lsl #16
	cmp	x3, x8
	b.hs	.LBB0_60
// %bb.58:
	lsr	x8, x3, #4
	cmp	x8, #625                // =625
	orr	w8, wzr, #0x2
	mov	w9, #1000
	cinc	x8, x8, lo
	csinc	x9, x9, xzr, hs
	b	.LBB0_61
.LBB0_59:
	mov	x8, xzr
	mov	x9, x27
	b	.LBB0_61
.LBB0_60:
	mov	w9, #16960
	orr	w8, wzr, #0x1
	movk	w9, #15, lsl #16
.LBB0_61:
	adrp	x10, time_unit
	udiv	x3, x3, x9
	add	x10, x10, :lo12:time_unit
	adrp	x2, .L.str.37
	add	x2, x2, :lo12:.L.str.37
	ldr	x4, [x10, x8, lsl #3]
	add	x0, sp, #8              // =8
	orr	w1, wzr, #0x20
	bl	snprintf
.LBB0_62:
	adrp	x2, .L.str.42
	strb	wzr, [sp, #39]
	add	x2, x2, :lo12:.L.str.42
	add	x3, sp, #8              // =8
	mov	x0, x21
	mov	x1, x22
	bl	snprintf
	ldr	x3, [x26, #480]
	mov	w23, w0
	sxtw	x8, w23
	add	x24, x21, x8
	sub	x25, x22, x8
	cmp	x3, #11                 // =11
	b.hs	.LBB0_64
// %bb.63:
	adrp	x2, .L.str.36
	add	x2, x2, :lo12:.L.str.36
	add	x0, sp, #8              // =8
	orr	w1, wzr, #0x20
	bl	snprintf
	b	.LBB0_70
.LBB0_64:
	cmp	x3, x28
	b.hs	.LBB0_67
// %bb.65:
	mov	w8, #38528
	movk	w8, #152, lsl #16
	cmp	x3, x8
	b.hs	.LBB0_68
// %bb.66:
	lsr	x8, x3, #4
	cmp	x8, #625                // =625
	orr	w8, wzr, #0x2
	mov	w9, #1000
	cinc	x8, x8, lo
	csinc	x27, x9, xzr, hs
	b	.LBB0_69
.LBB0_67:
	mov	x8, xzr
	b	.LBB0_69
.LBB0_68:
	mov	w27, #16960
	orr	w8, wzr, #0x1
	movk	w27, #15, lsl #16
.LBB0_69:
	adrp	x9, time_unit
	udiv	x3, x3, x27
	add	x9, x9, :lo12:time_unit
	adrp	x2, .L.str.37
	add	x2, x2, :lo12:.L.str.37
	ldr	x4, [x9, x8, lsl #3]
	add	x0, sp, #8              // =8
	orr	w1, wzr, #0x20
	bl	snprintf
.LBB0_70:
	adrp	x2, .L.str.43
	strb	wzr, [sp, #39]
	add	x2, x2, :lo12:.L.str.43
	add	x3, sp, #8              // =8
	mov	x0, x24
	mov	x1, x25
	bl	snprintf
	ldr	w3, [x26, #488]
	add	w19, w0, w23
	adrp	x2, .L.str.44
	sxtw	x8, w19
	add	x0, x21, x8
	sub	x1, x22, x8
	add	x2, x2, :lo12:.L.str.44
	bl	snprintf
	ldr	w3, [x26, #492]
	add	w19, w0, w19
	adrp	x2, .L.str.45
	sxtw	x8, w19
	add	x0, x21, x8
	sub	x1, x22, x8
	add	x2, x2, :lo12:.L.str.45
	bl	snprintf
	ldr	w3, [x26, #496]
	add	w19, w0, w19
	adrp	x2, .L.str.46
	sxtw	x8, w19
	add	x0, x21, x8
	sub	x1, x22, x8
	add	x2, x2, :lo12:.L.str.46
	bl	snprintf
	ldr	w3, [x26, #500]
	add	w19, w0, w19
	adrp	x2, .L.str.47
	sxtw	x8, w19
	add	x0, x21, x8
	sub	x1, x22, x8
	add	x2, x2, :lo12:.L.str.47
	bl	snprintf
	ldr	w3, [x26, #504]
	add	w19, w0, w19
	adrp	x2, .L.str.48
	sxtw	x8, w19
	add	x0, x21, x8
	sub	x1, x22, x8
	add	x2, x2, :lo12:.L.str.48
	bl	snprintf
	ldr	w3, [x26, #508]
	add	w8, w0, w19
	adrp	x2, .L.str.49
	sxtw	x8, w8
	add	x0, x21, x8
	sub	x1, x22, x8
	add	x2, x2, :lo12:.L.str.49
	bl	snprintf
	ldr	x8, [sp]                // 8-byte Folded Reload
	mov	w0, wzr
	strb	wzr, [x20, #4095]
	str	x20, [x8, #512]
.LBB0_71:
	adrp	x9, __stack_chk_guard
	ldr	x8, [sp, #40]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB0_73
// %bb.72:
	ldp	x29, x30, [sp, #128]    // 16-byte Folded Reload
	ldp	x20, x19, [sp, #112]    // 16-byte Folded Reload
	ldp	x22, x21, [sp, #96]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #80]     // 16-byte Folded Reload
	ldp	x26, x25, [sp, #64]     // 16-byte Folded Reload
	ldp	x28, x27, [sp, #48]     // 16-byte Folded Reload
	add	sp, sp, #144            // =144
	ret
.LBB0_73:
	bl	__stack_chk_fail
.Lfunc_end0:
	.size	mas_bkops_stat_open, .Lfunc_end0-mas_bkops_stat_open
                                        // -- End function
	.globl	mas_bkops_stat_read     // -- Begin function mas_bkops_stat_read
	.p2align	3
	.type	mas_bkops_stat_read,@function
mas_bkops_stat_read:                    // @mas_bkops_stat_read
// %bb.0:
	stp	x22, x21, [sp, #-48]!   // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x3
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x20, x2
	mov	x21, x1
	mov	x22, x0
	bl	_mcount
	ldr	x22, [x22, #512]
	cbz	x22, .LBB1_2
// %bb.1:
	mov	x0, x22
	bl	strlen
	mov	x4, x0
	mov	x0, x21
	mov	x1, x20
	mov	x2, x19
	mov	x3, x22
	bl	simple_read_from_buffer
	b	.LBB1_3
.LBB1_2:
	mov	x0, xzr
.LBB1_3:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldp	x22, x21, [sp], #48     // 16-byte Folded Reload
	ret
.Lfunc_end1:
	.size	mas_bkops_stat_read, .Lfunc_end1-mas_bkops_stat_read
                                        // -- End function
	.globl	mas_bkops_stat_release  // -- Begin function mas_bkops_stat_release
	.p2align	3
	.type	mas_bkops_stat_release,@function
mas_bkops_stat_release:                 // @mas_bkops_stat_release
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	bl	_mcount
	ldr	x0, [x19, #512]
	cbz	x0, .LBB2_2
// %bb.1:
	bl	kfree
	str	xzr, [x19, #512]
.LBB2_2:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	mov	w0, wzr
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end2:
	.size	mas_bkops_stat_release, .Lfunc_end2-mas_bkops_stat_release
                                        // -- End function
	.globl	mas_bkops_force_query_open // -- Begin function mas_bkops_force_query_open
	.p2align	3
	.type	mas_bkops_force_query_open,@function
mas_bkops_force_query_open:             // @mas_bkops_force_query_open
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	ldr	x8, [x20, #1208]
	cbz	x8, .LBB3_5
// %bb.1:
	ldr	x9, [x8, #8]
	cbz	x9, .LBB3_5
// %bb.2:
	ldr	x9, [x9, #8]
	cbz	x9, .LBB3_5
// %bb.3:
	mov	w0, wzr
	str	x8, [x19, #512]
.LBB3_4:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.LBB3_5:
	adrp	x0, .L.str
	add	x0, x0, :lo12:.L.str
	bl	printk
	mov	w0, #-19
	b	.LBB3_4
.Lfunc_end3:
	.size	mas_bkops_force_query_open, .Lfunc_end3-mas_bkops_force_query_open
                                        // -- End function
	.globl	mas_bkops_force_query_read // -- Begin function mas_bkops_force_query_read
	.p2align	3
	.type	mas_bkops_force_query_read,@function
mas_bkops_force_query_read:             // @mas_bkops_force_query_read
// %bb.0:
	sub	sp, sp, #80             // =80
	adrp	x8, __stack_chk_guard
	str	x23, [sp, #16]          // 8-byte Folded Spill
	stp	x22, x21, [sp, #32]     // 16-byte Folded Spill
	mov	x21, x1
	stp	x20, x19, [sp, #48]     // 16-byte Folded Spill
	mov	x19, x3
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	mov	x20, x2
	stp	x29, x30, [sp, #64]     // 16-byte Folded Spill
	add	x29, sp, #64            // =64
	mov	x22, x0
	str	x8, [sp, #8]
	bl	_mcount
	adrp	x8, kmalloc_caches
	ldr	x23, [x22, #512]
	add	x8, x8, :lo12:kmalloc_caches
	str	wzr, [sp, #4]
	mov	w1, #32960
	movk	w1, #96, lsl #16
	ldr	x0, [x8, #96]
	orr	w2, wzr, #0x1000
	bl	kmem_cache_alloc_trace
	cbnz	x0, .LBB4_4
// %bb.1:
	mov	x19, #-12
.LBB4_2:
	adrp	x9, __stack_chk_guard
	ldr	x8, [sp, #8]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB4_8
// %bb.3:
	mov	x0, x19
	ldr	x23, [sp, #16]          // 8-byte Folded Reload
	ldp	x29, x30, [sp, #64]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]     // 16-byte Folded Reload
	add	sp, sp, #80             // =80
	ret
.LBB4_4:
	mov	x22, x0
	ldp	x8, x0, [x23, #8]
	add	x1, sp, #4              // =4
	ldr	x8, [x8, #8]
	blr	x8
	cbnz	w0, .LBB4_6
// %bb.5:
	ldr	w1, [sp, #4]
	adrp	x0, .L.str.3
	add	x0, x0, :lo12:.L.str.3
	bl	printk
	ldr	w3, [sp, #4]
	adrp	x2, .L.str.4
	add	x2, x2, :lo12:.L.str.4
	orr	w1, wzr, #0x1000
	mov	x0, x22
	bl	snprintf
	b	.LBB4_7
.LBB4_6:
	adrp	x0, .L.str.1
	add	x0, x0, :lo12:.L.str.1
	bl	printk
	adrp	x8, .L.str.2
	add	x8, x8, :lo12:.L.str.2
	ldur	x9, [x8, #23]
	ldp	x11, x10, [x8, #8]
	ldr	x8, [x8]
	stur	x9, [x22, #23]
	stp	x11, x10, [x22, #8]
	str	x8, [x22]
.LBB4_7:
	mov	x0, x22
	bl	strlen
	mov	x4, x0
	mov	x0, x21
	mov	x1, x20
	mov	x2, x19
	mov	x3, x22
	bl	simple_read_from_buffer
	mov	x19, x0
	mov	x0, x22
	bl	kfree
	b	.LBB4_2
.LBB4_8:
	bl	__stack_chk_fail
.Lfunc_end4:
	.size	mas_bkops_force_query_read, .Lfunc_end4-mas_bkops_force_query_read
                                        // -- End function
	.globl	mas_bkops_force_query_release // -- Begin function mas_bkops_force_query_release
	.p2align	3
	.type	mas_bkops_force_query_release,@function
mas_bkops_force_query_release:          // @mas_bkops_force_query_release
// %bb.0:
	stp	x29, x30, [sp, #-16]!   // 16-byte Folded Spill
	mov	x29, sp
	bl	_mcount
	mov	w0, wzr
	ldp	x29, x30, [sp], #16     // 16-byte Folded Reload
	ret
.Lfunc_end5:
	.size	mas_bkops_force_query_release, .Lfunc_end5-mas_bkops_force_query_release
                                        // -- End function
	.globl	mas_bkops_add_debugfs   // -- Begin function mas_bkops_add_debugfs
	.p2align	3
	.type	mas_bkops_add_debugfs,@function
mas_bkops_add_debugfs:                  // @mas_bkops_add_debugfs
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x20, x1
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x19, x0
	bl	_mcount
	mov	w0, #-19
	cbz	x19, .LBB6_25
// %bb.1:
	cmn	x20, #1, lsl #12        // =4096
	b.hi	.LBB6_25
// %bb.2:
	adrp	x0, .L.str.5
	add	x0, x0, :lo12:.L.str.5
	mov	x1, x20
	bl	debugfs_create_dir
	cmn	x0, #1, lsl #12         // =4096
	b.hi	.LBB6_24
// %bb.3:
	mov	x20, x0
	adrp	x0, .L.str.6
	adrp	x4, mas_bkops_stat_fops
	add	x0, x0, :lo12:.L.str.6
	add	x4, x4, :lo12:mas_bkops_stat_fops
	orr	w1, wzr, #0x180
	mov	x2, x20
	mov	x3, x19
	bl	debugfs_create_file
	cbz	x0, .LBB6_23
// %bb.4:
	adrp	x0, .L.str.7
	adrp	x4, mas_bkops_force_query_fops
	add	x0, x0, :lo12:.L.str.7
	add	x4, x4, :lo12:mas_bkops_force_query_fops
	orr	w1, wzr, #0x180
	mov	x2, x20
	mov	x3, x19
	bl	debugfs_create_file
	cbz	x0, .LBB6_23
// %bb.5:
	adrp	x0, .L.str.8
	add	x3, x19, #240           // =240
	add	x0, x0, :lo12:.L.str.8
	orr	w1, wzr, #0x180
	mov	x2, x20
	bl	debugfs_create_ulong
	cbz	x0, .LBB6_23
// %bb.6:
	adrp	x0, .L.str.9
	add	x3, x19, #312           // =312
	add	x0, x0, :lo12:.L.str.9
	orr	w1, wzr, #0x180
	mov	x2, x20
	bl	debugfs_create_ulong
	cbz	x0, .LBB6_23
// %bb.7:
	adrp	x0, .L.str.10
	add	x3, x19, #328           // =328
	add	x0, x0, :lo12:.L.str.10
	orr	w1, wzr, #0x180
	mov	x2, x20
	bl	debugfs_create_ulong
	cbz	x0, .LBB6_23
// %bb.8:
	adrp	x0, .L.str.11
	add	x3, x19, #344           // =344
	add	x0, x0, :lo12:.L.str.11
	orr	w1, wzr, #0x180
	mov	x2, x20
	bl	debugfs_create_ulong
	cbz	x0, .LBB6_23
// %bb.9:
	adrp	x0, .L.str.12
	add	x3, x19, #308           // =308
	add	x0, x0, :lo12:.L.str.12
	orr	w1, wzr, #0x180
	mov	x2, x20
	bl	debugfs_create_u32
	cbz	x0, .LBB6_23
// %bb.10:
	adrp	x0, .L.str.50
	add	x0, x0, :lo12:.L.str.50
	mov	x1, x20
	bl	debugfs_create_dir
	cmn	x0, #1, lsl #12         // =4096
	b.hi	.LBB6_23
// %bb.11:
	mov	x21, x0
	adrp	x0, .L.str.51
	add	x3, x19, #576           // =576
	add	x0, x0, :lo12:.L.str.51
	orr	w1, wzr, #0x180
	mov	x2, x21
	bl	debugfs_create_bool
	cbz	x0, .LBB6_22
// %bb.12:
	adrp	x0, .L.str.52
	add	x3, x19, #577           // =577
	add	x0, x0, :lo12:.L.str.52
	orr	w1, wzr, #0x180
	mov	x2, x21
	bl	debugfs_create_bool
	cbz	x0, .LBB6_22
// %bb.13:
	adrp	x0, .L.str.53
	add	x3, x19, #578           // =578
	add	x0, x0, :lo12:.L.str.53
	orr	w1, wzr, #0x180
	mov	x2, x21
	bl	debugfs_create_bool
	cbz	x0, .LBB6_22
// %bb.14:
	adrp	x0, .L.str.54
	add	x3, x19, #579           // =579
	add	x0, x0, :lo12:.L.str.54
	orr	w1, wzr, #0x180
	mov	x2, x21
	bl	debugfs_create_bool
	cbz	x0, .LBB6_22
// %bb.15:
	adrp	x0, .L.str.55
	add	x3, x19, #580           // =580
	add	x0, x0, :lo12:.L.str.55
	orr	w1, wzr, #0x180
	mov	x2, x21
	bl	debugfs_create_bool
	cbz	x0, .LBB6_22
// %bb.16:
	adrp	x0, .L.str.56
	add	x3, x19, #584           // =584
	add	x0, x0, :lo12:.L.str.56
	orr	w1, wzr, #0x180
	mov	x2, x21
	bl	debugfs_create_u32
	cbz	x0, .LBB6_22
// %bb.17:
	adrp	x0, .L.str.57
	add	x3, x19, #592           // =592
	add	x0, x0, :lo12:.L.str.57
	orr	w1, wzr, #0x180
	mov	x2, x21
	bl	debugfs_create_u32
	cbz	x0, .LBB6_22
// %bb.18:
	adrp	x0, .L.str.58
	add	x3, x19, #588           // =588
	add	x0, x0, :lo12:.L.str.58
	orr	w1, wzr, #0x180
	mov	x2, x21
	bl	debugfs_create_bool
	cbz	x0, .LBB6_22
// %bb.19:
	adrp	x0, .L.str.59
	add	x3, x19, #589           // =589
	add	x0, x0, :lo12:.L.str.59
	orr	w1, wzr, #0x180
	mov	x2, x21
	bl	debugfs_create_bool
	cbz	x0, .LBB6_22
// %bb.20:
	adrp	x0, .L.str.60
	add	x3, x19, #590           // =590
	add	x0, x0, :lo12:.L.str.60
	orr	w1, wzr, #0x180
	mov	x2, x21
	bl	debugfs_create_bool
	cbz	x0, .LBB6_22
// %bb.21:
	mov	w0, wzr
	str	x20, [x19, #568]
	b	.LBB6_25
.LBB6_22:
	mov	x0, x21
	bl	debugfs_remove_recursive
.LBB6_23:
	mov	x0, x20
	bl	debugfs_remove_recursive
.LBB6_24:
	mov	w0, #-19
.LBB6_25:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.Lfunc_end6:
	.size	mas_bkops_add_debugfs, .Lfunc_end6-mas_bkops_add_debugfs
                                        // -- End function
	.type	.L.str,@object          // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"\0013Invalid bkops params!\n"
	.size	.L.str, 25

	.type	.L.str.1,@object        // @.str.1
.L.str.1:
	.asciz	"\0013Failed to query bkops status!\n"
	.size	.L.str.1, 33

	.type	.L.str.2,@object        // @.str.2
.L.str.2:
	.asciz	"Failed to query bkops status!\n"
	.size	.L.str.2, 31

	.type	.L.str.3,@object        // @.str.3
.L.str.3:
	.asciz	"\0013bkops_status: %d\n"
	.size	.L.str.3, 20

	.type	.L.str.4,@object        // @.str.4
.L.str.4:
	.asciz	"bkops_status: %d\n"
	.size	.L.str.4, 18

	.type	.L.str.5,@object        // @.str.5
.L.str.5:
	.asciz	"bkops_root"
	.size	.L.str.5, 11

	.type	.L.str.6,@object        // @.str.6
.L.str.6:
	.asciz	"bkops_stat"
	.size	.L.str.6, 11

	.type	mas_bkops_stat_fops,@object // @mas_bkops_stat_fops
	.section	.rodata,"a",@progbits
	.p2align	3
mas_bkops_stat_fops:
	.xword	0
	.xword	0
	.xword	__cfi_mas_bkops_stat_read
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
	.xword	__cfi_mas_bkops_stat_open
	.xword	0
	.xword	__cfi_mas_bkops_stat_release
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
	.size	mas_bkops_stat_fops, 256

	.type	.L.str.7,@object        // @.str.7
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.7:
	.asciz	"force_bkops_query"
	.size	.L.str.7, 18

	.type	mas_bkops_force_query_fops,@object // @mas_bkops_force_query_fops
	.section	.rodata,"a",@progbits
	.p2align	3
mas_bkops_force_query_fops:
	.xword	0
	.xword	0
	.xword	__cfi_mas_bkops_force_query_read
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
	.xword	__cfi_mas_bkops_force_query_open
	.xword	0
	.xword	__cfi_mas_bkops_force_query_release
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
	.size	mas_bkops_force_query_fops, 256

	.type	.L.str.8,@object        // @.str.8
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.8:
	.asciz	"bkops_idle_delay"
	.size	.L.str.8, 17

	.type	.L.str.9,@object        // @.str.9
.L.str.9:
	.asciz	"bkops_check_interval"
	.size	.L.str.9, 21

	.type	.L.str.10,@object       // @.str.10
.L.str.10:
	.asciz	"bkops_check_discard_len"
	.size	.L.str.10, 24

	.type	.L.str.11,@object       // @.str.11
.L.str.11:
	.asciz	"bkops_check_write_len"
	.size	.L.str.11, 22

	.type	.L.str.12,@object       // @.str.12
.L.str.12:
	.asciz	"bkops_retry_en"
	.size	.L.str.12, 15

	.type	.L.str.13,@object       // @.str.13
.L.str.13:
	.asciz	"bkops retry count: %u\n"
	.size	.L.str.13, 23

	.type	.L.str.14,@object       // @.str.14
.L.str.14:
	.asciz	"bkops started count: %u\n"
	.size	.L.str.14, 25

	.type	.L.str.15,@object       // @.str.15
.L.str.15:
	.asciz	"bkops stopped count: %u\n"
	.size	.L.str.15, 25

	.type	.L.str.16,@object       // @.str.16
.L.str.16:
	.asciz	"bkops core stop count: %u\n"
	.size	.L.str.16, 27

	.type	.L.str.17,@object       // @.str.17
.L.str.17:
	.asciz	"bkops abort count: %u\n"
	.size	.L.str.17, 23

	.type	.L.str.18,@object       // @.str.18
.L.str.18:
	.asciz	"\n"
	.size	.L.str.18, 2

	.type	.L.str.19,@object       // @.str.19
.L.str.19:
	.asciz	"%s count: %u\n"
	.size	.L.str.19, 14

	.type	.L.str.20,@object       // @.str.20
.L.str.20:
	.asciz	"bkops actual query count: %u\n"
	.size	.L.str.20, 30

	.type	.L.str.21,@object       // @.str.21
.L.str.21:
	.asciz	"bkops idle work canceled count: %u\n"
	.size	.L.str.21, 36

	.type	.L.str.22,@object       // @.str.22
.L.str.22:
	.asciz	"bkops idle work waited count: %u\n"
	.size	.L.str.22, 34

	.type	.L.str.23,@object       // @.str.23
.L.str.23:
	.asciz	"bkops time based query count: %u\n"
	.size	.L.str.23, 34

	.type	.L.str.24,@object       // @.str.24
.L.str.24:
	.asciz	"bkops write based query count: %u\n"
	.size	.L.str.24, 35

	.type	.L.str.25,@object       // @.str.25
.L.str.25:
	.asciz	"bkops discard based query count: %u\n"
	.size	.L.str.25, 37

	.type	.L.str.26,@object       // @.str.26
.L.str.26:
	.asciz	"bkops query fail count: %u\n"
	.size	.L.str.26, 28

	.type	.L.str.27,@object       // @.str.27
.L.str.27:
	.asciz	"bkops start fail count: %u\n"
	.size	.L.str.27, 28

	.type	.L.str.28,@object       // @.str.28
.L.str.28:
	.asciz	"bkops stop fail count: %u\n"
	.size	.L.str.28, 27

	.type	.L.str.29,@object       // @.str.29
.L.str.29:
	.asciz	"bkops max query time: %s\n"
	.size	.L.str.29, 26

	.type	.L.str.30,@object       // @.str.30
.L.str.30:
	.asciz	"bkops average query time: %s\n"
	.size	.L.str.30, 30

	.type	.L.str.31,@object       // @.str.31
.L.str.31:
	.asciz	"bkops max start time: %s\n"
	.size	.L.str.31, 26

	.type	.L.str.32,@object       // @.str.32
.L.str.32:
	.asciz	"bkops average start time: %s\n"
	.size	.L.str.32, 30

	.type	.L.str.33,@object       // @.str.33
.L.str.33:
	.asciz	"bkops max stop time: %s\n"
	.size	.L.str.33, 25

	.type	.L.str.34,@object       // @.str.34
.L.str.34:
	.asciz	"bkops average stop time: %s\n"
	.size	.L.str.34, 29

	.type	.L.str.36,@object       // @.str.36
.L.str.36:
	.asciz	"%llu ns"
	.size	.L.str.36, 8

	.type	.L.str.37,@object       // @.str.37
.L.str.37:
	.asciz	"%llu %s"
	.size	.L.str.37, 8

	.type	time_unit,@object       // @time_unit
	.section	.rodata,"a",@progbits
	.p2align	3
time_unit:
	.xword	.L.str.38
	.xword	.L.str.39
	.xword	.L.str.40
	.xword	.L.str.41
	.size	time_unit, 32

	.type	.L.str.38,@object       // @.str.38
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.38:
	.asciz	"s"
	.size	.L.str.38, 2

	.type	.L.str.39,@object       // @.str.39
.L.str.39:
	.asciz	"ms"
	.size	.L.str.39, 3

	.type	.L.str.40,@object       // @.str.40
.L.str.40:
	.asciz	"us"
	.size	.L.str.40, 3

	.type	.L.str.41,@object       // @.str.41
.L.str.41:
	.asciz	"ns"
	.size	.L.str.41, 3

	.type	.L.str.42,@object       // @.str.42
.L.str.42:
	.asciz	"max_bkops_duration: %s\n"
	.size	.L.str.42, 24

	.type	.L.str.43,@object       // @.str.43
.L.str.43:
	.asciz	"average_bkops_duration: %s\n"
	.size	.L.str.43, 28

	.type	.L.str.44,@object       // @.str.44
.L.str.44:
	.asciz	"bkops duration less than 100ms: %u\n"
	.size	.L.str.44, 36

	.type	.L.str.45,@object       // @.str.45
.L.str.45:
	.asciz	"bkops duration less than 500ms: %u\n"
	.size	.L.str.45, 36

	.type	.L.str.46,@object       // @.str.46
.L.str.46:
	.asciz	"bkops duration less than 1000ms: %u\n"
	.size	.L.str.46, 37

	.type	.L.str.47,@object       // @.str.47
.L.str.47:
	.asciz	"bkops duration less than 2000ms: %u\n"
	.size	.L.str.47, 37

	.type	.L.str.48,@object       // @.str.48
.L.str.48:
	.asciz	"bkops duration less than 5000ms: %u\n"
	.size	.L.str.48, 37

	.type	.L.str.49,@object       // @.str.49
.L.str.49:
	.asciz	"bkops duration great than 5000ms: %u\n"
	.size	.L.str.49, 38

	.type	.L.str.50,@object       // @.str.50
.L.str.50:
	.asciz	"bkops_test_root"
	.size	.L.str.50, 16

	.type	.L.str.51,@object       // @.str.51
.L.str.51:
	.asciz	"sim_bkops_start_fail"
	.size	.L.str.51, 21

	.type	.L.str.52,@object       // @.str.52
.L.str.52:
	.asciz	"sim_bkops_stop_fail"
	.size	.L.str.52, 20

	.type	.L.str.53,@object       // @.str.53
.L.str.53:
	.asciz	"sim_bkops_query_fail"
	.size	.L.str.53, 21

	.type	.L.str.54,@object       // @.str.54
.L.str.54:
	.asciz	"sim_critical_bkops"
	.size	.L.str.54, 19

	.type	.L.str.55,@object       // @.str.55
.L.str.55:
	.asciz	"sim_bkops_abort"
	.size	.L.str.55, 16

	.type	.L.str.56,@object       // @.str.56
.L.str.56:
	.asciz	"sim_bkops_stop_delay"
	.size	.L.str.56, 21

	.type	.L.str.57,@object       // @.str.57
.L.str.57:
	.asciz	"sim_bkops_query_delay"
	.size	.L.str.57, 22

	.type	.L.str.58,@object       // @.str.58
.L.str.58:
	.asciz	"skip_bkops_stop"
	.size	.L.str.58, 16

	.type	.L.str.59,@object       // @.str.59
.L.str.59:
	.asciz	"disable_bkops"
	.size	.L.str.59, 14

	.type	.L.str.60,@object       // @.str.60
.L.str.60:
	.asciz	"bkops_force_query"
	.size	.L.str.60, 18


	.ident	"Snapdragon LLVM ARM Compiler 8.0.12 for Android NDK (based on llvm.org 7.0+)"
	.section	".note.GNU-stack","",@progbits
