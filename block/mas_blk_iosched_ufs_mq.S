	.text
	.file	"mas_blk_iosched_ufs_mq.c"
	.globl	ufs_mq_inc_vip_wait_cnt // -- Begin function ufs_mq_inc_vip_wait_cnt
	.p2align	3
	.type	ufs_mq_inc_vip_wait_cnt,@function
ufs_mq_inc_vip_wait_cnt:                // @ufs_mq_inc_vip_wait_cnt
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	x8, [x19]
	ldr	x8, [x8, #2296]
	cbz	x8, .LBB0_3
// %bb.1:
	ldr	x8, [x8, #488]
	cbz	x8, .LBB0_3
// %bb.2:
	add	x8, x8, #28             // =28
	//APP
	// atomic_add
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
.LBB0_3:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end0:
	.size	ufs_mq_inc_vip_wait_cnt, .Lfunc_end0-ufs_mq_inc_vip_wait_cnt
                                        // -- End function
	.globl	ufs_mq_dec_vip_wait_cnt // -- Begin function ufs_mq_dec_vip_wait_cnt
	.p2align	3
	.type	ufs_mq_dec_vip_wait_cnt,@function
ufs_mq_dec_vip_wait_cnt:                // @ufs_mq_dec_vip_wait_cnt
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	x8, [x19]
	ldr	x8, [x8, #2296]
	cbz	x8, .LBB1_2
// %bb.1:
	ldr	x8, [x8, #488]
.LBB1_2:
	ldr	w9, [x8, #28]
.LBB1_3:                                // =>This Inner Loop Header: Depth=1
	subs	w10, w9, #1             // =1
	b.mi	.LBB1_5
// %bb.4:                               //   in Loop: Header=BB1_3 Depth=1
	add	x12, x8, #28            // =28
	sxtw	x11, w9
	sxtw	x10, w10
	//APP
		prfm	pstl1strm, [x12]
1:	ldxr	w14, [x12]
	eor	w13, w14, w11
	cbnz	w13, 2f
	stlxr	w13, w10, [x12]
	cbnz	w13, 1b
	dmb ish
2:
	//NO_APP
	cmp	w9, w14
	mov	w9, w14
	b.ne	.LBB1_3
.LBB1_5:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end1:
	.size	ufs_mq_dec_vip_wait_cnt, .Lfunc_end1-ufs_mq_dec_vip_wait_cnt
                                        // -- End function
	.globl	reset_vip_wait_cnt      // -- Begin function reset_vip_wait_cnt
	.p2align	3
	.type	reset_vip_wait_cnt,@function
reset_vip_wait_cnt:                     // @reset_vip_wait_cnt
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	x8, [x19]
	ldr	x8, [x8, #2296]
	cbz	x8, .LBB2_2
// %bb.1:
	ldr	x8, [x8, #488]
.LBB2_2:
	ldr	w9, [x8, #24]
	cbnz	w9, .LBB2_4
// %bb.3:
	str	wzr, [x8, #28]
.LBB2_4:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end2:
	.size	reset_vip_wait_cnt, .Lfunc_end2-reset_vip_wait_cnt
                                        // -- End function
	.globl	ufs_mq_vip_tag_wait_cnt // -- Begin function ufs_mq_vip_tag_wait_cnt
	.p2align	3
	.type	ufs_mq_vip_tag_wait_cnt,@function
ufs_mq_vip_tag_wait_cnt:                // @ufs_mq_vip_tag_wait_cnt
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	x8, [x19]
	ldr	x8, [x8, #2296]
	cbz	x8, .LBB3_2
// %bb.1:
	ldr	x8, [x8, #488]
.LBB3_2:
	ldr	w0, [x8, #28]
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end3:
	.size	ufs_mq_vip_tag_wait_cnt, .Lfunc_end3-ufs_mq_vip_tag_wait_cnt
                                        // -- End function
	.globl	get_mq_all_tag_used     // -- Begin function get_mq_all_tag_used
	.p2align	3
	.type	get_mq_all_tag_used,@function
get_mq_all_tag_used:                    // @get_mq_all_tag_used
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	cbz	x19, .LBB4_4
// %bb.1:
	mov	x0, x19
	bl	mas_blk_get_lld
	cbz	x0, .LBB4_5
// %bb.2:
	ldr	x8, [x0, #1512]
	cbz	x8, .LBB4_4
// %bb.3:
	ldr	w9, [x8, #24]
	ldr	w10, [x8, #16]
	ldr	w8, [x8, #20]
	add	w9, w10, w9
	add	w0, w9, w8
	b	.LBB4_5
.LBB4_4:
	mov	w0, wzr
.LBB4_5:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end4:
	.size	get_mq_all_tag_used, .Lfunc_end4-get_mq_all_tag_used
                                        // -- End function
	.globl	get_mq_prio_tag_used    // -- Begin function get_mq_prio_tag_used
	.p2align	3
	.type	get_mq_prio_tag_used,@function
get_mq_prio_tag_used:                   // @get_mq_prio_tag_used
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	cbz	x19, .LBB5_4
// %bb.1:
	mov	x0, x19
	bl	mas_blk_get_lld
	cbz	x0, .LBB5_5
// %bb.2:
	ldr	x8, [x0, #1512]
	cbz	x8, .LBB5_4
// %bb.3:
	ldr	w0, [x8, #24]
	b	.LBB5_5
.LBB5_4:
	mov	w0, wzr
.LBB5_5:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end5:
	.size	get_mq_prio_tag_used, .Lfunc_end5-get_mq_prio_tag_used
                                        // -- End function
	.globl	ufs_mq_tag_get          // -- Begin function ufs_mq_tag_get
	.p2align	3
	.type	ufs_mq_tag_get,@function
ufs_mq_tag_get:                         // @ufs_mq_tag_get
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	x9, [x19, #16]
	mov	w10, #4096
	movk	w10, #32, lsl #16
	add	x8, x10, #2048          // =2048
	and	x8, x9, x8
	cmp	x8, #2048               // =2048
	b.ne	.LBB6_6
// %bb.1:
	ldr	x2, [x19, #56]
	mov	x0, x19
	ldr	x8, [x2, #560]
	add	x1, x8, #40             // =40
	bl	ufs_tagset_bt_get
	cmn	w0, #1                  // =1
	b.eq	.LBB6_5
// %bb.2:
	ldr	x8, [x19]
	ldr	x8, [x8, #2296]
	cbz	x8, .LBB6_4
// %bb.3:
	ldr	x8, [x8, #488]
.LBB6_4:
	add	x8, x8, #16             // =16
	//APP
	// atomic_add
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
.LBB6_5:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.LBB6_6:
	ldr	x2, [x19, #56]
	tst	x9, x10
	ldr	x8, [x2, #560]
	b.eq	.LBB6_12
// %bb.7:
	ldr	w9, [x8, #8]
	cbz	w9, .LBB6_18
// %bb.8:
	add	x1, x8, #152            // =152
	mov	x0, x19
	bl	ufs_tagset_bt_get
	cmn	w0, #1                  // =1
	b.eq	.LBB6_5
// %bb.9:
	ldr	x8, [x19]
	ldr	x8, [x8, #2296]
	cbz	x8, .LBB6_11
// %bb.10:
	ldr	x8, [x8, #488]
.LBB6_11:
	add	x8, x8, #24             // =24
	//APP
	// atomic_add
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	ldr	x8, [x19, #56]
	ldr	x8, [x8, #560]
	ldr	w8, [x8, #20]
	b	.LBB6_17
.LBB6_12:
	ldr	w9, [x8, #4]
	cbz	w9, .LBB6_19
// %bb.13:
	add	x1, x8, #96             // =96
	mov	x0, x19
	bl	ufs_tagset_bt_get
	cmn	w0, #1                  // =1
	b.eq	.LBB6_5
// %bb.14:
	ldr	x8, [x19]
	ldr	x8, [x8, #2296]
	cbz	x8, .LBB6_16
// %bb.15:
	ldr	x8, [x8, #488]
.LBB6_16:
	add	x8, x8, #20             // =20
	//APP
	// atomic_add
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	ldr	x8, [x19, #56]
	ldr	x8, [x8, #560]
	ldr	w8, [x8, #16]
.LBB6_17:
	add	w0, w8, w0
	b	.LBB6_5
.LBB6_18:
	adrp	x0, .L.str.31
	adrp	x1, .L.str.19
	add	x0, x0, :lo12:.L.str.31
	add	x1, x1, :lo12:.L.str.19
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.LBB6_19:
	adrp	x0, .L.str.31
	adrp	x1, .L.str.20
	add	x0, x0, :lo12:.L.str.31
	add	x1, x1, :lo12:.L.str.20
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.Lfunc_end6:
	.size	ufs_mq_tag_get, .Lfunc_end6-ufs_mq_tag_get
                                        // -- End function
	.globl	ufs_mq_tag_put          // -- Begin function ufs_mq_tag_put
	.p2align	3
	.type	ufs_mq_tag_put,@function
ufs_mq_tag_put:                         // @ufs_mq_tag_put
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x21, x2
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	w20, w1
	mov	x19, x0
	bl	_mcount
	ldr	x8, [x19, #560]
	ldr	w9, [x8, #20]
	cmp	w9, w20
	b.ls	.LBB7_6
// %bb.1:
	ldr	w9, [x8, #16]
	cmp	w9, w20
	b.ls	.LBB7_9
// %bb.2:
	ldr	x9, [x21, #256]
	add	x0, x8, #40             // =40
	mov	w1, w20
	ldr	w2, [x9, #128]
	bl	sbitmap_queue_clear
	ldr	x8, [x19, #360]
	ldr	x8, [x8, #2296]
	cbz	x8, .LBB7_4
// %bb.3:
	ldr	x8, [x8, #488]
.LBB7_4:
	add	x8, x8, #16             // =16
	//APP
	// atomic_sub
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	sub	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
.LBB7_5:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	mov	w0, wzr
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.LBB7_6:
	ldr	x10, [x21, #256]
	add	x0, x8, #152            // =152
	sub	w1, w20, w9
	ldr	w2, [x10, #128]
	bl	sbitmap_queue_clear
	ldr	x8, [x19, #360]
	ldr	x8, [x8, #2296]
	cbz	x8, .LBB7_8
// %bb.7:
	ldr	x8, [x8, #488]
.LBB7_8:
	add	x8, x8, #24             // =24
	//APP
	// atomic_sub
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	sub	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	b	.LBB7_5
.LBB7_9:
	ldr	x10, [x21, #256]
	add	x0, x8, #96             // =96
	sub	w1, w20, w9
	ldr	w2, [x10, #128]
	bl	sbitmap_queue_clear
	ldr	x8, [x19, #360]
	ldr	x8, [x8, #2296]
	cbz	x8, .LBB7_11
// %bb.10:
	ldr	x8, [x8, #488]
.LBB7_11:
	add	x8, x8, #20             // =20
	//APP
	// atomic_sub
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	sub	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	b	.LBB7_5
.Lfunc_end7:
	.size	ufs_mq_tag_put, .Lfunc_end7-ufs_mq_tag_put
                                        // -- End function
	.globl	ufs_mq_sync_burst_check_timer_expire // -- Begin function ufs_mq_sync_burst_check_timer_expire
	.p2align	3
	.type	ufs_mq_sync_burst_check_timer_expire,@function
ufs_mq_sync_burst_check_timer_expire:   // @ufs_mq_sync_burst_check_timer_expire
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	bl	ktime_get
	ldr	w8, [x19, #432]
	sub	w8, w8, #1              // =1
	cmp	w8, #1                  // =1
	b.hi	.LBB8_3
// %bb.1:
	ldr	x8, [x19, #304]
	mov	w9, #25856
	movk	w9, #7629, lsl #16
	add	x8, x8, x9
	cmp	x8, x0
	b.ge	.LBB8_3
// %bb.2:
	orr	w8, wzr, #0x3
	str	w8, [x19, #432]
.LBB8_3:
	ldr	x8, [x19, #296]
	mov	w20, #19264
	movk	w20, #76, lsl #16
	add	x8, x8, x20
	cmp	x8, x0
	b.le	.LBB8_7
// %bb.4:
	ldr	w8, [x19, #432]
	cmp	w8, #3                  // =3
	b.eq	.LBB8_12
// %bb.5:
	cmp	w8, #1                  // =1
	b.ne	.LBB8_16
// %bb.6:
	orr	w8, wzr, #0x2
	b	.LBB8_15
.LBB8_7:
	bl	ktime_get
	ldr	w8, [x19, #432]
	cmp	w8, #3                  // =3
	b.eq	.LBB8_10
// %bb.8:
	cmp	w8, #2                  // =2
	b.eq	.LBB8_13
// %bb.9:
	cmp	w8, #1                  // =1
	b.ne	.LBB8_16
.LBB8_10:
	ldr	x8, [x19, #312]
	add	x8, x8, x20
	cmp	x8, x0
	b.ge	.LBB8_16
// %bb.11:
	str	wzr, [x19, #432]
	b	.LBB8_17
.LBB8_12:
	ldr	w8, [x19, #20]
	cbnz	w8, .LBB8_16
	b	.LBB8_14
.LBB8_13:
	ldr	x8, [x19, #296]
	add	x8, x8, x20
	cmp	x8, x0
	b.ge	.LBB8_16
.LBB8_14:
	orr	w8, wzr, #0x1
.LBB8_15:
	str	w8, [x19, #432]
.LBB8_16:
	adrp	x8, jiffies
	add	x0, x19, #336           // =336
	ldr	x8, [x8, :lo12:jiffies]
	add	x1, x8, #2              // =2
	bl	mod_timer
.LBB8_17:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end8:
	.size	ufs_mq_sync_burst_check_timer_expire, .Lfunc_end8-ufs_mq_sync_burst_check_timer_expire
                                        // -- End function
	.globl	ufs_mq_dump_request     // -- Begin function ufs_mq_dump_request
	.p2align	3
	.type	ufs_mq_dump_request,@function
ufs_mq_dump_request:                    // @ufs_mq_dump_request
// %bb.0:
	stp	x24, x23, [sp, #-64]!   // 16-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	w19, w1
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	mov	x20, x0
	bl	_mcount
	ldr	x21, [x20, #2296]
	cbz	x21, .LBB9_5
// %bb.1:
	ldr	x22, [x21, #488]
	cbz	x22, .LBB9_5
// %bb.2:
	mov	x23, x22
	ldr	x8, [x23, #128]!
	cmp	x23, x8
	b.ne	.LBB9_6
.LBB9_3:
	mov	x23, x22
	ldr	x8, [x23, #152]!
	cmp	x23, x8
	b.ne	.LBB9_10
.LBB9_4:
	ldr	x8, [x22, #264]
	add	x22, x22, #264          // =264
	cmp	x22, x8
	b.ne	.LBB9_14
.LBB9_5:
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldp	x24, x23, [sp], #64     // 16-byte Folded Reload
	ret
.LBB9_6:
	adrp	x0, .L.str
	add	x0, x0, :lo12:.L.str
	bl	printk
	ldr	x24, [x23]
	cmp	x23, x24
	b.ne	.LBB9_8
	b	.LBB9_3
.LBB9_7:                                //   in Loop: Header=BB9_8 Depth=1
	ldr	x24, [x24]
	cmp	x23, x24
	b.eq	.LBB9_3
.LBB9_8:                                // =>This Inner Loop Header: Depth=1
	mov	x0, x24
	ldr	x8, [x0, #-80]!
	cmp	x8, x20
	b.ne	.LBB9_7
// %bb.9:                               //   in Loop: Header=BB9_8 Depth=1
	mov	w1, w19
	bl	mas_blk_dump_request
	b	.LBB9_7
.LBB9_10:
	adrp	x0, .L.str.1
	add	x0, x0, :lo12:.L.str.1
	bl	printk
	ldr	x24, [x23]
	cmp	x23, x24
	b.ne	.LBB9_12
	b	.LBB9_18
.LBB9_11:                               //   in Loop: Header=BB9_12 Depth=1
	ldr	x24, [x24]
	cmp	x23, x24
	b.eq	.LBB9_18
.LBB9_12:                               // =>This Inner Loop Header: Depth=1
	mov	x0, x24
	ldr	x8, [x0, #-80]!
	cmp	x8, x20
	b.ne	.LBB9_11
// %bb.13:                              //   in Loop: Header=BB9_12 Depth=1
	mov	w1, w19
	bl	mas_blk_dump_request
	b	.LBB9_11
.LBB9_14:
	adrp	x0, .L.str.2
	add	x0, x0, :lo12:.L.str.2
	bl	printk
	ldr	x23, [x22]
	cmp	x22, x23
	b.ne	.LBB9_16
	b	.LBB9_19
.LBB9_15:                               //   in Loop: Header=BB9_16 Depth=1
	ldr	x23, [x23]
	cmp	x22, x23
	b.eq	.LBB9_19
.LBB9_16:                               // =>This Inner Loop Header: Depth=1
	sub	x0, x23, #424           // =424
	ldr	x8, [x0]
	cmp	x8, x20
	b.ne	.LBB9_15
// %bb.17:                              //   in Loop: Header=BB9_16 Depth=1
	mov	w1, w19
	bl	mas_blk_dump_request
	b	.LBB9_15
.LBB9_18:
	ldp	x1, x2, [x21, #8]
	ldr	x3, [x21, #24]
	adrp	x0, .L.str.22
	add	x0, x0, :lo12:.L.str.22
	bl	printk
	b	.LBB9_4
.LBB9_19:
	ldp	x1, x2, [x21, #240]
	ldr	x3, [x21, #256]
	adrp	x0, .L.str.22
	add	x0, x0, :lo12:.L.str.22
	bl	printk
	b	.LBB9_5
.Lfunc_end9:
	.size	ufs_mq_dump_request, .Lfunc_end9-ufs_mq_dump_request
                                        // -- End function
	.globl	mas_queue_cp_enabled_show // -- Begin function mas_queue_cp_enabled_show
	.p2align	3
	.type	mas_queue_cp_enabled_show,@function
mas_queue_cp_enabled_show:              // @mas_queue_cp_enabled_show
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	mov	x0, x20
	bl	mas_blk_get_lld
	ldr	w8, [x0, #24]
	adrp	x2, .L.str.3
	add	x2, x2, :lo12:.L.str.3
	orr	w1, wzr, #0x1000
	mov	x0, x19
	ubfx	w3, w8, #7, #1
	bl	snprintf
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
                                        // kill: def $w0 killed $w0 def $x0
	sxtw	x0, w0
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end10:
	.size	mas_queue_cp_enabled_show, .Lfunc_end10-mas_queue_cp_enabled_show
                                        // -- End function
	.globl	mas_queue_cp_enabled_store // -- Begin function mas_queue_cp_enabled_store
	.p2align	3
	.type	mas_queue_cp_enabled_store,@function
mas_queue_cp_enabled_store:             // @mas_queue_cp_enabled_store
// %bb.0:
	sub	sp, sp, #64             // =64
	adrp	x8, __stack_chk_guard
	str	x21, [sp, #16]          // 8-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	x20, x2
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	mov	x21, x1
	mov	x19, x0
	str	x8, [sp, #8]
	bl	_mcount
	mov	x0, x19
	bl	mas_blk_get_lld
	mov	x19, x0
	mov	x0, sp
	mov	x1, x21
	mov	x2, x20
	bl	queue_var_store
	tbnz	x0, #63, .LBB11_2
// %bb.1:
	ldr	x8, [x19, #24]
	ldr	x9, [sp]
	orr	x10, x8, #0x80
	and	x8, x8, #0xffffffffffffff7f
	cmp	x9, #0                  // =0
	csel	x8, x8, x10, eq
	str	x8, [x19, #24]
.LBB11_2:
	adrp	x9, __stack_chk_guard
	ldr	x8, [sp, #8]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB11_4
// %bb.3:
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldr	x21, [sp, #16]          // 8-byte Folded Reload
	add	sp, sp, #64             // =64
	ret
.LBB11_4:
	bl	__stack_chk_fail
.Lfunc_end11:
	.size	mas_queue_cp_enabled_store, .Lfunc_end11-mas_queue_cp_enabled_store
                                        // -- End function
	.globl	mas_blk_cp_debug_en     // -- Begin function mas_blk_cp_debug_en
	.p2align	3
	.type	mas_blk_cp_debug_en,@function
mas_blk_cp_debug_en:                    // @mas_blk_cp_debug_en
// %bb.0:
	stp	x29, x30, [sp, #-16]!   // 16-byte Folded Spill
	mov	x29, sp
	bl	_mcount
	adrp	x8, cp_debug_en
	ldr	w0, [x8, :lo12:cp_debug_en]
	ldp	x29, x30, [sp], #16     // 16-byte Folded Reload
	ret
.Lfunc_end12:
	.size	mas_blk_cp_debug_en, .Lfunc_end12-mas_blk_cp_debug_en
                                        // -- End function
	.globl	mas_queue_cp_debug_en_show // -- Begin function mas_queue_cp_debug_en_show
	.p2align	3
	.type	mas_queue_cp_debug_en_show,@function
mas_queue_cp_debug_en_show:             // @mas_queue_cp_debug_en_show
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	bl	_mcount
	adrp	x8, cp_debug_en
	adrp	x2, .L.str.4
	add	x2, x2, :lo12:.L.str.4
	ldr	w3, [x8, :lo12:cp_debug_en]
	orr	w1, wzr, #0x1000
	mov	x0, x19
	bl	snprintf
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
                                        // kill: def $w0 killed $w0 def $x0
	sxtw	x0, w0
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end13:
	.size	mas_queue_cp_debug_en_show, .Lfunc_end13-mas_queue_cp_debug_en_show
                                        // -- End function
	.globl	mas_queue_cp_debug_en_store // -- Begin function mas_queue_cp_debug_en_store
	.p2align	3
	.type	mas_queue_cp_debug_en_store,@function
mas_queue_cp_debug_en_store:            // @mas_queue_cp_debug_en_store
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
	mov	x0, sp
	mov	x1, x20
	mov	x2, x19
	bl	queue_var_store
	ldr	w8, [sp]
	asr	x9, x0, #63
	bic	w8, w8, w9
	adrp	x9, cp_debug_en
	str	w8, [x9, :lo12:cp_debug_en]
	adrp	x9, __stack_chk_guard
	ldr	x8, [sp, #8]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB14_2
// %bb.1:
	mov	x0, x19
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	add	sp, sp, #48             // =48
	ret
.LBB14_2:
	bl	__stack_chk_fail
.Lfunc_end14:
	.size	mas_queue_cp_debug_en_store, .Lfunc_end14-mas_queue_cp_debug_en_store
                                        // -- End function
	.globl	mas_queue_cp_limit_show // -- Begin function mas_queue_cp_limit_show
	.p2align	3
	.type	mas_queue_cp_limit_show,@function
mas_queue_cp_limit_show:                // @mas_queue_cp_limit_show
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	ldr	x8, [x20, #2296]
	cbz	x8, .LBB15_3
// %bb.1:
	ldr	x8, [x8, #488]
	cbz	x8, .LBB15_3
// %bb.2:
	ldr	w3, [x8, #8]
	b	.LBB15_4
.LBB15_3:
	mov	w3, wzr
.LBB15_4:
	adrp	x2, .L.str.5
	add	x2, x2, :lo12:.L.str.5
	orr	w1, wzr, #0x1000
	mov	x0, x19
	bl	snprintf
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
                                        // kill: def $w0 killed $w0 def $x0
	sxtw	x0, w0
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end15:
	.size	mas_queue_cp_limit_show, .Lfunc_end15-mas_queue_cp_limit_show
                                        // -- End function
	.globl	mas_queue_cp_limit_store // -- Begin function mas_queue_cp_limit_store
	.p2align	3
	.type	mas_queue_cp_limit_store,@function
mas_queue_cp_limit_store:               // @mas_queue_cp_limit_store
// %bb.0:
	sub	sp, sp, #64             // =64
	adrp	x8, __stack_chk_guard
	str	x21, [sp, #16]          // 8-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	x19, x2
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	mov	x20, x1
	mov	x21, x0
	str	x8, [sp, #8]
	bl	_mcount
	ldr	x8, [x21, #2296]
	cbz	x8, .LBB16_2
// %bb.1:
	ldr	x21, [x8, #488]
	b	.LBB16_3
.LBB16_2:
	mov	x21, xzr
.LBB16_3:
	mov	x0, sp
	mov	x1, x20
	mov	x2, x19
	bl	queue_var_store
	cbz	x21, .LBB16_6
// %bb.4:
	tbnz	x0, #63, .LBB16_6
// %bb.5:
	ldr	x8, [sp]
	str	w8, [x21, #8]
.LBB16_6:
	adrp	x9, __stack_chk_guard
	ldr	x8, [sp, #8]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB16_8
// %bb.7:
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldr	x21, [sp, #16]          // 8-byte Folded Reload
	add	sp, sp, #64             // =64
	ret
.LBB16_8:
	bl	__stack_chk_fail
.Lfunc_end16:
	.size	mas_queue_cp_limit_store, .Lfunc_end16-mas_queue_cp_limit_store
                                        // -- End function
	.globl	ufs_mq_flush_plug_list  // -- Begin function ufs_mq_flush_plug_list
	.p2align	3
	.type	ufs_mq_flush_plug_list,@function
ufs_mq_flush_plug_list:                 // @ufs_mq_flush_plug_list
// %bb.0:
	sub	sp, sp, #144            // =144
	adrp	x8, __stack_chk_guard
	str	x27, [sp, #48]          // 8-byte Folded Spill
	stp	x26, x25, [sp, #64]     // 16-byte Folded Spill
	stp	x24, x23, [sp, #80]     // 16-byte Folded Spill
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	stp	x22, x21, [sp, #96]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #112]    // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #128]    // 16-byte Folded Spill
	add	x29, sp, #128           // =128
	str	x8, [sp, #40]
	bl	_mcount
	adrp	x8, .Lufs_mq_flush_plug_list.bd
	add	x8, x8, :lo12:.Lufs_mq_flush_plug_list.bd
	add	x23, sp, #8             // =8
	ldp	x10, x9, [x8]
	mov	x8, x19
	stp	x23, x23, [sp, #8]
	stp	x10, x9, [sp, #24]
	ldr	x9, [x8, #48]!
	cmp	x8, x9
	b.eq	.LBB17_2
// %bb.1:
	ldr	x10, [x19, #56]
	str	x23, [x9, #8]
	str	x9, [sp, #8]
	str	x23, [x10]
	str	x10, [sp, #16]
	str	x8, [x19, #48]
	ldr	x22, [sp, #8]
	str	x8, [x19, #56]
	b	.LBB17_3
.LBB17_2:
	add	x22, sp, #8             // =8
.LBB17_3:
	adrp	x25, __per_cpu_offset
	//APP
	mrs x26, sp_el0
	//NO_APP
	adrp	x24, mas_blk_mq_sync_disp_wq
	mov	w19, #10
	add	x25, x25, :lo12:__per_cpu_offset
	b	.LBB17_8
.LBB17_4:                               //   in Loop: Header=BB17_8 Depth=1
	bl	preempt_schedule
	cbz	w22, .LBB17_16
.LBB17_5:                               //   in Loop: Header=BB17_8 Depth=1
	cmp	w22, #9                 // =9
	b.ne	.LBB17_7
// %bb.6:                               //   in Loop: Header=BB17_8 Depth=1
	mov	x0, x21
	bl	__blk_mq_requeue_request
	mov	x0, x21
	mov	x1, x20
	bl	ufs_mq_insert_sync_list
	ldr	x20, [x20, #2296]
	orr	w0, wzr, #0x8
	ldr	x1, [x24, :lo12:mas_blk_mq_sync_disp_wq]
	mov	x3, xzr
	add	x2, x20, #32            // =32
	bl	queue_delayed_work_on
	bl	ktime_get
	str	x0, [x20, #8]
	b	.LBB17_16
.LBB17_7:                               //   in Loop: Header=BB17_8 Depth=1
	mov	x0, x21
	mov	w1, w19
	bl	blk_mq_end_request
	b	.LBB17_16
.LBB17_8:                               // =>This Inner Loop Header: Depth=1
	mov	x21, x22
	mov	x0, x22
	ldr	x20, [x21, #-80]!
	ldr	x27, [x20, #2296]
	bl	__list_del_entry_valid
	tbz	w0, #0, .LBB17_10
// %bb.9:                               //   in Loop: Header=BB17_8 Depth=1
	ldp	x8, x9, [x22]
	str	x9, [x8, #8]
	str	x8, [x9]
.LBB17_10:                              //   in Loop: Header=BB17_8 Depth=1
	orr	w0, wzr, #0x1
	str	x22, [x22]
	str	x22, [x22, #8]
	str	x21, [sp, #24]
	bl	preempt_count_add
	//APP
	//NO_APP
	bl	debug_smp_processor_id
	ldr	x8, [x20, #416]
	add	x3, sp, #24             // =24
	ldr	x9, [x25, w0, uxtw #3]
	mov	x0, x21
	mov	x4, x20
	add	x8, x9, x8
	stur	x8, [x22, #-72]
	ldrsw	x8, [x8, #128]
	ldr	x9, [x20, #408]
	ldr	x10, [x20, #432]
	ldr	x2, [x27, #488]
	ldr	w8, [x9, x8, lsl #2]
	ldr	x1, [x10, x8, lsl #3]
	bl	__ufs_mq_queue_rq
	ldur	x8, [x22, #-72]
	mov	w22, w0
	ldr	x8, [x8, #208]
	ldr	x8, [x8, #2304]
	cbz	x8, .LBB17_13
// %bb.11:                              //   in Loop: Header=BB17_8 Depth=1
	ldr	x8, [x8, #80]
	cbz	x8, .LBB17_13
// %bb.12:                              //   in Loop: Header=BB17_8 Depth=1
	blr	x8
	cbz	w22, .LBB17_16
	b	.LBB17_5
.LBB17_13:                              //   in Loop: Header=BB17_8 Depth=1
	orr	w0, wzr, #0x1
	//APP
	//NO_APP
	bl	preempt_count_sub
	ldr	w8, [x26, #72]
	cbnz	w8, .LBB17_15
// %bb.14:                              //   in Loop: Header=BB17_8 Depth=1
	ldr	x8, [x26]
	tbnz	w8, #1, .LBB17_4
.LBB17_15:                              //   in Loop: Header=BB17_8 Depth=1
	cbnz	w22, .LBB17_5
.LBB17_16:                              //   in Loop: Header=BB17_8 Depth=1
	ldr	x22, [sp, #8]
	cmp	x23, x22
	b.ne	.LBB17_8
// %bb.17:
	adrp	x9, __stack_chk_guard
	ldr	x8, [sp, #40]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB17_19
// %bb.18:
	ldp	x29, x30, [sp, #128]    // 16-byte Folded Reload
	ldp	x20, x19, [sp, #112]    // 16-byte Folded Reload
	ldp	x22, x21, [sp, #96]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #80]     // 16-byte Folded Reload
	ldp	x26, x25, [sp, #64]     // 16-byte Folded Reload
	ldr	x27, [sp, #48]          // 8-byte Folded Reload
	add	sp, sp, #144            // =144
	ret
.LBB17_19:
	bl	__stack_chk_fail
.Lfunc_end17:
	.size	ufs_mq_flush_plug_list, .Lfunc_end17-ufs_mq_flush_plug_list
                                        // -- End function
	.p2align	3               // -- Begin function __ufs_mq_queue_rq
	.type	__ufs_mq_queue_rq,@function
__ufs_mq_queue_rq:                      // @__ufs_mq_queue_rq
// %bb.0:
	stp	x26, x25, [sp, #-80]!   // 16-byte Folded Spill
	stp	x24, x23, [sp, #16]     // 16-byte Folded Spill
	mov	x23, x4
	stp	x22, x21, [sp, #32]     // 16-byte Folded Spill
	mov	x21, x3
	stp	x20, x19, [sp, #48]     // 16-byte Folded Spill
	mov	x19, x2
	stp	x29, x30, [sp, #64]     // 16-byte Folded Spill
	add	x29, sp, #64            // =64
	mov	x22, x1
	mov	x20, x0
	bl	_mcount
	ldr	w8, [x20, #20]
	tbz	w8, #11, .LBB18_18
// %bb.1:
	mov	w9, #4096
	movk	w9, #32, lsl #16
	tst	w8, w9
	b.ne	.LBB18_21
// %bb.2:
	add	x8, x19, #32            // =32
	//APP
	// atomic_add_return
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stlxr	w10, w9, [x8]
	cbnz	w10, 1b
	dmb ish
	//NO_APP
	ldr	w8, [x19, #284]
	cmp	w9, w8
	b.le	.LBB18_4
// %bb.3:
	ldrb	w8, [x19, #920]
	cmp	w8, #1                  // =1
	b.ne	.LBB18_20
.LBB18_4:
	ldrb	w8, [x19, #616]
	cbnz	w8, .LBB18_9
// %bb.5:
	ldr	x0, [x20]
	bl	mas_blk_get_lld
	ldrsb	w8, [x0, #24]
	tbz	w8, #31, .LBB18_9
// %bb.6:
	ldr	w8, [x20, #20]
	tst	w8, #0xff
	b.ne	.LBB18_9
// %bb.7:
	ldr	x9, [x20, #240]
	tbnz	w9, #1, .LBB18_51
// %bb.8:
	orr	x9, x9, #0x2
	orr	w8, w8, #0x800000
	add	x10, x19, #12           // =12
	adrp	x11, cp_debug_en
	str	x9, [x20, #240]
	str	w8, [x20, #20]
	//APP
	// atomic_add
	prfm	pstl1strm, [x10]
1:	ldxr	w8, [x10]
	add	w8, w8, #1
	stxr	w9, w8, [x10]
	cbnz	w9, 1b
	//NO_APP
	ldr	w8, [x11, :lo12:cp_debug_en]
	cbnz	w8, .LBB18_31
.LBB18_9:
	ldr	x8, [x22, #360]
	ldr	x8, [x8, #400]
	ldr	x8, [x8, #8]
	cbz	x8, .LBB18_11
// %bb.10:
	mov	x0, x22
	blr	x8
	tbz	w0, #0, .LBB18_12
.LBB18_11:
	ldr	x8, [x23, #400]
	mov	x0, x22
	mov	x1, x21
	ldr	x8, [x8]
	blr	x8
	ldr	x8, [x21]
	mov	w21, w0
	mov	w1, #10
	mov	x0, x8
	bl	mas_blk_latency_req_check
	ands	w21, w21, #0xff
	b.eq	.LBB18_17
	b	.LBB18_13
.LBB18_12:
	mov	w21, #9
.LBB18_13:
	orr	w8, wzr, #0x1
	str	w8, [x20, #252]
	ldr	w8, [x19, #44]
	ldr	w9, [x19, #40]
	ldr	w10, [x19, #32]
	ldr	w11, [x19, #36]
	add	w8, w9, w8
	add	w8, w8, w10
	add	w8, w8, w11
	cmp	w8, #8                  // =8
	b.gt	.LBB18_16
// %bb.14:
	orr	w8, wzr, #0x4
.LBB18_15:
	str	w8, [x20, #252]
.LBB18_16:
	mov	x0, x20
	mov	x1, x19
	mov	w2, wzr
	bl	ufs_mq_rq_inflt_update
.LBB18_17:
	mov	w0, w21
	ldp	x29, x30, [sp, #64]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]     // 16-byte Folded Reload
	ldp	x26, x25, [sp], #80     // 16-byte Folded Reload
	ret
.LBB18_18:
	add	x8, x19, #36            // =36
	//APP
	// atomic_add_return
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stlxr	w10, w9, [x8]
	cbnz	w10, 1b
	dmb ish
	//NO_APP
	ldr	w8, [x19, #288]
	cmp	w9, w8
	b.le	.LBB18_9
// %bb.19:
	ldrb	w8, [x19, #920]
	cmp	w8, #1                  // =1
	b.eq	.LBB18_9
.LBB18_20:
	orr	w8, wzr, #0x2
	mov	w21, #9
	b	.LBB18_15
.LBB18_21:
	mov	w25, #4096
	movk	w25, #32, lsl #16
	tbnz	w8, #24, .LBB18_24
// %bb.22:
	and	x8, x8, x25
	cbz	x8, .LBB18_24
// %bb.23:
	add	x8, x19, #44            // =44
	//APP
	// atomic_add
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	b	.LBB18_25
.LBB18_24:
	add	x8, x19, #40            // =40
	//APP
	// atomic_add
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
.LBB18_25:
	ldr	x0, [x20]
	bl	mas_blk_get_lld
	ldrsb	w8, [x0, #24]
	tbz	w8, #31, .LBB18_9
// %bb.26:
	ldrb	w8, [x19, #920]
	cbnz	w8, .LBB18_9
// %bb.27:
	ldr	x0, [x20]
	bl	mas_blk_get_lld
	ldr	w8, [x20, #20]
	mov	x24, x0
	tbz	w8, #24, .LBB18_34
// %bb.28:
	and	w9, w8, #0xff
	cmp	w9, #1                  // =1
	b.eq	.LBB18_34
.LBB18_29:
	ldr	x8, [x20, #240]
	tbnz	w8, #1, .LBB18_52
// %bb.30:
	ldr	w9, [x20, #20]
	orr	x8, x8, #0x2
	add	x10, x19, #12           // =12
	str	x8, [x20, #240]
	adrp	x8, cp_debug_en
	orr	w9, w9, #0x800000
	str	w9, [x20, #20]
	//APP
	// atomic_add
	prfm	pstl1strm, [x10]
1:	ldxr	w9, [x10]
	add	w9, w9, #1
	stxr	w11, w9, [x10]
	cbnz	w11, 1b
	//NO_APP
	ldr	w8, [x8, :lo12:cp_debug_en]
	cbz	w8, .LBB18_9
.LBB18_31:
	adrp	x0, .L.str.26
	add	x1, x20, #224           // =224
	add	x0, x0, :lo12:.L.str.26
	bl	printk
	ldr	x8, [x20]
	ldr	x8, [x8, #2296]
	cbz	x8, .LBB18_9
// %bb.32:
	ldr	x25, [x8, #488]
	cbz	x25, .LBB18_9
// %bb.33:
	adrp	x24, .L.str.38
	ldr	w2, [x25, #28]
	adrp	x0, .L.str.8
	add	x24, x24, :lo12:.L.str.38
	add	x0, x0, :lo12:.L.str.8
	mov	x1, x24
	bl	printk
	ldr	w2, [x25, #24]
	adrp	x0, .L.str.9
	ldr	w3, [x25, #16]
	add	x0, x0, :lo12:.L.str.9
	ldr	w4, [x25, #20]
	mov	x1, x24
	bl	printk
	ldr	w2, [x25, #44]
	adrp	x0, .L.str.10
	ldr	w3, [x25, #40]
	add	x0, x0, :lo12:.L.str.10
	ldr	w4, [x25, #32]
	mov	x1, x24
	ldr	w5, [x25, #36]
	ldr	w6, [x25, #12]
	bl	printk
	b	.LBB18_9
.LBB18_34:
	tbnz	w8, #24, .LBB18_37
// %bb.35:
	and	x8, x8, x25
	cbz	x8, .LBB18_37
// %bb.36:
	ldr	w8, [x19, #40]
	cmp	w8, #2                  // =2
	b.gt	.LBB18_9
.LBB18_37:
	ldr	w8, [x19, #32]
	cbnz	w8, .LBB18_39
// %bb.38:
	ldr	w8, [x19, #36]
	cbz	w8, .LBB18_29
.LBB18_39:
	ldr	w8, [x19, #12]
	cbz	w8, .LBB18_29
// %bb.40:
	ldr	x8, [x24, #1184]
	add	x26, x24, #1184         // =1184
	cmp	x26, x8
	b.eq	.LBB18_29
// %bb.41:
	add	x25, x24, #1216         // =1216
	mov	x0, x25
	bl	_raw_spin_lock_irqsave
	ldr	x8, [x24, #1184]
	mov	x1, x0
	cmp	x26, x8
	b.eq	.LBB18_43
// %bb.42:
	ldur	x24, [x8, #-192]
	b	.LBB18_44
.LBB18_43:
	mov	x24, xzr
.LBB18_44:
	mov	x0, x25
	bl	_raw_spin_unlock_irqrestore
	bl	ktime_get
	mov	w8, #57600
	movk	w8, #1525, lsl #16
	add	x8, x24, x8
	cmp	x0, x8
	b.lt	.LBB18_29
// %bb.45:
	mov	w8, #25856
	movk	w8, #7629, lsl #16
	add	x8, x24, x8
	cmp	x0, x8
	b.ge	.LBB18_47
// %bb.46:
	ldr	w9, [x19, #12]
	ldr	w10, [x19, #8]
	cmp	w9, w10
	b.lo	.LBB18_29
.LBB18_47:
	adrp	x9, cp_debug_en
	ldr	w9, [x9, :lo12:cp_debug_en]
	cbz	w9, .LBB18_9
// %bb.48:
	cmp	x0, x8
	b.ge	.LBB18_50
// %bb.49:
	adrp	x0, .L.str.23
	mov	w1, #5
	add	x0, x0, :lo12:.L.str.23
	bl	printk
	b	.LBB18_9
.LBB18_50:
	adrp	x0, .L.str.24
	add	x0, x0, :lo12:.L.str.24
	bl	printk
	b	.LBB18_9
.LBB18_51:
	adrp	x0, .L.str.31
	adrp	x1, .L.str.25
	add	x0, x0, :lo12:.L.str.31
	add	x1, x1, :lo12:.L.str.25
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.LBB18_52:
	adrp	x0, .L.str.31
	adrp	x1, .L.str.25
	add	x0, x0, :lo12:.L.str.31
	add	x1, x1, :lo12:.L.str.25
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.Lfunc_end18:
	.size	__ufs_mq_queue_rq, .Lfunc_end18-__ufs_mq_queue_rq
                                        // -- End function
	.p2align	3               // -- Begin function ufs_mq_insert_sync_list
	.type	ufs_mq_insert_sync_list,@function
ufs_mq_insert_sync_list:                // @ufs_mq_insert_sync_list
// %bb.0:
	stp	x26, x25, [sp, #-80]!   // 16-byte Folded Spill
	stp	x24, x23, [sp, #16]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #32]     // 16-byte Folded Spill
	mov	x21, x0
	stp	x20, x19, [sp, #48]     // 16-byte Folded Spill
	mov	x19, x1
	stp	x29, x30, [sp, #64]     // 16-byte Folded Spill
	add	x29, sp, #64            // =64
	bl	_mcount
	ldr	x8, [x19, #2296]
	orr	w1, wzr, #0x8
	mov	x0, x21
	ldr	x26, [x8, #488]
	bl	mas_blk_latency_req_check
	add	x19, x26, #48           // =48
	mov	x0, x19
	bl	_raw_spin_lock_irqsave
	ldr	w8, [x21, #20]
	mov	x20, x0
	tbnz	w8, #24, .LBB19_5
// %bb.1:
	mov	w9, #4096
	movk	w9, #32, lsl #16
	tst	x8, x9
	b.eq	.LBB19_11
// %bb.2:
	ldr	x23, [x26, #136]
	add	x22, x21, #80           // =80
	add	x24, x26, #128          // =128
	mov	x0, x22
	mov	x2, x24
	mov	x1, x23
	bl	__list_add_valid
	tbz	w0, #0, .LBB19_4
// %bb.3:
	str	x22, [x26, #136]
	stp	x24, x23, [x21, #80]
	str	x22, [x23]
.LBB19_4:
	add	x8, x26, #144           // =144
	//APP
	// atomic_add
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	b	.LBB19_27
.LBB19_5:
	mov	x23, x26
	ldr	x22, [x23, #128]!
	cmp	x23, x22
	b.eq	.LBB19_18
// %bb.6:
	ldurb	w8, [x22, #-57]
	tbz	w8, #0, .LBB19_9
.LBB19_7:                               // =>This Inner Loop Header: Depth=1
	ldr	x8, [x22]
	cmp	x8, x23
	b.eq	.LBB19_19
// %bb.8:                               //   in Loop: Header=BB19_7 Depth=1
	mov	x22, x8
	ldurb	w8, [x8, #-57]
	tbnz	w8, #0, .LBB19_7
.LBB19_9:
	ldr	x23, [x22, #8]
	add	x24, x21, #80           // =80
	mov	x0, x24
	mov	x2, x22
	mov	x1, x23
	bl	__list_add_valid
	tbz	w0, #0, .LBB19_21
// %bb.10:
	str	x24, [x22, #8]
	stp	x22, x23, [x21, #80]
	str	x24, [x23]
	b	.LBB19_21
.LBB19_11:
	mov	x23, x26
	ldr	x22, [x23, #152]!
	cmp	x23, x22
	b.eq	.LBB19_22
// %bb.12:
	ldr	w8, [x21, #392]
	cbz	w8, .LBB19_22
.LBB19_13:                              // =>This Inner Loop Header: Depth=1
	ldr	w9, [x22, #312]
	cbz	w9, .LBB19_15
// %bb.14:                              //   in Loop: Header=BB19_13 Depth=1
	sub	w9, w8, w9
	tbnz	w9, #31, .LBB19_24
.LBB19_15:                              //   in Loop: Header=BB19_13 Depth=1
	ldr	x22, [x22]
	cmp	x23, x22
	b.ne	.LBB19_13
// %bb.16:
	ldr	x24, [x22, #8]
	add	x25, x21, #80           // =80
	mov	x0, x25
	mov	x2, x23
	mov	x1, x24
	bl	__list_add_valid
	tbz	w0, #0, .LBB19_26
// %bb.17:
	str	x25, [x22, #8]
	stp	x22, x24, [x21, #80]
	str	x25, [x24]
	b	.LBB19_26
.LBB19_18:
	ldr	x22, [x26, #136]
.LBB19_19:
	add	x24, x21, #80           // =80
	mov	x0, x24
	mov	x1, x22
	mov	x2, x23
	bl	__list_add_valid
	tbz	w0, #0, .LBB19_21
// %bb.20:
	str	x24, [x26, #136]
	stp	x23, x22, [x21, #80]
	str	x24, [x22]
.LBB19_21:
	add	x8, x26, #144           // =144
	//APP
	// atomic_add
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	b	.LBB19_27
.LBB19_22:
	ldr	x22, [x26, #160]
	add	x24, x21, #80           // =80
	mov	x0, x24
	mov	x2, x23
	mov	x1, x22
	bl	__list_add_valid
	tbz	w0, #0, .LBB19_26
// %bb.23:
	str	x24, [x26, #160]
	stp	x23, x22, [x21, #80]
	str	x24, [x22]
	b	.LBB19_26
.LBB19_24:
	ldr	x23, [x22, #8]
	add	x24, x21, #80           // =80
	mov	x0, x24
	mov	x2, x22
	mov	x1, x23
	bl	__list_add_valid
	tbz	w0, #0, .LBB19_26
// %bb.25:
	str	x24, [x22, #8]
	stp	x22, x23, [x21, #80]
	str	x24, [x23]
.LBB19_26:
	add	x8, x26, #168           // =168
	//APP
	// atomic_add
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
.LBB19_27:
	mov	x0, x19
	mov	x1, x20
	bl	_raw_spin_unlock_irqrestore
	ldp	x29, x30, [sp, #64]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]     // 16-byte Folded Reload
	ldp	x26, x25, [sp], #80     // 16-byte Folded Reload
	ret
.Lfunc_end19:
	.size	ufs_mq_insert_sync_list, .Lfunc_end19-ufs_mq_insert_sync_list
                                        // -- End function
	.globl	ufs_mq_make_request     // -- Begin function ufs_mq_make_request
	.p2align	3
	.type	ufs_mq_make_request,@function
ufs_mq_make_request:                    // @ufs_mq_make_request
// %bb.0:
	sub	sp, sp, #192            // =192
	adrp	x8, __stack_chk_guard
	str	x27, [sp, #96]          // 8-byte Folded Spill
	stp	x26, x25, [sp, #112]    // 16-byte Folded Spill
	stp	x24, x23, [sp, #128]    // 16-byte Folded Spill
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	stp	x22, x21, [sp, #144]    // 16-byte Folded Spill
	mov	x22, x0
	stp	x20, x19, [sp, #160]    // 16-byte Folded Spill
	mov	x20, x1
	stp	x29, x30, [sp, #176]    // 16-byte Folded Spill
	add	x29, sp, #176           // =176
	str	x8, [sp, #88]
	bl	_mcount
	stp	xzr, xzr, [sp, #56]
	ldr	w8, [x20, #16]
	stp	xzr, xzr, [sp, #40]
	stp	xzr, xzr, [sp, #24]
	stp	xzr, xzr, [sp, #8]
	orr	w9, w8, #0x2
	and	w9, w9, #0xff
	cmp	w9, #2                  // =2
	b.eq	.LBB20_2
// %bb.1:
	mov	w9, #6144
	movk	w9, #34, lsl #16
	tst	w8, w9
	b.eq	.LBB20_51
.LBB20_2:
	ldr	x9, [x22, #2296]
	orr	w8, w8, #0x800
	str	w8, [x20, #16]
	ldr	x21, [x9, #488]
	bl	ktime_get
	ldr	w8, [x21, #432]
	mov	x19, x0
	cmp	w8, #1                  // =1
	b.eq	.LBB20_6
// %bb.3:
	cbnz	w8, .LBB20_8
// %bb.4:
	ldr	x8, [x21, #296]
	mov	w9, #19264
	movk	w9, #76, lsl #16
	add	x8, x8, x9
	cmp	x8, x19
	b.le	.LBB20_8
// %bb.5:
	orr	w8, wzr, #0x1
	str	x19, [x21, #304]
	adrp	x9, jiffies
	add	x0, x21, #336           // =336
	str	w8, [x21, #432]
	ldr	x8, [x9, :lo12:jiffies]
	add	x1, x8, #2              // =2
	bl	mod_timer
	b	.LBB20_8
.LBB20_6:
	ldr	x8, [x21, #296]
	mov	w9, #19264
	movk	w9, #76, lsl #16
	add	x8, x8, x9
	cmp	x8, x19
	b.le	.LBB20_8
// %bb.7:
	orr	w8, wzr, #0x2
	str	w8, [x21, #432]
.LBB20_8:
	str	x19, [x21, #296]
	ldrb	w8, [x20, #18]
	tst	w8, #0x6
	b.ne	.LBB20_11
// %bb.9:
	//APP
	mrs x8, sp_el0
	//NO_APP
	ldr	x9, [x8, #5904]
	cbz	x9, .LBB20_11
// %bb.10:
	ldr	w10, [x20, #48]
	cmp	w10, #128, lsl #12      // =524288
	b.ls	.LBB20_38
.LBB20_11:
	mov	x25, xzr
.LBB20_12:
	mov	w24, wzr
	mov	x23, xzr
	orr	w26, wzr, #0x1
.LBB20_13:
	mov	x0, x22
	mov	x1, x20
	mov	x2, xzr
	bl	rq_qos_throttle
	orr	w1, wzr, #0x3
	mov	x0, x20
	bl	mas_blk_latency_bio_check
	ldr	w2, [x20, #16]
	add	x3, sp, #8              // =8
	mov	x0, x22
	mov	x1, x20
	bl	blk_mq_get_request
	cbz	x0, .LBB20_54
// %bb.14:
	ldrb	w8, [x0, #20]
	mov	x21, x0
	orr	w8, w8, #0x2
	cmp	w8, #3                  // =3
	b.ne	.LBB20_16
// %bb.15:
	mov	x0, x21
	bl	blk_req_set_make_req_nr
.LBB20_16:
	mov	x0, x22
	mov	x1, x21
	mov	x2, x20
	bl	rq_qos_track
	ldr	x0, [sp, #64]
	mov	x1, x21
	bl	request_to_qc_t
	ldr	w8, [x20, #16]
	mov	w19, w0
	and	w9, w8, #0xff
	cmp	w9, #2                  // =2
	b.eq	.LBB20_53
// %bb.17:
	tbnz	w8, #18, .LBB20_53
// %bb.18:
	ldr	w9, [x21, #20]
	tbz	w9, #11, .LBB20_56
// %bb.19:
	ldr	x8, [x21]
	mov	x0, x21
	mov	x1, x20
	ldr	x27, [x8, #2296]
	bl	blk_init_request_from_bio
	orr	w1, wzr, #0x1
	mov	x0, x21
	bl	blk_account_io_start
	cbnz	w26, .LBB20_67
// %bb.20:
	cbz	x23, .LBB20_25
// %bb.21:
	mov	x8, x25
	ldr	x9, [x8, #48]!
	cmp	x8, x9
	b.eq	.LBB20_68
// %bb.22:
	add	x20, x23, #80           // =80
	mov	x0, x20
	bl	__list_del_entry_valid
	tbz	w0, #0, .LBB20_24
// %bb.23:
	ldp	x8, x9, [x23, #80]
	str	x9, [x8, #8]
	str	x8, [x9]
.LBB20_24:
	str	x20, [x23, #80]
	str	x20, [x23, #88]
.LBB20_25:
	ldr	x22, [x25, #56]
	add	x20, x21, #80           // =80
	add	x24, x25, #48           // =48
	mov	x0, x20
	mov	x2, x24
	mov	x1, x22
	bl	__list_add_valid
	tbz	w0, #0, .LBB20_27
// %bb.26:
	str	x20, [x25, #56]
	stp	x24, x22, [x21, #80]
	str	x20, [x22]
.LBB20_27:
	orr	w1, wzr, #0x6
	mov	x0, x21
	bl	mas_blk_latency_req_check
	str	x23, [sp, #72]
	cbz	x23, .LBB20_29
.LBB20_28:
	ldr	x1, [sp, #64]
	add	x3, sp, #72             // =72
	ldr	x2, [x27, #488]
	mov	x0, x23
	ldr	x4, [x21]
	bl	__ufs_mq_queue_rq
	mov	w20, w0
	b	.LBB20_30
.LBB20_29:
	mov	w20, wzr
.LBB20_30:
	ldr	x8, [sp, #56]
	ldr	x8, [x8, #208]
	ldr	x8, [x8, #2304]
	cbz	x8, .LBB20_33
// %bb.31:
	ldr	x8, [x8, #80]
	cbz	x8, .LBB20_33
// %bb.32:
	blr	x8
	cbz	w20, .LBB20_36
	b	.LBB20_71
.LBB20_33:
	orr	w0, wzr, #0x1
	//APP
	//NO_APP
	bl	preempt_count_sub
	//APP
	mrs x8, sp_el0
	//NO_APP
	ldr	w9, [x8, #72]
	cbnz	w9, .LBB20_35
// %bb.34:
	ldr	x8, [x8]
	tbnz	w8, #1, .LBB20_70
.LBB20_35:
	cbnz	w20, .LBB20_71
.LBB20_36:
	adrp	x9, __stack_chk_guard
	ldr	x8, [sp, #88]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB20_81
// %bb.37:
	mov	w0, w19
	ldr	x27, [sp, #96]          // 8-byte Folded Reload
	ldp	x29, x30, [sp, #176]    // 16-byte Folded Reload
	ldp	x20, x19, [sp, #160]    // 16-byte Folded Reload
	ldp	x22, x21, [sp, #144]    // 16-byte Folded Reload
	ldp	x24, x23, [sp, #128]    // 16-byte Folded Reload
	ldp	x26, x25, [sp, #112]    // 16-byte Folded Reload
	add	sp, sp, #192            // =192
	ret
.LBB20_38:
	ldr	x10, [x9, #64]
	cbz	x10, .LBB20_40
// %bb.39:
	adrp	x11, __cfi_ufs_mq_flush_plug_list
	add	x11, x11, :lo12:__cfi_ufs_mq_flush_plug_list
	cmp	x10, x11
	b.ne	.LBB20_11
.LBB20_40:
	adrp	x10, __cfi_ufs_mq_flush_plug_list
	add	x10, x10, :lo12:__cfi_ufs_mq_flush_plug_list
	str	x10, [x9, #64]
	ldr	x25, [x8, #5904]
	cbz	x25, .LBB20_12
// %bb.41:
	ldr	x24, [x25, #56]
	add	x26, x25, #48           // =48
	cmp	x26, x24
	b.eq	.LBB20_52
// %bb.42:
	mov	x23, xzr
	mov	w19, #-1
.LBB20_43:                              // =>This Inner Loop Header: Depth=1
	mov	x21, x24
	ldr	x8, [x21, #-80]!
	cmp	x8, x22
	b.ne	.LBB20_49
// %bb.44:                              //   in Loop: Header=BB20_43 Depth=1
	mov	x0, x21
	mov	x1, x20
	bl	blk_rq_merge_ok
	mov	x23, x21
	tbz	w0, #0, .LBB20_49
// %bb.45:                              //   in Loop: Header=BB20_43 Depth=1
	mov	x0, x21
	mov	x1, x20
	bl	blk_try_merge
	cmp	w0, #1                  // =1
	b.eq	.LBB20_48
// %bb.46:                              //   in Loop: Header=BB20_43 Depth=1
	mov	x23, x21
	cmp	w0, #2                  // =2
	b.ne	.LBB20_49
// %bb.47:                              //   in Loop: Header=BB20_43 Depth=1
	mov	x0, x22
	mov	x1, x21
	mov	x2, x20
	bl	bio_attempt_back_merge
	mov	x23, x21
	tbz	w0, #0, .LBB20_49
	b	.LBB20_36
.LBB20_48:                              //   in Loop: Header=BB20_43 Depth=1
	mov	x0, x22
	mov	x1, x21
	mov	x2, x20
	bl	bio_attempt_front_merge
	mov	x23, x21
	tbnz	w0, #0, .LBB20_36
.LBB20_49:                              //   in Loop: Header=BB20_43 Depth=1
	ldr	x24, [x24, #8]
	cmp	x26, x24
	b.ne	.LBB20_43
// %bb.50:
	mov	w26, wzr
	mov	w24, wzr
	b	.LBB20_13
.LBB20_51:
	mov	x25, xzr
	mov	x23, xzr
	orr	w26, wzr, #0x1
	orr	w24, wzr, #0x1
	b	.LBB20_13
.LBB20_52:
	mov	w26, wzr
	mov	w24, wzr
	mov	x23, xzr
	b	.LBB20_13
.LBB20_53:
	mov	x0, x21
	mov	x1, x20
	bl	blk_init_request_from_bio
	orr	w1, wzr, #0x1
	mov	x0, x21
	bl	blk_account_io_start
	mov	x0, x21
	bl	blk_insert_flush
	b	.LBB20_60
.LBB20_54:
	mov	x0, x22
	mov	x1, x20
	bl	rq_qos_cleanup
	ldrb	w8, [x20, #19]
	tbnz	w8, #5, .LBB20_69
// %bb.55:
	mov	w19, #-1
	b	.LBB20_36
.LBB20_56:
	ldp	x22, x23, [sp, #56]
	mov	w10, #16384
	movk	w10, #6, lsl #16
	tst	w8, w10
	b.ne	.LBB20_58
// %bb.57:
	and	w8, w9, #0xfe
	orr	w8, w8, #0x1
	cmp	w8, #33                 // =33
	b.ne	.LBB20_74
.LBB20_58:
	mov	x0, x21
	mov	x1, x20
	bl	blk_init_request_from_bio
	orr	w1, wzr, #0x1
	mov	x0, x21
	bl	blk_account_io_start
	mov	x0, x22
	bl	_raw_spin_lock
.LBB20_59:
	ldr	x1, [x23, #360]
	mov	x0, x21
	bl	ufs_mq_req_insert
	mov	x0, x22
	bl	_raw_spin_unlock
.LBB20_60:
	ldr	x0, [sp, #64]
	mov	w1, w24
	bl	blk_mq_run_hw_queue
.LBB20_61:
	ldr	x8, [sp, #56]
	ldr	x8, [x8, #208]
	ldr	x8, [x8, #2304]
	cbz	x8, .LBB20_64
// %bb.62:
	ldr	x8, [x8, #80]
	cbz	x8, .LBB20_64
// %bb.63:
	blr	x8
	b	.LBB20_36
.LBB20_64:
	orr	w0, wzr, #0x1
	//APP
	//NO_APP
	bl	preempt_count_sub
	//APP
	mrs x8, sp_el0
	//NO_APP
	ldr	w9, [x8, #72]
	cbnz	w9, .LBB20_36
// %bb.65:
	ldr	x8, [x8]
	tbz	w8, #1, .LBB20_36
// %bb.66:
	bl	preempt_schedule
	b	.LBB20_36
.LBB20_67:
	mov	x23, x21
	str	x21, [sp, #72]
	b	.LBB20_28
.LBB20_68:
	mov	x23, xzr
	b	.LBB20_25
.LBB20_69:
	orr	w8, wzr, #0xc
	mov	x0, x20
	strb	w8, [x20, #26]
	bl	bio_endio
	mov	w19, #-1
	b	.LBB20_36
.LBB20_70:
	bl	preempt_schedule
	cbz	w20, .LBB20_36
.LBB20_71:
	ldr	x0, [sp, #72]
	cmp	w20, #9                 // =9
	b.ne	.LBB20_73
// %bb.72:
	bl	__blk_mq_requeue_request
	ldr	x20, [x21]
	ldr	x0, [sp, #72]
	mov	x1, x20
	bl	ufs_mq_insert_sync_list
	ldr	x20, [x20, #2296]
	adrp	x8, mas_blk_mq_sync_disp_wq
	orr	w0, wzr, #0x8
	mov	x3, xzr
	ldr	x1, [x8, :lo12:mas_blk_mq_sync_disp_wq]
	add	x2, x20, #32            // =32
	bl	queue_delayed_work_on
	bl	ktime_get
	str	x0, [x20, #8]
	b	.LBB20_36
.LBB20_73:
	mov	w1, #10
	bl	blk_mq_end_request
	b	.LBB20_36
.LBB20_74:
	mov	x27, x23
	ldr	x23, [x23, #360]
	mov	x0, x22
	bl	_raw_spin_lock
	ldrb	w8, [x20, #17]
	tbnz	w8, #3, .LBB20_80
// %bb.75:
	ldr	x8, [x23, #2304]
	cbz	x8, .LBB20_80
// %bb.76:
	ldr	x26, [x8, #176]
	cbz	x26, .LBB20_80
// %bb.77:
	ldr	x8, [x26]
	ldr	x8, [x8, #40]
	cbz	x8, .LBB20_80
// %bb.78:
	ldr	x8, [x23, #2296]
	ldr	x8, [x8, #488]
	add	x25, x8, #176           // =176
	mov	x0, x25
	bl	_raw_spin_lock_irqsave
	ldr	x8, [x26]
	mov	x26, x0
	mov	x0, x20
	mov	x1, x23
	mov	w2, wzr
	ldr	x8, [x8, #40]
	blr	x8
	mov	w23, w0
	mov	x0, x25
	mov	x1, x26
	bl	_raw_spin_unlock_irqrestore
	tbz	w23, #0, .LBB20_80
// %bb.79:
	mov	x0, x22
	bl	_raw_spin_unlock
	mov	x0, x21
	bl	blk_mq_free_request
	b	.LBB20_61
.LBB20_80:
	mov	x0, x21
	mov	x1, x20
	bl	blk_init_request_from_bio
	orr	w1, wzr, #0x1
	mov	x0, x21
	bl	blk_account_io_start
	mov	x23, x27
	b	.LBB20_59
.LBB20_81:
	bl	__stack_chk_fail
.Lfunc_end20:
	.size	ufs_mq_make_request, .Lfunc_end20-ufs_mq_make_request
                                        // -- End function
	.globl	ufs_mq_sync_io_dispatch_work_fn // -- Begin function ufs_mq_sync_io_dispatch_work_fn
	.p2align	3
	.type	ufs_mq_sync_io_dispatch_work_fn,@function
ufs_mq_sync_io_dispatch_work_fn:        // @ufs_mq_sync_io_dispatch_work_fn
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	x0, [x19, #200]
	bl	ufs_mq_sync_dispatch
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end21:
	.size	ufs_mq_sync_io_dispatch_work_fn, .Lfunc_end21-ufs_mq_sync_io_dispatch_work_fn
                                        // -- End function
	.p2align	3               // -- Begin function ufs_mq_sync_dispatch
	.type	ufs_mq_sync_dispatch,@function
ufs_mq_sync_dispatch:                   // @ufs_mq_sync_dispatch
// %bb.0:
	sub	sp, sp, #128            // =128
	adrp	x8, __stack_chk_guard
	stp	x28, x27, [sp, #32]     // 16-byte Folded Spill
	stp	x26, x25, [sp, #48]     // 16-byte Folded Spill
	stp	x24, x23, [sp, #64]     // 16-byte Folded Spill
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	stp	x22, x21, [sp, #80]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #96]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #112]    // 16-byte Folded Spill
	add	x29, sp, #112           // =112
	str	x8, [sp, #24]
	bl	_mcount
	ldr	x26, [x19, #2296]
	ldr	x19, [x26, #488]
	bl	ktime_get
	add	x20, x19, #48           // =48
	str	x0, [x26, #16]
	add	x27, x19, #128          // =128
	add	x28, x19, #152          // =152
	mov	w21, #10
	b	.LBB22_2
.LBB22_1:                               //   in Loop: Header=BB22_2 Depth=1
	mov	x0, x23
	mov	w1, w21
	bl	blk_mq_end_request
.LBB22_2:                               // =>This Inner Loop Header: Depth=1
	mov	x0, x20
	bl	_raw_spin_lock_irqsave
	ldr	x8, [x27]
	mov	x24, x0
	cmp	x8, x27
	b.eq	.LBB22_4
.LBB22_3:                               //   in Loop: Header=BB22_2 Depth=1
	add	x8, x19, #144           // =144
	//APP
	// atomic_sub
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	sub	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	mov	x8, x27
	b	.LBB22_8
.LBB22_4:                               //   in Loop: Header=BB22_2 Depth=1
	ldr	x8, [x19, #136]
	cmp	x8, x27
	b.ne	.LBB22_3
// %bb.5:                               //   in Loop: Header=BB22_2 Depth=1
	ldr	x8, [x28]
	cmp	x8, x28
	b.ne	.LBB22_7
// %bb.6:                               //   in Loop: Header=BB22_2 Depth=1
	ldr	x8, [x19, #160]
	cmp	x8, x28
	b.eq	.LBB22_17
.LBB22_7:                               //   in Loop: Header=BB22_2 Depth=1
	add	x8, x19, #168           // =168
	//APP
	// atomic_sub
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	sub	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	mov	x8, x28
.LBB22_8:                               //   in Loop: Header=BB22_2 Depth=1
	ldr	x25, [x8]
	subs	x23, x25, #80           // =80
	b.eq	.LBB22_17
// %bb.9:                               //   in Loop: Header=BB22_2 Depth=1
	ldur	x22, [x25, #-80]
	mov	x0, x25
	bl	__list_del_entry_valid
	tbz	w0, #0, .LBB22_11
// %bb.10:                              //   in Loop: Header=BB22_2 Depth=1
	ldp	x8, x9, [x25]
	str	x9, [x8, #8]
	str	x8, [x9]
.LBB22_11:                              //   in Loop: Header=BB22_2 Depth=1
	mov	x0, x20
	str	x25, [x25]
	mov	x1, x24
	str	x25, [x25, #8]
	bl	_raw_spin_unlock_irqrestore
	ldur	x8, [x25, #-72]
	ldr	x9, [x22, #408]
	ldr	x10, [x22, #432]
	ldrsw	x8, [x8, #128]
	ldr	w8, [x9, x8, lsl #2]
	ldr	x24, [x10, x8, lsl #3]
	str	x23, [sp, #8]
	ldur	w8, [x25, #-60]
	and	w8, w8, #0xfc
	orr	w8, w8, #0x3
	cmp	w8, #35                 // =35
	b.eq	.LBB22_14
// %bb.12:                              //   in Loop: Header=BB22_2 Depth=1
	add	x3, sp, #8              // =8
	mov	x0, x23
	mov	x1, x24
	mov	x2, x19
	mov	x4, x22
	bl	__ufs_mq_queue_rq
	cbz	w0, .LBB22_2
.LBB22_13:                              //   in Loop: Header=BB22_2 Depth=1
	cmp	w0, #9                  // =9
	b.eq	.LBB22_20
	b	.LBB22_1
.LBB22_14:                              //   in Loop: Header=BB22_2 Depth=1
	ldr	x8, [x24, #360]
	ldr	x8, [x8, #400]
	ldr	x8, [x8, #8]
	cbz	x8, .LBB22_16
// %bb.15:                              //   in Loop: Header=BB22_2 Depth=1
	mov	x0, x24
	blr	x8
	tbz	w0, #0, .LBB22_20
.LBB22_16:                              //   in Loop: Header=BB22_2 Depth=1
	ldr	x8, [x22, #400]
	add	x1, sp, #8              // =8
	mov	x0, x24
	ldr	x8, [x8]
	blr	x8
	ldr	x8, [sp, #8]
	mov	w24, w0
	mov	w1, w21
	mov	x0, x8
	bl	mas_blk_latency_req_check
	and	w0, w24, #0xff
	cbz	w0, .LBB22_2
	b	.LBB22_13
.LBB22_17:
	mov	x0, x20
	mov	x1, x24
	bl	_raw_spin_unlock_irqrestore
.LBB22_18:
	bl	ktime_get
	adrp	x9, __stack_chk_guard
	str	x0, [x26, #24]
	ldr	x8, [sp, #24]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB22_25
// %bb.19:
	ldp	x29, x30, [sp, #112]    // 16-byte Folded Reload
	ldp	x20, x19, [sp, #96]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #64]     // 16-byte Folded Reload
	ldp	x26, x25, [sp, #48]     // 16-byte Folded Reload
	ldp	x28, x27, [sp, #32]     // 16-byte Folded Reload
	add	sp, sp, #128            // =128
	ret
.LBB22_20:
	mov	x0, x23
	mov	w20, #37888
	movk	w20, #30517, lsl #16
	bl	__blk_mq_requeue_request
	mov	x0, x23
	mov	x1, x22
	bl	ufs_mq_insert_sync_list
	bl	ktime_get
	ldr	x8, [x19, #312]
	add	x8, x8, x20
	cmp	x8, x0
	b.ge	.LBB22_23
// %bb.21:
	bl	ktime_get
	ldr	x8, [x19, #320]
	add	x8, x8, x20
	cmp	x8, x0
	b.ge	.LBB22_23
// %bb.22:
	ldr	x19, [x22, #2296]
	adrp	x8, mas_blk_mq_sync_disp_wq
	orr	w0, wzr, #0x8
	orr	w3, wzr, #0x1
	b	.LBB22_24
.LBB22_23:
	adrp	x8, mas_blk_mq_sync_disp_wq
	ldr	x19, [x22, #2296]
	orr	w0, wzr, #0x8
	mov	x3, xzr
.LBB22_24:
	ldr	x1, [x8, :lo12:mas_blk_mq_sync_disp_wq]
	add	x2, x19, #32            // =32
	bl	queue_delayed_work_on
	bl	ktime_get
	str	x0, [x19, #8]
	b	.LBB22_18
.LBB22_25:
	bl	__stack_chk_fail
.Lfunc_end22:
	.size	ufs_mq_sync_dispatch, .Lfunc_end22-ufs_mq_sync_dispatch
                                        // -- End function
	.globl	ufs_mq_write_throttle_check_timer_expire // -- Begin function ufs_mq_write_throttle_check_timer_expire
	.p2align	3
	.type	ufs_mq_write_throttle_check_timer_expire,@function
ufs_mq_write_throttle_check_timer_expire: // @ufs_mq_write_throttle_check_timer_expire
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	add	x20, x19, #536          // =536
	mov	x0, x20
	bl	_raw_spin_lock_irqsave
	orr	w8, wzr, #0x1
	mov	x1, x0
	mov	x0, x20
	strb	w8, [x19, #616]
	bl	_raw_spin_unlock_irqrestore
	mov	x0, x19
	bl	ufs_mq_async_disp_inflt_lmt_decision
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end23:
	.size	ufs_mq_write_throttle_check_timer_expire, .Lfunc_end23-ufs_mq_write_throttle_check_timer_expire
                                        // -- End function
	.p2align	3               // -- Begin function ufs_mq_async_disp_inflt_lmt_decision
	.type	ufs_mq_async_disp_inflt_lmt_decision,@function
ufs_mq_async_disp_inflt_lmt_decision:   // @ufs_mq_async_disp_inflt_lmt_decision
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	bl	_mcount
	ldr	x8, [x19]
	str	wzr, [x19, #436]
	ldr	w8, [x8, #1548]
	ldr	w9, [x19, #20]
	ldr	w10, [x19, #432]
	cmp	w10, #3                 // =3
	b.hi	.LBB24_14
// %bb.1:
	adrp	x11, .LJTI24_0
	add	x11, x11, :lo12:.LJTI24_0
	adr	x12, .LBB24_2
	ldrb	w13, [x11, x10]
	add	x12, x12, x13, lsl #2
	br	x12
.LBB24_2:
	ldr	w8, [x19, #288]
	cmp	w8, #14                 // =14
	b.eq	.LBB24_13
// %bb.3:
	add	x20, x19, #536          // =536
	mov	x0, x20
	bl	_raw_spin_lock_irqsave
	ldrb	w8, [x19, #616]
	mov	x1, x0
	cbz	w8, .LBB24_12
// %bb.4:
	orr	w8, wzr, #0xe
	b	.LBB24_11
.LBB24_5:
	sub	w8, w8, w9
	ldr	w9, [x19, #288]
	cmp	w8, #4                  // =4
	orr	w8, wzr, #0xe
	orr	w10, wzr, #0x10
	csel	w21, w10, w8, lo
	cmp	w9, w21
	b.eq	.LBB24_13
// %bb.6:
	add	x20, x19, #536          // =536
	mov	x0, x20
	bl	_raw_spin_lock_irqsave
	ldrb	w8, [x19, #616]
	mov	x1, x0
	cbz	w8, .LBB24_12
// %bb.7:
	str	w21, [x19, #288]
	b	.LBB24_12
.LBB24_8:
	ldr	w8, [x19, #288]
	cmp	w8, #10                 // =10
	b.eq	.LBB24_13
// %bb.9:
	add	x20, x19, #536          // =536
	mov	x0, x20
	bl	_raw_spin_lock_irqsave
	ldrb	w8, [x19, #616]
	mov	x1, x0
	cbz	w8, .LBB24_12
// %bb.10:
	mov	w8, #10
.LBB24_11:
	str	w8, [x19, #288]
.LBB24_12:
	mov	x0, x20
	bl	_raw_spin_unlock_irqrestore
	bl	ktime_get
	str	x0, [x19, #328]
.LBB24_13:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.LBB24_14:
	adrp	x0, .L.str.31
	adrp	x1, .L.str.29
	add	x0, x0, :lo12:.L.str.31
	add	x1, x1, :lo12:.L.str.29
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.Lfunc_end24:
	.size	ufs_mq_async_disp_inflt_lmt_decision, .Lfunc_end24-ufs_mq_async_disp_inflt_lmt_decision
	.section	.rodata,"a",@progbits
.LJTI24_0:
	.byte	(.LBB24_5-.LBB24_2)>>2
	.byte	(.LBB24_2-.LBB24_2)>>2
	.byte	(.LBB24_8-.LBB24_2)>>2
	.byte	(.LBB24_2-.LBB24_2)>>2
                                        // -- End function
	.text
	.globl	ufs_mq_write_throttle_handler // -- Begin function ufs_mq_write_throttle_handler
	.p2align	3
	.type	ufs_mq_write_throttle_handler,@function
ufs_mq_write_throttle_handler:          // @ufs_mq_write_throttle_handler
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	w19, w1
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x20, x0
	bl	_mcount
	ldr	x8, [x20, #2296]
	ldr	x21, [x8, #488]
	add	x20, x21, #536          // =536
	mov	x0, x20
	bl	_raw_spin_lock_irqsave
	tst	w19, #0x1
	strb	wzr, [x21, #616]
	mov	w8, #5
	mov	w9, #20
	mov	x1, x0
	csel	w8, w9, w8, ne
	mov	x0, x20
	str	w8, [x21, #288]
	bl	_raw_spin_unlock_irqrestore
	adrp	x8, jiffies
	add	x0, x21, #440           // =440
	ldr	x8, [x8, :lo12:jiffies]
	add	x1, x8, #250            // =250
	bl	mod_timer
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.Lfunc_end25:
	.size	ufs_mq_write_throttle_handler, .Lfunc_end25-ufs_mq_write_throttle_handler
                                        // -- End function
	.globl	ufs_mq_async_io_dispatch_work_fn // -- Begin function ufs_mq_async_io_dispatch_work_fn
	.p2align	3
	.type	ufs_mq_async_io_dispatch_work_fn,@function
ufs_mq_async_io_dispatch_work_fn:       // @ufs_mq_async_io_dispatch_work_fn
// %bb.0:
	sub	sp, sp, #112            // =112
	adrp	x8, __stack_chk_guard
	stp	x26, x25, [sp, #32]     // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]     // 16-byte Folded Spill
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	stp	x20, x19, [sp, #80]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #96]     // 16-byte Folded Spill
	add	x29, sp, #96            // =96
	str	x8, [sp, #24]
	bl	_mcount
	ldr	x26, [x19, #200]
	ldr	x25, [x26, #2296]
	ldr	x19, [x25, #488]
	bl	ktime_get
	str	x0, [x25, #248]
	mov	x0, x19
	bl	ufs_mq_async_disp_inflt_lmt_decision
	ldr	x8, [x26, #2304]
	cbz	x8, .LBB26_15
// %bb.1:
	mov	w20, #10
.LBB26_2:                               // =>This Inner Loop Header: Depth=1
	ldr	x21, [x8, #176]
	cbz	x21, .LBB26_15
// %bb.3:                               //   in Loop: Header=BB26_2 Depth=1
	ldr	x8, [x21]
	ldr	x8, [x8, #24]
	cbz	x8, .LBB26_15
// %bb.4:                               //   in Loop: Header=BB26_2 Depth=1
	ldr	x8, [x26, #2296]
	ldr	x23, [x8, #488]
	add	x22, x23, #176          // =176
	mov	x0, x22
	bl	_raw_spin_lock_irqsave
	ldr	x8, [x21]
	mov	x24, x0
	mov	x0, x23
	ldr	x8, [x8, #24]
	blr	x8
	cbz	x0, .LBB26_14
// %bb.5:                               //   in Loop: Header=BB26_2 Depth=1
	add	x8, x23, #280           // =280
	mov	x21, x0
	mov	x0, x22
	mov	x1, x24
	//APP
	// atomic_sub
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	sub	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	bl	_raw_spin_unlock_irqrestore
	ldp	x22, x8, [x21]
	ldrsw	x8, [x8, #128]
	ldr	x9, [x22, #408]
	ldr	x10, [x22, #432]
	ldr	w8, [x9, x8, lsl #2]
	ldr	w9, [x21, #20]
	ldr	x23, [x10, x8, lsl #3]
	and	w8, w9, #0xfc
	str	x21, [sp, #8]
	orr	w8, w8, #0x3
	cmp	w8, #35                 // =35
	b.eq	.LBB26_9
// %bb.6:                               //   in Loop: Header=BB26_2 Depth=1
	add	x3, sp, #8              // =8
	mov	x0, x21
	mov	x1, x23
	mov	x2, x19
	mov	x4, x22
	bl	__ufs_mq_queue_rq
	cbnz	w0, .LBB26_12
.LBB26_7:                               //   in Loop: Header=BB26_2 Depth=1
	ldr	x8, [x21, #48]
	ldr	w9, [x21, #40]
	add	x8, x8, x9, lsr #9
	str	x8, [x26, #448]
.LBB26_8:                               //   in Loop: Header=BB26_2 Depth=1
	mov	x0, x19
	bl	ufs_mq_async_disp_inflt_lmt_decision
	ldr	x8, [x26, #2304]
	cbnz	x8, .LBB26_2
	b	.LBB26_15
.LBB26_9:                               //   in Loop: Header=BB26_2 Depth=1
	ldr	x8, [x23, #360]
	ldr	x8, [x8, #400]
	ldr	x8, [x8, #8]
	cbz	x8, .LBB26_11
// %bb.10:                              //   in Loop: Header=BB26_2 Depth=1
	mov	x0, x23
	blr	x8
	tbz	w0, #0, .LBB26_17
.LBB26_11:                              //   in Loop: Header=BB26_2 Depth=1
	ldr	x8, [x22, #400]
	add	x1, sp, #8              // =8
	mov	x0, x23
	ldr	x8, [x8]
	blr	x8
	ldr	x8, [sp, #8]
	mov	w23, w0
	mov	w1, w20
	mov	x0, x8
	bl	mas_blk_latency_req_check
	and	w0, w23, #0xff
	cbz	w0, .LBB26_7
.LBB26_12:                              //   in Loop: Header=BB26_2 Depth=1
	cmp	w0, #9                  // =9
	b.eq	.LBB26_17
// %bb.13:                              //   in Loop: Header=BB26_2 Depth=1
	mov	x0, x21
	mov	w1, w20
	bl	blk_mq_end_request
	b	.LBB26_8
.LBB26_14:
	mov	x0, x22
	mov	x1, x24
	bl	_raw_spin_unlock_irqrestore
.LBB26_15:
	bl	ktime_get
	adrp	x9, __stack_chk_guard
	str	x0, [x25, #256]
	ldr	x8, [sp, #24]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB26_22
// %bb.16:
	ldp	x29, x30, [sp, #96]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]     // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]     // 16-byte Folded Reload
	add	sp, sp, #112            // =112
	ret
.LBB26_17:
	mov	x0, x21
	bl	__blk_mq_requeue_request
	ldr	x8, [x22, #2304]
	ldr	x19, [x22, #2296]
	cbz	x8, .LBB26_21
// %bb.18:
	ldr	x23, [x8, #176]
	cbz	x23, .LBB26_21
// %bb.19:
	ldr	x8, [x23]
	ldr	x8, [x8, #32]
	cbz	x8, .LBB26_21
// %bb.20:
	ldr	x19, [x19, #488]
	mov	w1, #9
	mov	x0, x21
	bl	mas_blk_latency_req_check
	add	x20, x19, #176          // =176
	mov	x0, x20
	bl	_raw_spin_lock_irqsave
	ldr	x8, [x23]
	mov	x23, x0
	mov	x0, x21
	mov	x1, x19
	ldr	x8, [x8, #32]
	blr	x8
	add	x8, x19, #280           // =280
	mov	x0, x20
	mov	x1, x23
	//APP
	// atomic_add
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	bl	_raw_spin_unlock_irqrestore
	ldr	x19, [x22, #2296]
.LBB26_21:
	adrp	x8, mas_blk_mq_async_disp_wq
	add	x2, x19, #264           // =264
	orr	w0, wzr, #0x8
	ldr	x1, [x8, :lo12:mas_blk_mq_async_disp_wq]
	orr	w3, wzr, #0x1
	bl	queue_delayed_work_on
	bl	ktime_get
	str	x0, [x19, #240]
	b	.LBB26_15
.LBB26_22:
	bl	__stack_chk_fail
.Lfunc_end26:
	.size	ufs_mq_async_io_dispatch_work_fn, .Lfunc_end26-ufs_mq_async_io_dispatch_work_fn
                                        // -- End function
	.globl	__ufs_mq_complete_request_remote // -- Begin function __ufs_mq_complete_request_remote
	.p2align	3
	.type	__ufs_mq_complete_request_remote,@function
__ufs_mq_complete_request_remote:       // @__ufs_mq_complete_request_remote
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	w8, [x19, #20]
	mov	w9, #2048
	movk	w9, #32, lsl #16
	tst	w8, w9
	b.eq	.LBB27_3
// %bb.1:
	orr	w1, wzr, #0xc
	mov	x0, x19
	bl	mas_blk_latency_req_check
	ldr	x8, [x19]
	mov	x0, x19
	ldr	x8, [x8, #344]
	blr	x8
.LBB27_2:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.LBB27_3:
	mov	x0, x19
	bl	ufs_mq_complete_request
	b	.LBB27_2
.Lfunc_end27:
	.size	__ufs_mq_complete_request_remote, .Lfunc_end27-__ufs_mq_complete_request_remote
                                        // -- End function
	.p2align	3               // -- Begin function ufs_mq_complete_request
	.type	ufs_mq_complete_request,@function
ufs_mq_complete_request:                // @ufs_mq_complete_request
// %bb.0:
	str	x23, [sp, #-64]!        // 8-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	bl	_mcount
	//APP
	mrs	x23, daif		// arch_local_irq_save
msr	daifset, #2
	//NO_APP
	bl	trace_hardirqs_off
	bl	debug_smp_processor_id
	adrp	x8, __per_cpu_offset
	add	x8, x8, :lo12:__per_cpu_offset
	adrp	x9, blk_cpu_done
	add	x9, x9, :lo12:blk_cpu_done
	ldr	x8, [x8, w0, uxtw #3]
	add	x21, x19, #96           // =96
	mov	x0, x21
	add	x20, x8, x9
	mov	x2, x20
	ldr	x22, [x20, #8]
	mov	x1, x22
	bl	__list_add_valid
	tbz	w0, #0, .LBB28_2
// %bb.1:
	str	x21, [x20, #8]
	stp	x20, x22, [x19, #96]
	str	x21, [x22]
.LBB28_2:
	ldr	x8, [x20]
	cmp	x8, x21
	b.ne	.LBB28_4
// %bb.3:
	orr	w0, wzr, #0x4
	bl	raise_softirq_irqoff
.LBB28_4:
	sxtb	w8, w23
	tbnz	w8, #31, .LBB28_6
// %bb.5:
	bl	trace_hardirqs_on
	//APP
	msr	daif, x23		// arch_local_irq_restore
	//NO_APP
	b	.LBB28_7
.LBB28_6:
	//APP
	msr	daif, x23		// arch_local_irq_restore
	//NO_APP
	bl	trace_hardirqs_off
.LBB28_7:
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldr	x23, [sp], #64          // 8-byte Folded Reload
	ret
.Lfunc_end28:
	.size	ufs_mq_complete_request, .Lfunc_end28-ufs_mq_complete_request
                                        // -- End function
	.globl	ufs_mq_io_guard_work_fn // -- Begin function ufs_mq_io_guard_work_fn
	.p2align	3
	.type	ufs_mq_io_guard_work_fn,@function
ufs_mq_io_guard_work_fn:                // @ufs_mq_io_guard_work_fn
// %bb.0:
	stp	x24, x23, [sp, #-64]!   // 16-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	bl	_mcount
	adrp	x19, io_guard_queue_list_lock
	add	x19, x19, :lo12:io_guard_queue_list_lock
	mov	x0, x19
	bl	_raw_spin_lock
	adrp	x20, mas_io_guard_queue_list
	add	x20, x20, :lo12:mas_io_guard_queue_list
	mov	x0, x19
	ldr	x21, [x20]
	bl	_raw_spin_unlock
	cmp	x21, x20
	b.eq	.LBB29_9
// %bb.1:
	adrp	x19, io_guard_queue_list_lock
	adrp	x22, mas_blk_mq_async_disp_wq
	add	x19, x19, :lo12:io_guard_queue_list_lock
.LBB29_2:                               // =>This Inner Loop Header: Depth=1
	ldr	x24, [x21, #16]
	sub	x23, x21, #472          // =472
	ldr	w8, [x24, #24]
	ldr	w9, [x24, #16]
	cmn	w8, w9
	b.eq	.LBB29_5
// %bb.3:                               //   in Loop: Header=BB29_2 Depth=1
	ldr	w8, [x24, #44]
	ldr	w9, [x24, #40]
	ldr	w10, [x24, #32]
	add	w8, w9, w8
	cmn	w8, w10
	b.ne	.LBB29_5
// %bb.4:                               //   in Loop: Header=BB29_2 Depth=1
	ldr	x0, [x23]
	bl	ufs_mq_sync_dispatch
.LBB29_5:                               //   in Loop: Header=BB29_2 Depth=1
	ldr	w8, [x24, #20]
	cbz	w8, .LBB29_8
// %bb.6:                               //   in Loop: Header=BB29_2 Depth=1
	ldr	w8, [x24, #36]
	cbnz	w8, .LBB29_8
// %bb.7:                               //   in Loop: Header=BB29_2 Depth=1
	ldr	x8, [x23]
	orr	w0, wzr, #0x8
	ldr	x1, [x22, :lo12:mas_blk_mq_async_disp_wq]
	mov	x3, xzr
	ldr	x23, [x8, #2296]
	add	x2, x23, #264           // =264
	bl	queue_delayed_work_on
	bl	ktime_get
	str	x0, [x23, #240]
.LBB29_8:                               //   in Loop: Header=BB29_2 Depth=1
	mov	x0, x19
	bl	_raw_spin_lock
	ldr	x21, [x21]
	mov	x0, x19
	bl	_raw_spin_unlock
	cmp	x21, x20
	b.ne	.LBB29_2
.LBB29_9:
	adrp	x8, mas_blk_io_guard_wq
	adrp	x2, mas_io_guard_work
	add	x2, x2, :lo12:mas_io_guard_work
	ldr	x1, [x8, :lo12:mas_blk_io_guard_wq]
	mov	w3, #1250
	orr	w0, wzr, #0x8
	bl	queue_delayed_work_on
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldp	x24, x23, [sp], #64     // 16-byte Folded Reload
	ret
.Lfunc_end29:
	.size	ufs_mq_io_guard_work_fn, .Lfunc_end29-ufs_mq_io_guard_work_fn
                                        // -- End function
	.globl	ufs_mq_req_alloc_prep   // -- Begin function ufs_mq_req_alloc_prep
	.p2align	3
	.type	ufs_mq_req_alloc_prep,@function
ufs_mq_req_alloc_prep:                  // @ufs_mq_req_alloc_prep
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	w19, w2
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x20, x1
	mov	x21, x0
	bl	_mcount
	orr	x8, x20, #0x800
	tst	w19, #0x1
	csel	x8, x20, x8, ne
	str	x8, [x21, #16]
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.Lfunc_end30:
	.size	ufs_mq_req_alloc_prep, .Lfunc_end30-ufs_mq_req_alloc_prep
                                        // -- End function
	.globl	ufs_mq_req_init         // -- Begin function ufs_mq_req_init
	.p2align	3
	.type	ufs_mq_req_init,@function
ufs_mq_req_init:                        // @ufs_mq_req_init
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	ldr	w8, [x19, #416]
	cbnz	w8, .LBB31_2
// %bb.1:
	orr	w8, wzr, #0x1
	str	w8, [x19, #416]
	str	x20, [x19, #256]
	str	xzr, [x19, #240]
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.LBB31_2:
	adrp	x0, .L.str.31
	adrp	x1, .L.str.7
	add	x0, x0, :lo12:.L.str.31
	add	x1, x1, :lo12:.L.str.7
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.Lfunc_end31:
	.size	ufs_mq_req_init, .Lfunc_end31-ufs_mq_req_init
                                        // -- End function
	.globl	ufs_mq_req_complete     // -- Begin function ufs_mq_req_complete
	.p2align	3
	.type	ufs_mq_req_complete,@function
ufs_mq_req_complete:                    // @ufs_mq_req_complete
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	w21, w2
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x20, x1
	mov	x19, x0
	bl	_mcount
	tbz	w21, #0, .LBB32_3
// %bb.1:
	ldr	w8, [x19, #20]
	and	w8, w8, #0xfc
	orr	w8, w8, #0x3
	cmp	w8, #35                 // =35
	b.eq	.LBB32_3
// %bb.2:
	ldr	x8, [x20, #2296]
	orr	w2, wzr, #0x1
	mov	x0, x19
	ldr	x1, [x8, #488]
	bl	ufs_mq_rq_inflt_update
.LBB32_3:
	ldr	x8, [x19, #8]
	cbz	x8, .LBB32_7
// %bb.4:
	adrp	x11, cpu_number
	ldr	w9, [x8, #128]
	//APP
	.if 1 == 1
661:
	mrs x10, tpidr_el1
662:
.pushsection .altinstructions,"a"
 .word 661b - .
 .if 0 == 0
 .word 663f - .
 .else
 .word 0- .
 .endif
 .hword 11
 .byte 662b-661b
 .byte 664f-663f
.popsection
 .if 0 == 0
.pushsection .altinstr_replacement, "a"
663:
	mrs x10, tpidr_el2
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
	add	x11, x11, :lo12:cpu_number
	ldr	w10, [x10, x11]
	cmp	w9, w10
	b.eq	.LBB32_7
// %bb.5:
	add	w10, w9, #63            // =63
	cmp	w9, #0                  // =0
	adrp	x11, __cpu_online_mask
	csel	w10, w10, w9, lt
	add	x11, x11, :lo12:__cpu_online_mask
	asr	w10, w10, #6
	ldr	x10, [x11, w10, sxtw #3]
	orr	w11, wzr, #0x1
	lsl	x9, x11, x9
	tst	x10, x9
	b.eq	.LBB32_7
// %bb.6:
	adrp	x9, __cfi__ufs_mq_complete_request_remote
	str	x19, [x19, #528]
	add	x9, x9, :lo12:__cfi__ufs_mq_complete_request_remote
	str	wzr, [x19, #536]
	add	x1, x19, #512           // =512
	str	x9, [x19, #520]
	ldr	w0, [x8, #128]
	bl	smp_call_function_single_async
	b	.LBB32_8
.LBB32_7:
	mov	x0, x19
	bl	ufs_mq_complete_request
.LBB32_8:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.Lfunc_end32:
	.size	ufs_mq_req_complete, .Lfunc_end32-ufs_mq_req_complete
                                        // -- End function
	.p2align	3               // -- Begin function ufs_mq_rq_inflt_update
	.type	ufs_mq_rq_inflt_update,@function
ufs_mq_rq_inflt_update:                 // @ufs_mq_rq_inflt_update
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	w20, w2
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x19, x1
	mov	x21, x0
	bl	_mcount
	ldr	w8, [x21, #20]
	tbz	w8, #11, .LBB33_10
// %bb.1:
	mov	w9, #4096
	movk	w9, #32, lsl #16
	tst	w8, w9
	b.ne	.LBB33_13
// %bb.2:
	ldr	x8, [x21, #240]
	tbz	w8, #1, .LBB33_5
// %bb.3:
	and	x8, x8, #0xfffffffffffffffd
	str	x8, [x21, #240]
	ldr	w8, [x19, #12]
	cbz	w8, .LBB33_21
// %bb.4:
	add	x8, x19, #12            // =12
	//APP
	// atomic_sub
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	sub	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
.LBB33_5:
	ldr	w8, [x19, #32]
	cbz	w8, .LBB33_20
// %bb.6:
	add	x8, x19, #32            // =32
	//APP
	// atomic_sub
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	sub	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
.LBB33_7:
	tbz	w20, #0, .LBB33_9
.LBB33_8:
	bl	ktime_get
	str	x0, [x19, #312]
.LBB33_9:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.LBB33_10:
	ldr	w8, [x19, #36]
	cbz	w8, .LBB33_22
// %bb.11:
	add	x8, x19, #36            // =36
	//APP
	// atomic_sub
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	sub	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	tbz	w20, #0, .LBB33_9
// %bb.12:
	bl	ktime_get
	str	x0, [x19, #320]
	b	.LBB33_9
.LBB33_13:
	ldr	w9, [x19, #44]
	ldr	w10, [x19, #40]
	cmn	w10, w9
	b.eq	.LBB33_23
// %bb.14:
	tbnz	w8, #24, .LBB33_17
// %bb.15:
	mov	w9, #4096
	movk	w9, #32, lsl #16
	and	x8, x8, x9
	cbz	x8, .LBB33_17
// %bb.16:
	add	x8, x19, #44            // =44
	//APP
	// atomic_sub
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	sub	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	ldr	x8, [x21, #240]
	tbz	w8, #1, .LBB33_7
	b	.LBB33_18
.LBB33_17:
	add	x8, x19, #40            // =40
	//APP
	// atomic_sub
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	sub	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	ldr	x8, [x21, #240]
	tbz	w8, #1, .LBB33_7
.LBB33_18:
	and	x8, x8, #0xfffffffffffffffd
	str	x8, [x21, #240]
	ldr	w8, [x19, #12]
	cbz	w8, .LBB33_24
// %bb.19:
	add	x8, x19, #12            // =12
	//APP
	// atomic_sub
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	sub	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	tbnz	w20, #0, .LBB33_8
	b	.LBB33_9
.LBB33_20:
	adrp	x0, .L.str.31
	adrp	x1, .L.str.33
	add	x0, x0, :lo12:.L.str.31
	add	x1, x1, :lo12:.L.str.33
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.LBB33_21:
	adrp	x0, .L.str.31
	adrp	x1, .L.str.35
	add	x0, x0, :lo12:.L.str.31
	add	x1, x1, :lo12:.L.str.35
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.LBB33_22:
	adrp	x0, .L.str.31
	adrp	x1, .L.str.34
	add	x0, x0, :lo12:.L.str.31
	add	x1, x1, :lo12:.L.str.34
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.LBB33_23:
	adrp	x0, .L.str.31
	adrp	x1, .L.str.32
	add	x0, x0, :lo12:.L.str.31
	add	x1, x1, :lo12:.L.str.32
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.LBB33_24:
	adrp	x0, .L.str.31
	adrp	x1, .L.str.35
	add	x0, x0, :lo12:.L.str.31
	add	x1, x1, :lo12:.L.str.35
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.Lfunc_end33:
	.size	ufs_mq_rq_inflt_update, .Lfunc_end33-ufs_mq_rq_inflt_update
                                        // -- End function
	.globl	ufs_mq_req_deinit       // -- Begin function ufs_mq_req_deinit
	.p2align	3
	.type	ufs_mq_req_deinit,@function
ufs_mq_req_deinit:                      // @ufs_mq_req_deinit
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	str	wzr, [x19, #416]
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end34:
	.size	ufs_mq_req_deinit, .Lfunc_end34-ufs_mq_req_deinit
                                        // -- End function
	.globl	ufs_mq_req_insert       // -- Begin function ufs_mq_req_insert
	.p2align	3
	.type	ufs_mq_req_insert,@function
ufs_mq_req_insert:                      // @ufs_mq_req_insert
// %bb.0:
	str	x23, [sp, #-64]!        // 8-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	x19, x1
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	mov	x20, x0
	bl	_mcount
	ldr	x8, [x20]
	cmp	x8, x19
	b.ne	.LBB35_6
// %bb.1:
	ldr	w8, [x20, #20]
	tbnz	w8, #11, .LBB35_3
.LBB35_2:
	and	w8, w8, #0xfc
	orr	w8, w8, #0x3
	cmp	w8, #35                 // =35
	b.ne	.LBB35_8
.LBB35_3:
	mov	x0, x20
	mov	x1, x19
	bl	ufs_mq_insert_sync_list
.LBB35_4:
	ldr	x8, [x20]
	cmp	x8, x19
	b.ne	.LBB35_7
.LBB35_5:
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldr	x23, [sp], #64          // 8-byte Folded Reload
	ret
.LBB35_6:
	bl	dump_stack
	ldr	w8, [x20, #20]
	tbz	w8, #11, .LBB35_2
	b	.LBB35_3
.LBB35_7:
	bl	dump_stack
	b	.LBB35_5
.LBB35_8:
	ldr	x8, [x19, #2304]
	cbz	x8, .LBB35_4
// %bb.9:
	ldr	x23, [x8, #176]
	cbz	x23, .LBB35_4
// %bb.10:
	ldr	x8, [x23]
	ldr	x8, [x8, #16]
	cbz	x8, .LBB35_4
// %bb.11:
	ldr	x8, [x19, #2296]
	mov	w1, #9
	mov	x0, x20
	ldr	x21, [x8, #488]
	bl	mas_blk_latency_req_check
	add	x22, x21, #176          // =176
	mov	x0, x22
	bl	_raw_spin_lock_irqsave
	ldr	x8, [x23]
	mov	x23, x0
	mov	x0, x20
	mov	x1, x21
	ldr	x8, [x8, #16]
	blr	x8
	add	x8, x21, #280           // =280
	mov	x0, x22
	mov	x1, x23
	//APP
	// atomic_add
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	bl	_raw_spin_unlock_irqrestore
	b	.LBB35_4
.Lfunc_end35:
	.size	ufs_mq_req_insert, .Lfunc_end35-ufs_mq_req_insert
                                        // -- End function
	.globl	ufs_mq_req_requeue      // -- Begin function ufs_mq_req_requeue
	.p2align	3
	.type	ufs_mq_req_requeue,@function
ufs_mq_req_requeue:                     // @ufs_mq_req_requeue
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	mov	x0, x20
	str	wzr, [x20, #396]
	mov	x1, x19
	bl	ufs_mq_req_insert
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end36:
	.size	ufs_mq_req_requeue, .Lfunc_end36-ufs_mq_req_requeue
                                        // -- End function
	.globl	ufs_mq_req_timeout_handler // -- Begin function ufs_mq_req_timeout_handler
	.p2align	3
	.type	ufs_mq_req_timeout_handler,@function
ufs_mq_req_timeout_handler:             // @ufs_mq_req_timeout_handler
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	bl	_mcount
	ldr	x8, [x19]
	ldr	w10, [x19, #20]
	ldr	x9, [x8, #2296]
	ldr	x21, [x8, #400]
	and	w8, w10, #0xfc
	orr	w8, w8, #0x3
	cmp	w8, #35                 // =35
	ldr	x20, [x9, #488]
	b.eq	.LBB37_2
// %bb.1:
	orr	w2, wzr, #0x1
	mov	x0, x19
	mov	x1, x20
	bl	ufs_mq_rq_inflt_update
.LBB37_2:
	ldr	x8, [x21, #24]
	cbz	x8, .LBB37_10
// %bb.3:
	mov	x0, x19
	mov	w1, wzr
	blr	x8
	cmp	w0, #2                  // =2
	b.eq	.LBB37_15
// %bb.4:
	cmp	w0, #1                  // =1
	b.eq	.LBB37_10
// %bb.5:
	cbnz	w0, .LBB37_17
// %bb.6:
	ldr	x8, [x19, #8]
	cbz	x8, .LBB37_16
// %bb.7:
	adrp	x11, cpu_number
	ldr	w9, [x8, #128]
	//APP
	.if 1 == 1
661:
	mrs x10, tpidr_el1
662:
.pushsection .altinstructions,"a"
 .word 661b - .
 .if 0 == 0
 .word 663f - .
 .else
 .word 0- .
 .endif
 .hword 11
 .byte 662b-661b
 .byte 664f-663f
.popsection
 .if 0 == 0
.pushsection .altinstr_replacement, "a"
663:
	mrs x10, tpidr_el2
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
	add	x11, x11, :lo12:cpu_number
	ldr	w10, [x10, x11]
	cmp	w9, w10
	b.eq	.LBB37_16
// %bb.8:
	add	w10, w9, #63            // =63
	cmp	w9, #0                  // =0
	adrp	x11, __cpu_online_mask
	csel	w10, w10, w9, lt
	add	x11, x11, :lo12:__cpu_online_mask
	asr	w10, w10, #6
	ldr	x10, [x11, w10, sxtw #3]
	orr	w11, wzr, #0x1
	lsl	x9, x11, x9
	tst	x10, x9
	b.eq	.LBB37_16
// %bb.9:
	adrp	x9, __cfi__ufs_mq_complete_request_remote
	str	x19, [x19, #528]
	add	x9, x9, :lo12:__cfi__ufs_mq_complete_request_remote
	str	wzr, [x19, #536]
	add	x1, x19, #512           // =512
	str	x9, [x19, #520]
	ldr	w0, [x8, #128]
	bl	smp_call_function_single_async
	b	.LBB37_17
.LBB37_10:
	ldr	w8, [x19, #20]
	and	w9, w8, #0xfc
	orr	w9, w9, #0x3
	cmp	w9, #35                 // =35
	b.eq	.LBB37_14
// %bb.11:
	tbz	w8, #11, .LBB37_18
// %bb.12:
	mov	w9, #4096
	movk	w9, #32, lsl #16
	tst	w8, w9
	b.ne	.LBB37_19
// %bb.13:
	add	x8, x20, #32            // =32
	//APP
	// atomic_add
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
.LBB37_14:
	mov	x0, x19
	bl	blk_add_timer
	add	x8, x19, #488           // =488
	//APP
	// atomic64_andnot
	prfm	pstl1strm, [x8]
1:	ldxr	x9, [x8]
	bic	x9, x9, #1
	stxr	w10, x9, [x8]
	cbnz	w10, 1b
	//NO_APP
	b	.LBB37_17
.LBB37_15:
	orr	w1, wzr, #0x1
	mov	x0, x19
	bl	blk_mq_requeue_request
	ldr	x0, [x19]
	bl	blk_mq_kick_requeue_list
	b	.LBB37_17
.LBB37_16:
	mov	x0, x19
	bl	ufs_mq_complete_request
.LBB37_17:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.LBB37_18:
	add	x8, x20, #36            // =36
	//APP
	// atomic_add
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	b	.LBB37_14
.LBB37_19:
	tbnz	w8, #24, .LBB37_22
// %bb.20:
	mov	w9, #4096
	movk	w9, #32, lsl #16
	and	x8, x8, x9
	cbz	x8, .LBB37_22
// %bb.21:
	add	x8, x20, #44            // =44
	//APP
	// atomic_add
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	b	.LBB37_14
.LBB37_22:
	add	x8, x20, #40            // =40
	//APP
	// atomic_add
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	b	.LBB37_14
.Lfunc_end37:
	.size	ufs_mq_req_timeout_handler, .Lfunc_end37-ufs_mq_req_timeout_handler
                                        // -- End function
	.globl	ufs_mq_ctx_put          // -- Begin function ufs_mq_ctx_put
	.p2align	3
	.type	ufs_mq_ctx_put,@function
ufs_mq_ctx_put:                         // @ufs_mq_ctx_put
// %bb.0:
	stp	x29, x30, [sp, #-16]!   // 16-byte Folded Spill
	mov	x29, sp
	bl	_mcount
	orr	w0, wzr, #0x1
	//APP
	//NO_APP
	bl	preempt_count_sub
	ldp	x29, x30, [sp], #16     // 16-byte Folded Reload
	ret
.Lfunc_end38:
	.size	ufs_mq_ctx_put, .Lfunc_end38-ufs_mq_ctx_put
                                        // -- End function
	.globl	ufs_mq_hctx_get_by_req  // -- Begin function ufs_mq_hctx_get_by_req
	.p2align	3
	.type	ufs_mq_hctx_get_by_req,@function
ufs_mq_hctx_get_by_req:                 // @ufs_mq_hctx_get_by_req
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	ldr	x8, [x20, #256]
	ldr	x9, [x20]
	ldrsw	x8, [x8, #128]
	ldr	x10, [x9, #408]
	ldr	x9, [x9, #432]
	ldr	w8, [x10, x8, lsl #2]
	ldr	x8, [x9, x8, lsl #3]
	str	x8, [x19]
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end39:
	.size	ufs_mq_hctx_get_by_req, .Lfunc_end39-ufs_mq_hctx_get_by_req
                                        // -- End function
	.globl	ufs_mq_exec_queue       // -- Begin function ufs_mq_exec_queue
	.p2align	3
	.type	ufs_mq_exec_queue,@function
ufs_mq_exec_queue:                      // @ufs_mq_exec_queue
// %bb.0:
	stp	x22, x21, [sp, #-48]!   // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	bl	_mcount
	mov	x0, x19
	bl	ufs_mq_sync_dispatch
	ldr	x8, [x19, #2304]
	cbz	x8, .LBB40_6
// %bb.1:
	ldr	x22, [x8, #176]
	cbz	x22, .LBB40_6
// %bb.2:
	ldr	x8, [x22]
	ldr	x8, [x8, #48]
	cbz	x8, .LBB40_6
// %bb.3:
	ldr	x8, [x19, #2296]
	ldr	x20, [x8, #488]
	add	x21, x20, #176          // =176
	mov	x0, x21
	bl	_raw_spin_lock_irqsave
	ldr	x8, [x22]
	mov	x22, x0
	mov	x0, x20
	ldr	x8, [x8, #48]
	blr	x8
	mov	w20, w0
	mov	x0, x21
	mov	x1, x22
	bl	_raw_spin_unlock_irqrestore
	tbnz	w20, #0, .LBB40_5
// %bb.4:
	ldr	x19, [x19, #2296]
	adrp	x8, mas_blk_mq_async_disp_wq
	orr	w0, wzr, #0x8
	mov	x3, xzr
	ldr	x1, [x8, :lo12:mas_blk_mq_async_disp_wq]
	add	x2, x19, #264           // =264
	bl	queue_delayed_work_on
	bl	ktime_get
	str	x0, [x19, #240]
.LBB40_5:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldp	x22, x21, [sp], #48     // 16-byte Folded Reload
	ret
.LBB40_6:
	adrp	x0, .L.str.31
	adrp	x1, .L.str.36
	add	x0, x0, :lo12:.L.str.31
	add	x1, x1, :lo12:.L.str.36
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.Lfunc_end40:
	.size	ufs_mq_exec_queue, .Lfunc_end40-ufs_mq_exec_queue
                                        // -- End function
	.globl	ufs_mq_run_hw_queue     // -- Begin function ufs_mq_run_hw_queue
	.p2align	3
	.type	ufs_mq_run_hw_queue,@function
ufs_mq_run_hw_queue:                    // @ufs_mq_run_hw_queue
// %bb.0:
	stp	x22, x21, [sp, #-48]!   // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	bl	_mcount
	ldr	x20, [x19, #2296]
	adrp	x8, mas_blk_mq_sync_disp_wq
	orr	w0, wzr, #0x8
	mov	x3, xzr
	ldr	x1, [x8, :lo12:mas_blk_mq_sync_disp_wq]
	add	x2, x20, #32            // =32
	bl	queue_delayed_work_on
	bl	ktime_get
	str	x0, [x20, #8]
	ldr	x8, [x19, #2304]
	cbz	x8, .LBB41_6
// %bb.1:
	ldr	x22, [x8, #176]
	cbz	x22, .LBB41_6
// %bb.2:
	ldr	x8, [x22]
	ldr	x8, [x8, #48]
	cbz	x8, .LBB41_6
// %bb.3:
	ldr	x8, [x19, #2296]
	ldr	x20, [x8, #488]
	add	x21, x20, #176          // =176
	mov	x0, x21
	bl	_raw_spin_lock_irqsave
	ldr	x8, [x22]
	mov	x22, x0
	mov	x0, x20
	ldr	x8, [x8, #48]
	blr	x8
	mov	w20, w0
	mov	x0, x21
	mov	x1, x22
	bl	_raw_spin_unlock_irqrestore
	tbnz	w20, #0, .LBB41_5
// %bb.4:
	ldr	x19, [x19, #2296]
	adrp	x8, mas_blk_mq_async_disp_wq
	orr	w0, wzr, #0x8
	mov	x3, xzr
	ldr	x1, [x8, :lo12:mas_blk_mq_async_disp_wq]
	add	x2, x19, #264           // =264
	bl	queue_delayed_work_on
	bl	ktime_get
	str	x0, [x19, #240]
.LBB41_5:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldp	x22, x21, [sp], #48     // 16-byte Folded Reload
	ret
.LBB41_6:
	adrp	x0, .L.str.31
	adrp	x1, .L.str.36
	add	x0, x0, :lo12:.L.str.31
	add	x1, x1, :lo12:.L.str.36
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.Lfunc_end41:
	.size	ufs_mq_run_hw_queue, .Lfunc_end41-ufs_mq_run_hw_queue
                                        // -- End function
	.globl	ufs_mq_run_requeue      // -- Begin function ufs_mq_run_requeue
	.p2align	3
	.type	ufs_mq_run_requeue,@function
ufs_mq_run_requeue:                     // @ufs_mq_run_requeue
// %bb.0:
	stp	x22, x21, [sp, #-48]!   // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	bl	_mcount
	ldr	x20, [x19, #2296]
	adrp	x8, mas_blk_mq_sync_disp_wq
	orr	w0, wzr, #0x8
	mov	x3, xzr
	ldr	x1, [x8, :lo12:mas_blk_mq_sync_disp_wq]
	add	x2, x20, #32            // =32
	bl	queue_delayed_work_on
	bl	ktime_get
	str	x0, [x20, #8]
	ldr	x8, [x19, #2304]
	cbz	x8, .LBB42_6
// %bb.1:
	ldr	x22, [x8, #176]
	cbz	x22, .LBB42_6
// %bb.2:
	ldr	x8, [x22]
	ldr	x8, [x8, #48]
	cbz	x8, .LBB42_6
// %bb.3:
	ldr	x8, [x19, #2296]
	ldr	x20, [x8, #488]
	add	x21, x20, #176          // =176
	mov	x0, x21
	bl	_raw_spin_lock_irqsave
	ldr	x8, [x22]
	mov	x22, x0
	mov	x0, x20
	ldr	x8, [x8, #48]
	blr	x8
	mov	w20, w0
	mov	x0, x21
	mov	x1, x22
	bl	_raw_spin_unlock_irqrestore
	tbnz	w20, #0, .LBB42_5
// %bb.4:
	ldr	x19, [x19, #2296]
	adrp	x8, mas_blk_mq_async_disp_wq
	orr	w0, wzr, #0x8
	mov	x3, xzr
	ldr	x1, [x8, :lo12:mas_blk_mq_async_disp_wq]
	add	x2, x19, #264           // =264
	bl	queue_delayed_work_on
	bl	ktime_get
	str	x0, [x19, #240]
.LBB42_5:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldp	x22, x21, [sp], #48     // 16-byte Folded Reload
	ret
.LBB42_6:
	adrp	x0, .L.str.31
	adrp	x1, .L.str.36
	add	x0, x0, :lo12:.L.str.31
	add	x1, x1, :lo12:.L.str.36
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.Lfunc_end42:
	.size	ufs_mq_run_requeue, .Lfunc_end42-ufs_mq_run_requeue
                                        // -- End function
	.globl	ufs_mq_poll_enable      // -- Begin function ufs_mq_poll_enable
	.p2align	3
	.type	ufs_mq_poll_enable,@function
ufs_mq_poll_enable:                     // @ufs_mq_poll_enable
// %bb.0:
	stp	x24, x23, [sp, #-64]!   // 16-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	bl	_mcount
	adrp	x24, __cpu_online_mask
	mov	w20, wzr
	mov	w21, wzr
	adrp	x22, __cpu_possible_mask
	orr	w23, wzr, #0x1
	add	x24, x24, :lo12:__cpu_online_mask
	b	.LBB43_2
.LBB43_1:                               //   in Loop: Header=BB43_2 Depth=1
	add	w8, w21, #63            // =63
	cmp	w21, #0                 // =0
	csel	w8, w8, w21, lt
	asr	w8, w8, #6
	lsl	x9, x23, x21
	ldr	x8, [x24, w8, sxtw #3]
	add	w21, w21, #1            // =1
	tst	x8, x9
	cinc	w20, w20, ne
.LBB43_2:                               // =>This Inner Loop Header: Depth=1
	ldrb	w0, [x22, :lo12:__cpu_possible_mask]
	bl	__sw_hweight64
	cmp	w21, w0
	b.lo	.LBB43_1
// %bb.3:
	cmp	w20, #1                 // =1
	cset	w8, hi
	strb	w8, [x19]
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldp	x24, x23, [sp], #64     // 16-byte Folded Reload
	ret
.Lfunc_end43:
	.size	ufs_mq_poll_enable, .Lfunc_end43-ufs_mq_poll_enable
                                        // -- End function
	.globl	ufs_order_panic_wait_datasync_handle // -- Begin function ufs_order_panic_wait_datasync_handle
	.p2align	3
	.type	ufs_order_panic_wait_datasync_handle,@function
ufs_order_panic_wait_datasync_handle:   // @ufs_order_panic_wait_datasync_handle
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	x8, [x19, #1512]
	ldr	w9, [x8, #24]
	ldr	w10, [x8, #16]
	add	w9, w10, w9
	cmp	w9, #1                  // =1
	cset	w0, lt
	cmp	w9, #0                  // =0
	cset	w9, gt
	strb	w9, [x8, #920]
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end44:
	.size	ufs_order_panic_wait_datasync_handle, .Lfunc_end44-ufs_order_panic_wait_datasync_handle
                                        // -- End function
	.globl	ufs_order_panic_datasync_handle // -- Begin function ufs_order_panic_datasync_handle
	.p2align	3
	.type	ufs_order_panic_datasync_handle,@function
ufs_order_panic_datasync_handle:        // @ufs_order_panic_datasync_handle
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	x8, [x19, #1512]
	adrp	x9, mas_blk_mq_sync_disp_wq
	orr	w10, wzr, #0x1
	orr	w0, wzr, #0x8
	ldr	x1, [x9, :lo12:mas_blk_mq_sync_disp_wq]
	mov	x3, xzr
	add	x2, x8, #720            // =720
	strb	w10, [x8, #920]
	bl	queue_delayed_work_on
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end45:
	.size	ufs_order_panic_datasync_handle, .Lfunc_end45-ufs_order_panic_datasync_handle
                                        // -- End function
	.globl	ufs_mq_write_throttle_check_timer_prepare // -- Begin function ufs_mq_write_throttle_check_timer_prepare
	.p2align	3
	.type	ufs_mq_write_throttle_check_timer_prepare,@function
ufs_mq_write_throttle_check_timer_prepare: // @ufs_mq_write_throttle_check_timer_prepare
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	sub	x0, x19, #440           // =440
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end46:
	.size	ufs_mq_write_throttle_check_timer_prepare, .Lfunc_end46-ufs_mq_write_throttle_check_timer_prepare
                                        // -- End function
	.globl	ufs_mq_sync_burst_check_timer_prepare // -- Begin function ufs_mq_sync_burst_check_timer_prepare
	.p2align	3
	.type	ufs_mq_sync_burst_check_timer_prepare,@function
ufs_mq_sync_burst_check_timer_prepare:  // @ufs_mq_sync_burst_check_timer_prepare
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	sub	x0, x19, #336           // =336
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end47:
	.size	ufs_mq_sync_burst_check_timer_prepare, .Lfunc_end47-ufs_mq_sync_burst_check_timer_prepare
                                        // -- End function
	.globl	ufs_tagset_power_off_proc // -- Begin function ufs_tagset_power_off_proc
	.p2align	3
	.type	ufs_tagset_power_off_proc,@function
ufs_tagset_power_off_proc:              // @ufs_tagset_power_off_proc
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	x19, [x19, #1512]
	adrp	x8, mas_blk_mq_sync_disp_wq
	orr	w9, wzr, #0x1
	orr	w0, wzr, #0x8
	ldr	x1, [x8, :lo12:mas_blk_mq_sync_disp_wq]
	mov	x3, xzr
	add	x2, x19, #720           // =720
	strb	w9, [x19, #920]
	bl	queue_delayed_work_on
	adrp	x8, jiffies
	add	x0, x19, #624           // =624
	ldr	x8, [x8, :lo12:jiffies]
	add	x1, x8, #125            // =125
	bl	mod_timer
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end48:
	.size	ufs_tagset_power_off_proc, .Lfunc_end48-ufs_tagset_power_off_proc
                                        // -- End function
	.globl	ufs_mq_status_dump      // -- Begin function ufs_mq_status_dump
	.p2align	3
	.type	ufs_mq_status_dump,@function
ufs_mq_status_dump:                     // @ufs_mq_status_dump
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	w19, w1
	mov	x20, x0
	bl	_mcount
	adrp	x9, .L.str.38
	ldr	x8, [x20, #2296]
	adrp	x10, .L.str.37
	add	x9, x9, :lo12:.L.str.38
	add	x10, x10, :lo12:.L.str.37
	cmp	w19, #1                 // =1
	csel	x19, x10, x9, eq
	cbz	x8, .LBB49_2
// %bb.1:
	ldr	x20, [x8, #488]
	cbnz	x20, .LBB49_3
.LBB49_2:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.LBB49_3:
	ldr	w2, [x20, #28]
	adrp	x0, .L.str.8
	add	x0, x0, :lo12:.L.str.8
	mov	x1, x19
	bl	printk
	ldr	w2, [x20, #24]
	adrp	x0, .L.str.9
	ldr	w3, [x20, #16]
	add	x0, x0, :lo12:.L.str.9
	ldr	w4, [x20, #20]
	mov	x1, x19
	bl	printk
	ldr	w2, [x20, #44]
	adrp	x0, .L.str.10
	ldr	w3, [x20, #40]
	add	x0, x0, :lo12:.L.str.10
	ldr	w4, [x20, #32]
	mov	x1, x19
	ldr	w5, [x20, #36]
	ldr	w6, [x20, #12]
	bl	printk
	b	.LBB49_2
.Lfunc_end49:
	.size	ufs_mq_status_dump, .Lfunc_end49-ufs_mq_status_dump
                                        // -- End function
	.globl	ufs_mq_iosched_init     // -- Begin function ufs_mq_iosched_init
	.p2align	3
	.type	ufs_mq_iosched_init,@function
ufs_mq_iosched_init:                    // @ufs_mq_iosched_init
// %bb.0:
	stp	x24, x23, [sp, #-64]!   // 16-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	x20, x0
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	bl	_mcount
	adrp	x23, kmalloc_caches
	add	x23, x23, :lo12:kmalloc_caches
	mov	w21, #32960
	movk	w21, #96, lsl #16
	ldr	x0, [x23, #72]
	orr	w2, wzr, #0x1f0
	mov	w1, w21
	bl	kmem_cache_alloc_trace
	cbz	x0, .LBB50_21
// %bb.1:
	mov	x19, x0
	mov	x0, x20
	bl	mas_blk_get_lld
	ldrb	w8, [x0, #1504]
	mov	x22, x0
	cbz	w8, .LBB50_11
// %bb.2:
	ldr	x8, [x22, #1512]
	add	x8, x8, #620            // =620
	//APP
	// atomic_add
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	add	w9, w9, #1
	stxr	w10, w9, [x8]
	cbnz	w10, 1b
	//NO_APP
	ldr	x21, [x22, #1512]
.LBB50_3:
	cbz	x21, .LBB50_18
.LBB50_4:
	ldr	x8, [x20, #2304]
	cbz	x8, .LBB50_17
// %bb.5:
	ldr	x23, [x8, #176]
	cbz	x23, .LBB50_17
// %bb.6:
	ldr	x8, [x23]
	ldr	x8, [x8, #8]
	cbz	x8, .LBB50_8
// %bb.7:
	add	x22, x21, #176          // =176
	mov	x0, x22
	bl	_raw_spin_lock_irqsave
	ldr	x8, [x23]
	mov	x23, x0
	mov	x0, x21
	ldr	x8, [x8, #8]
	blr	x8
	mov	x0, x22
	mov	x1, x23
	bl	_raw_spin_unlock_irqrestore
.LBB50_8:
	adrp	x1, .L.str.12
	adrp	x2, ufs_mq_iosched_init.__key
	mov	x23, #68719476704
	add	x0, x19, #64            // =64
	add	x1, x1, :lo12:.L.str.12
	add	x2, x2, :lo12:ufs_mq_iosched_init.__key
	str	x23, [x19, #32]
	mov	w3, wzr
	bl	lockdep_init_map
	adrp	x22, delayed_work_timer_fn
	adrp	x9, __cfi_ufs_mq_sync_io_dispatch_work_fn
	add	x22, x22, :lo12:delayed_work_timer_fn
	adrp	x3, .L.str.14
	adrp	x4, ufs_mq_iosched_init.__key.13
	add	x8, x19, #40            // =40
	add	x9, x9, :lo12:__cfi_ufs_mq_sync_io_dispatch_work_fn
	add	x0, x19, #120           // =120
	add	x3, x3, :lo12:.L.str.14
	str	x8, [x19, #40]
	add	x4, x4, :lo12:ufs_mq_iosched_init.__key.13
	stp	x8, x9, [x19, #48]
	orr	w2, wzr, #0x200000
	mov	x1, x22
	bl	init_timer_key
	adrp	x1, .L.str.16
	str	x20, [x19, #232]
	adrp	x2, ufs_mq_iosched_init.__key.15
	str	x23, [x19, #264]
	add	x0, x19, #296           // =296
	add	x1, x1, :lo12:.L.str.16
	add	x2, x2, :lo12:ufs_mq_iosched_init.__key.15
	mov	w3, wzr
	bl	lockdep_init_map
	adrp	x9, __cfi_ufs_mq_async_io_dispatch_work_fn
	adrp	x3, .L.str.18
	adrp	x4, ufs_mq_iosched_init.__key.17
	add	x8, x19, #272           // =272
	add	x9, x9, :lo12:__cfi_ufs_mq_async_io_dispatch_work_fn
	add	x0, x19, #352           // =352
	add	x3, x3, :lo12:.L.str.18
	str	x8, [x19, #272]
	add	x4, x4, :lo12:ufs_mq_iosched_init.__key.17
	stp	x8, x9, [x19, #280]
	orr	w2, wzr, #0x200000
	mov	x1, x22
	bl	init_timer_key
	adrp	x0, io_guard_queue_list_lock
	str	x20, [x19, #464]
	add	x0, x0, :lo12:io_guard_queue_list_lock
	str	x20, [x19]
	str	x21, [x19, #488]
	str	x19, [x20, #2296]
	bl	_raw_spin_lock
	adrp	x23, mas_io_guard_queue_list
	add	x23, x23, :lo12:mas_io_guard_queue_list
	add	x22, x19, #472          // =472
	mov	x0, x22
	ldr	x21, [x23, #8]
	mov	x2, x23
	mov	x1, x21
	bl	__list_add_valid
	tbz	w0, #0, .LBB50_10
// %bb.9:
	str	x22, [x23, #8]
	stp	x23, x21, [x19, #472]
	str	x22, [x21]
.LBB50_10:
	adrp	x0, io_guard_queue_list_lock
	add	x0, x0, :lo12:io_guard_queue_list_lock
	bl	_raw_spin_unlock
	adrp	x8, mas_blk_io_guard_wq
	adrp	x2, mas_io_guard_work
	add	x2, x2, :lo12:mas_io_guard_work
	ldr	x1, [x8, :lo12:mas_blk_io_guard_wq]
	mov	w3, #1250
	orr	w0, wzr, #0x8
	bl	queue_delayed_work_on
	adrp	x1, __cfi_ufs_mq_make_request
	add	x1, x1, :lo12:__cfi_ufs_mq_make_request
	mov	x0, x20
	bl	blk_queue_make_request
	mov	w0, wzr
	b	.LBB50_20
.LBB50_11:
	ldr	x0, [x23, #80]
	mov	w2, #928
	mov	w1, w21
	bl	kmem_cache_alloc_trace
	cbz	x0, .LBB50_18
// %bb.12:
	adrp	x1, __ufs_turbo_check_timer_expire
	adrp	x3, .L.str.39
	adrp	x4, ufs_mq_sched_ds_lld_init.__key
	mov	x21, x0
	orr	w23, wzr, #0x1
	add	x0, x0, #624            // =624
	add	x1, x1, :lo12:__ufs_turbo_check_timer_expire
	add	x3, x3, :lo12:.L.str.39
	str	w23, [x21, #620]
	add	x4, x4, :lo12:ufs_mq_sched_ds_lld_init.__key
	mov	w2, wzr
	bl	init_timer_key
	adrp	x1, .L.str.41
	strb	wzr, [x21, #920]
	adrp	x2, ufs_mq_sched_ds_lld_init.__key.40
	mov	x8, #68719476704
	add	x0, x21, #752           // =752
	add	x1, x1, :lo12:.L.str.41
	add	x2, x2, :lo12:ufs_mq_sched_ds_lld_init.__key.40
	str	x8, [x21, #720]
	mov	w3, wzr
	bl	lockdep_init_map
	adrp	x9, ufs_datasync_work
	adrp	x1, delayed_work_timer_fn
	adrp	x3, .L.str.43
	adrp	x4, ufs_mq_sched_ds_lld_init.__key.42
	add	x8, x21, #728           // =728
	add	x9, x9, :lo12:ufs_datasync_work
	add	x0, x21, #808           // =808
	add	x1, x1, :lo12:delayed_work_timer_fn
	str	x8, [x21, #728]
	add	x3, x3, :lo12:.L.str.43
	str	x8, [x21, #736]
	add	x4, x4, :lo12:ufs_mq_sched_ds_lld_init.__key.42
	str	x9, [x21, #744]
	orr	w2, wzr, #0x200000
	bl	init_timer_key
	adrp	x1, .L.str.53
	str	wzr, [x21, #16]
	adrp	x2, ufs_mq_dispatch_list_init.__key
	str	wzr, [x21, #20]
	add	x8, x21, #128           // =128
	str	wzr, [x21, #24]
	add	x9, x21, #152           // =152
	str	wzr, [x21, #28]
	add	x0, x21, #48            // =48
	add	x1, x1, :lo12:.L.str.53
	str	x8, [x21, #128]
	add	x2, x2, :lo12:ufs_mq_dispatch_list_init.__key
	str	x8, [x21, #136]
	str	x9, [x21, #152]
	str	x9, [x21, #160]
	bl	__raw_spin_lock_init
	adrp	x1, .L.str.55
	adrp	x2, ufs_mq_dispatch_list_init.__key.54
	add	x0, x21, #176           // =176
	add	x1, x1, :lo12:.L.str.55
	add	x2, x2, :lo12:ufs_mq_dispatch_list_init.__key.54
	bl	__raw_spin_lock_init
	mov	x10, #28
	str	wzr, [x21, #144]
	mov	w8, #5
	str	wzr, [x21, #168]
	add	x9, x21, #284           // =284
	str	wzr, [x21, #280]
	movk	x10, #14, lsl #32
	str	w8, [x21, #8]
	str	x10, [x9]
	str	wzr, [x21, #12]
	str	wzr, [x21, #36]
	str	wzr, [x21, #44]
	str	wzr, [x21, #40]
	str	wzr, [x21, #32]
	bl	ktime_get
	str	x0, [x21, #296]
	bl	ktime_get
	str	x0, [x21, #304]
	bl	ktime_get
	str	x0, [x21, #312]
	bl	ktime_get
	str	x0, [x21, #320]
	bl	ktime_get
	add	x8, x21, #336           // =336
	str	x0, [x21, #328]
	adrp	x1, __cfi_ufs_mq_sync_burst_check_timer_expire
	adrp	x3, .L.str.45
	adrp	x4, ufs_mq_sched_ds_lld_init.__key.44
	add	x1, x1, :lo12:__cfi_ufs_mq_sync_burst_check_timer_expire
	add	x3, x3, :lo12:.L.str.45
	add	x4, x4, :lo12:ufs_mq_sched_ds_lld_init.__key.44
	mov	x0, x8
	mov	w2, wzr
	bl	init_timer_key
	adrp	x1, __cfi_ufs_mq_write_throttle_check_timer_expire
	adrp	x3, .L.str.47
	adrp	x4, ufs_mq_sched_ds_lld_init.__key.46
	add	x0, x21, #440           // =440
	add	x1, x1, :lo12:__cfi_ufs_mq_write_throttle_check_timer_expire
	add	x3, x3, :lo12:.L.str.47
	add	x4, x4, :lo12:ufs_mq_sched_ds_lld_init.__key.46
	mov	w2, wzr
	bl	init_timer_key
	adrp	x1, .L.str.49
	adrp	x2, ufs_mq_sched_ds_lld_init.__key.48
	add	x0, x21, #536           // =536
	add	x1, x1, :lo12:.L.str.49
	add	x2, x2, :lo12:ufs_mq_sched_ds_lld_init.__key.48
	bl	__raw_spin_lock_init
	adrp	x0, .L.str.57
	strb	w23, [x21, #616]
	adrp	x3, ufs_mq_workqueue_init.__key
	str	wzr, [x21, #432]
	adrp	x4, .L.str.56
	str	wzr, [x21, #436]
	add	x0, x0, :lo12:.L.str.57
	add	x3, x3, :lo12:ufs_mq_workqueue_init.__key
	add	x4, x4, :lo12:.L.str.56
	orr	w1, wzr, #0x10
	mov	w2, wzr
	bl	__alloc_workqueue_key
	adrp	x23, mas_blk_mq_sync_disp_wq
	str	x0, [x23, :lo12:mas_blk_mq_sync_disp_wq]
	cbz	x0, .LBB50_22
// %bb.13:
	adrp	x0, .L.str.61
	adrp	x3, ufs_mq_workqueue_init.__key.59
	adrp	x4, .L.str.60
	add	x0, x0, :lo12:.L.str.61
	add	x3, x3, :lo12:ufs_mq_workqueue_init.__key.59
	add	x4, x4, :lo12:.L.str.60
	orr	w1, wzr, #0x2
	mov	w2, wzr
	bl	__alloc_workqueue_key
	adrp	x24, mas_blk_mq_async_disp_wq
	str	x0, [x24, :lo12:mas_blk_mq_async_disp_wq]
	cbz	x0, .LBB50_24
// %bb.14:
	adrp	x0, .L.str.64
	adrp	x3, ufs_mq_workqueue_init.__key.62
	adrp	x4, .L.str.63
	add	x0, x0, :lo12:.L.str.64
	add	x3, x3, :lo12:ufs_mq_workqueue_init.__key.62
	add	x4, x4, :lo12:.L.str.63
	orr	w1, wzr, #0x6
	mov	w2, wzr
	bl	__alloc_workqueue_key
	adrp	x8, mas_blk_io_guard_wq
	str	x0, [x8, :lo12:mas_blk_io_guard_wq]
	cbz	x0, .LBB50_23
// %bb.15:
	adrp	x23, mas_io_guard_work
	add	x23, x23, :lo12:mas_io_guard_work
	adrp	x1, .L.str.66
	adrp	x2, ufs_mq_workqueue_init.__key.65
	mov	x8, #68719476704
	add	x0, x23, #32            // =32
	add	x1, x1, :lo12:.L.str.66
	add	x2, x2, :lo12:ufs_mq_workqueue_init.__key.65
	str	x8, [x23]
	mov	w3, wzr
	bl	lockdep_init_map
	adrp	x9, __cfi_ufs_mq_io_guard_work_fn
	adrp	x1, delayed_work_timer_fn
	adrp	x3, .L.str.68
	adrp	x4, ufs_mq_workqueue_init.__key.67
	add	x8, x23, #8             // =8
	add	x9, x9, :lo12:__cfi_ufs_mq_io_guard_work_fn
	add	x0, x23, #88            // =88
	add	x1, x1, :lo12:delayed_work_timer_fn
	str	x8, [x23, #8]
	add	x3, x3, :lo12:.L.str.68
	stp	x8, x9, [x23, #16]
	add	x4, x4, :lo12:ufs_mq_workqueue_init.__key.67
	orr	w2, wzr, #0x200000
	bl	init_timer_key
	str	x22, [x21]
	orr	w9, wzr, #0x1
	ldr	w8, [x22, #4]
	str	x21, [x22, #1512]
	strb	w9, [x22, #1504]
	cmp	w8, #2                  // =2
	b.ne	.LBB50_3
// %bb.16:
	add	x0, x22, #1488          // =1488
	bl	mas_blk_flush_list_register
	cbnz	x21, .LBB50_4
	b	.LBB50_18
.LBB50_17:
	mov	x0, x20
	bl	ufs_mq_sched_ds_lld_exit
.LBB50_18:
	mov	x0, x19
	bl	kfree
.LBB50_19:
	mov	w0, #-12
.LBB50_20:
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldp	x24, x23, [sp], #64     // 16-byte Folded Reload
	ret
.LBB50_21:
	adrp	x0, .L.str.11
	adrp	x1, .L__func__.ufs_mq_iosched_init
	add	x0, x0, :lo12:.L.str.11
	add	x1, x1, :lo12:.L__func__.ufs_mq_iosched_init
	mov	w2, #3271
	bl	printk
	b	.LBB50_19
.LBB50_22:
	adrp	x0, .L.str.58
	adrp	x1, .L__func__.ufs_mq_workqueue_init
	add	x0, x0, :lo12:.L.str.58
	add	x1, x1, :lo12:.L__func__.ufs_mq_workqueue_init
	mov	w2, #3119
	bl	printk
	b	.LBB50_25
.LBB50_23:
	ldr	x0, [x24, :lo12:mas_blk_mq_async_disp_wq]
	bl	destroy_workqueue
.LBB50_24:
	ldr	x0, [x23, :lo12:mas_blk_mq_sync_disp_wq]
	bl	destroy_workqueue
	adrp	x0, .L.str.69
	adrp	x1, .L__func__.ufs_mq_workqueue_init
	add	x0, x0, :lo12:.L.str.69
	add	x1, x1, :lo12:.L__func__.ufs_mq_workqueue_init
	bl	printk
.LBB50_25:
	mov	x0, x21
	bl	kfree
	b	.LBB50_18
.Lfunc_end50:
	.size	ufs_mq_iosched_init, .Lfunc_end50-ufs_mq_iosched_init
                                        // -- End function
	.p2align	3               // -- Begin function ufs_mq_sched_ds_lld_exit
	.type	ufs_mq_sched_ds_lld_exit,@function
ufs_mq_sched_ds_lld_exit:               // @ufs_mq_sched_ds_lld_exit
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	mov	x0, x19
	bl	mas_blk_get_lld
	ldr	w8, [x0, #4]
	mov	x19, x0
	ldr	x20, [x0, #1512]
	cmp	w8, #2                  // =2
	b.ne	.LBB51_2
// %bb.1:
	add	x0, x19, #1488          // =1488
	bl	mas_blk_flush_list_unregister
.LBB51_2:
	ldrb	w8, [x19, #1504]
	cbz	w8, .LBB51_5
// %bb.3:
	add	x8, x20, #620           // =620
	//APP
	// atomic_sub_return
	prfm	pstl1strm, [x8]
1:	ldxr	w9, [x8]
	sub	w9, w9, #1
	stlxr	w10, w9, [x8]
	cbnz	w10, 1b
	dmb ish
	//NO_APP
	cbnz	w9, .LBB51_5
// %bb.4:
	adrp	x8, mas_blk_mq_async_disp_wq
	ldr	x0, [x8, :lo12:mas_blk_mq_async_disp_wq]
	strb	wzr, [x19, #1504]
	bl	destroy_workqueue
	adrp	x8, mas_blk_mq_sync_disp_wq
	ldr	x0, [x8, :lo12:mas_blk_mq_sync_disp_wq]
	bl	destroy_workqueue
	adrp	x8, mas_blk_io_guard_wq
	ldr	x0, [x8, :lo12:mas_blk_io_guard_wq]
	bl	destroy_workqueue
	ldr	x0, [x19, #1512]
	bl	kfree
	str	xzr, [x19, #1512]
.LBB51_5:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end51:
	.size	ufs_mq_sched_ds_lld_exit, .Lfunc_end51-ufs_mq_sched_ds_lld_exit
                                        // -- End function
	.globl	ufs_mq_iosched_exit     // -- Begin function ufs_mq_iosched_exit
	.p2align	3
	.type	ufs_mq_iosched_exit,@function
ufs_mq_iosched_exit:                    // @ufs_mq_iosched_exit
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	bl	_mcount
	ldr	x21, [x19, #2296]
	cbz	x21, .LBB52_4
// %bb.1:
	adrp	x0, mas_io_guard_work
	add	x0, x0, :lo12:mas_io_guard_work
	bl	cancel_delayed_work_sync
	adrp	x0, io_guard_queue_list_lock
	add	x0, x0, :lo12:io_guard_queue_list_lock
	bl	_raw_spin_lock
	add	x20, x21, #472          // =472
	mov	x0, x20
	bl	__list_del_entry_valid
	tbz	w0, #0, .LBB52_3
// %bb.2:
	ldp	x8, x9, [x21, #472]
	str	x9, [x8, #8]
	str	x8, [x9]
.LBB52_3:
	adrp	x0, io_guard_queue_list_lock
	str	x20, [x21, #472]
	add	x0, x0, :lo12:io_guard_queue_list_lock
	str	x20, [x21, #480]
	bl	_raw_spin_unlock
	mov	x0, x19
	bl	ufs_mq_sched_ds_lld_exit
	ldr	x0, [x19, #2296]
	bl	kfree
	str	xzr, [x19, #2296]
.LBB52_4:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.Lfunc_end52:
	.size	ufs_mq_iosched_exit, .Lfunc_end52-ufs_mq_iosched_exit
                                        // -- End function
	.globl	blk_mq_tagset_ufs_mq_iosched_enable // -- Begin function blk_mq_tagset_ufs_mq_iosched_enable
	.p2align	3
	.type	blk_mq_tagset_ufs_mq_iosched_enable,@function
blk_mq_tagset_ufs_mq_iosched_enable:    // @blk_mq_tagset_ufs_mq_iosched_enable
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	w19, w1
	mov	x20, x0
	bl	_mcount
	ldr	x8, [x20, #40]
	cmp	w19, #0                 // =0
	orr	x9, x8, #0x20
	and	x8, x8, #0xffffffffffffffdf
	csel	x8, x8, x9, eq
	str	x8, [x20, #40]
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end53:
	.size	blk_mq_tagset_ufs_mq_iosched_enable, .Lfunc_end53-blk_mq_tagset_ufs_mq_iosched_enable
                                        // -- End function
	.globl	blk_mq_get_io_in_list_count // -- Begin function blk_mq_get_io_in_list_count
	.p2align	3
	.type	blk_mq_get_io_in_list_count,@function
blk_mq_get_io_in_list_count:            // @blk_mq_get_io_in_list_count
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	cbz	x19, .LBB54_6
// %bb.1:
	ldr	x8, [x19, #288]
	cbz	x8, .LBB54_6
// %bb.2:
	ldr	x8, [x8, #2296]
	cbz	x8, .LBB54_6
// %bb.3:
	ldr	x8, [x8, #488]
	cbz	x8, .LBB54_6
// %bb.4:
	ldr	w9, [x8, #144]
	ldr	w10, [x8, #168]
	ldr	w8, [x8, #280]
	add	w9, w10, w9
	add	w0, w9, w8
.LBB54_5:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.LBB54_6:
	mov	w0, #-1
	b	.LBB54_5
.Lfunc_end54:
	.size	blk_mq_get_io_in_list_count, .Lfunc_end54-blk_mq_get_io_in_list_count
                                        // -- End function
	.p2align	3               // -- Begin function __ufs_turbo_check_timer_expire
	.type	__ufs_turbo_check_timer_expire,@function
__ufs_turbo_check_timer_expire:         // @__ufs_turbo_check_timer_expire
// %bb.0:
	sub	sp, sp, #64             // =64
	str	x21, [sp, #16]          // 8-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	bl	_mcount
	adrp	x20, ufs_turbo_check_timer_expire.check_count
	ldrb	w3, [x19, #296]
	sub	x8, x19, #600           // =600
	sub	x9, x19, #608           // =608
	sub	x10, x19, #580          // =580
	ldr	w2, [x20, :lo12:ufs_turbo_check_timer_expire.check_count]
	sub	x11, x19, #584          // =584
	ldr	w4, [x8]
	ldr	w5, [x9]
	sub	x8, x19, #592           // =592
	sub	x9, x19, #588           // =588
	ldr	w6, [x10]
	ldr	w7, [x11]
	adrp	x0, .L.str.50
	ldr	w8, [x8]
	adrp	x1, .L__func__.ufs_turbo_check_timer_expire
	ldr	w9, [x9]
	add	x0, x0, :lo12:.L.str.50
	add	x1, x1, :lo12:.L__func__.ufs_turbo_check_timer_expire
	sub	x19, x19, #624          // =624
	str	w8, [sp]
	str	w9, [sp, #8]
	bl	printk
	ldr	x0, [x19]
	ldr	x21, [x0, #40]
	bl	mas_blk_get_queue_by_lld
	mov	w1, wzr
	blr	x21
	ldr	w8, [x20, :lo12:ufs_turbo_check_timer_expire.check_count]
	cbz	w8, .LBB55_3
// %bb.1:
	ldr	w9, [x19, #24]
	ldr	w10, [x19, #16]
	add	w9, w10, w9
	cmp	w9, #0                  // =0
	b.le	.LBB55_4
// %bb.2:
	orr	w9, wzr, #0x1
	b	.LBB55_5
.LBB55_3:
	mov	w8, #18
	strb	wzr, [x19, #920]
	str	w8, [x20, :lo12:ufs_turbo_check_timer_expire.check_count]
	b	.LBB55_6
.LBB55_4:
	orr	w0, wzr, #0x1
	bl	blk_power_off_flush
	ldr	w8, [x20, :lo12:ufs_turbo_check_timer_expire.check_count]
	mov	w9, wzr
.LBB55_5:
	sub	w8, w8, #1              // =1
	strb	w9, [x19, #920]
	adrp	x10, jiffies
	add	x0, x19, #624           // =624
	str	w8, [x20, :lo12:ufs_turbo_check_timer_expire.check_count]
	ldr	x8, [x10, :lo12:jiffies]
	add	x1, x8, #125            // =125
	bl	mod_timer
.LBB55_6:
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldr	x21, [sp, #16]          // 8-byte Folded Reload
	add	sp, sp, #64             // =64
	ret
.Lfunc_end55:
	.size	__ufs_turbo_check_timer_expire, .Lfunc_end55-__ufs_turbo_check_timer_expire
                                        // -- End function
	.p2align	3               // -- Begin function ufs_datasync_work
	.type	ufs_datasync_work,@function
ufs_datasync_work:                      // @ufs_datasync_work
// %bb.0:
	sub	sp, sp, #32             // =32
	adrp	x8, __stack_chk_guard
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	str	x8, [sp, #8]
	bl	_mcount
	adrp	x0, .L.str.51
	orr	w8, wzr, #0x1
	add	x0, x0, :lo12:.L.str.51
	str	w8, [sp, #4]
	bl	printk
	adrp	x0, ufs_sync_fs
	add	x0, x0, :lo12:ufs_sync_fs
	add	x1, sp, #4              // =4
	bl	iterate_supers
	adrp	x0, .L.str.52
	add	x0, x0, :lo12:.L.str.52
	bl	printk
	adrp	x9, __stack_chk_guard
	ldr	x8, [sp, #8]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB56_2
// %bb.1:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	add	sp, sp, #32             // =32
	ret
.LBB56_2:
	bl	__stack_chk_fail
.Lfunc_end56:
	.size	ufs_datasync_work, .Lfunc_end56-ufs_datasync_work
                                        // -- End function
	.p2align	3               // -- Begin function ufs_sync_fs
	.type	ufs_sync_fs,@function
ufs_sync_fs:                            // @ufs_sync_fs
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x20, x1
	mov	x19, x0
	bl	_mcount
	ldrb	w8, [x19, #80]
	tbnz	w8, #0, .LBB57_3
// %bb.1:
	ldr	x8, [x19, #48]
	ldr	x8, [x8, #56]
	cbz	x8, .LBB57_3
// %bb.2:
	ldr	w1, [x20]
	mov	x0, x19
	blr	x8
.LBB57_3:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end57:
	.size	ufs_sync_fs, .Lfunc_end57-ufs_sync_fs
                                        // -- End function
	.p2align	3               // -- Begin function ufs_mq_async_sched_fifo_init
	.type	ufs_mq_async_sched_fifo_init,@function
ufs_mq_async_sched_fifo_init:           // @ufs_mq_async_sched_fifo_init
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldrb	w8, [x19, #256]
	cbnz	w8, .LBB58_2
// %bb.1:
	add	x8, x19, #264           // =264
	orr	w9, wzr, #0x1
	str	x8, [x19, #264]
	str	x8, [x19, #272]
	strb	w9, [x19, #256]
.LBB58_2:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end58:
	.size	ufs_mq_async_sched_fifo_init, .Lfunc_end58-ufs_mq_async_sched_fifo_init
                                        // -- End function
	.p2align	3               // -- Begin function ufs_mq_async_sched_fifo_insert
	.type	ufs_mq_async_sched_fifo_insert,@function
ufs_mq_async_sched_fifo_insert:         // @ufs_mq_async_sched_fifo_insert
// %bb.0:
	str	x23, [sp, #-64]!        // 8-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	x20, x1
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	mov	x19, x0
	bl	_mcount
	ldr	x22, [x20, #272]
	add	x21, x19, #424          // =424
	add	x23, x20, #264          // =264
	mov	x0, x21
	mov	x2, x23
	mov	x1, x22
	bl	__list_add_valid
	tbz	w0, #0, .LBB59_2
// %bb.1:
	str	x21, [x20, #272]
	stp	x23, x22, [x19, #424]
	str	x21, [x22]
.LBB59_2:
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldr	x23, [sp], #64          // 8-byte Folded Reload
	ret
.Lfunc_end59:
	.size	ufs_mq_async_sched_fifo_insert, .Lfunc_end59-ufs_mq_async_sched_fifo_insert
                                        // -- End function
	.p2align	3               // -- Begin function ufs_mq_async_sched_fifo_seek
	.type	ufs_mq_async_sched_fifo_seek,@function
ufs_mq_async_sched_fifo_seek:           // @ufs_mq_async_sched_fifo_seek
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x20, x0
	bl	_mcount
	ldr	x19, [x20, #264]
	add	x8, x20, #264           // =264
	cmp	x19, x8
	b.ne	.LBB60_2
// %bb.1:
	ldr	x9, [x20, #272]
	cmp	x9, x8
	b.eq	.LBB60_6
.LBB60_2:
	mov	x0, x19
	sub	x20, x19, #424          // =424
	bl	__list_del_entry_valid
	tbz	w0, #0, .LBB60_4
// %bb.3:
	ldp	x8, x9, [x19]
	str	x9, [x8, #8]
	str	x8, [x9]
.LBB60_4:
	str	x19, [x19]
	str	x19, [x19, #8]
.LBB60_5:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	mov	x0, x20
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.LBB60_6:
	mov	x20, xzr
	b	.LBB60_5
.Lfunc_end60:
	.size	ufs_mq_async_sched_fifo_seek, .Lfunc_end60-ufs_mq_async_sched_fifo_seek
                                        // -- End function
	.p2align	3               // -- Begin function ufs_mq_async_sched_fifo_requeue
	.type	ufs_mq_async_sched_fifo_requeue,@function
ufs_mq_async_sched_fifo_requeue:        // @ufs_mq_async_sched_fifo_requeue
// %bb.0:
	stp	x22, x21, [sp, #-48]!   // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x21, x1
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x19, x0
	bl	_mcount
	ldr	x22, [x21, #264]
	add	x20, x19, #424          // =424
	add	x21, x21, #264          // =264
	mov	x0, x20
	mov	x1, x21
	mov	x2, x22
	bl	__list_add_valid
	tbz	w0, #0, .LBB61_2
// %bb.1:
	str	x20, [x22, #8]
	stp	x22, x21, [x19, #424]
	str	x20, [x21]
.LBB61_2:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldp	x22, x21, [sp], #48     // 16-byte Folded Reload
	ret
.Lfunc_end61:
	.size	ufs_mq_async_sched_fifo_requeue, .Lfunc_end61-ufs_mq_async_sched_fifo_requeue
                                        // -- End function
	.p2align	3               // -- Begin function ufs_mq_async_sched_fifo_attempt_merge_bio
	.type	ufs_mq_async_sched_fifo_attempt_merge_bio,@function
ufs_mq_async_sched_fifo_attempt_merge_bio: // @ufs_mq_async_sched_fifo_attempt_merge_bio
// %bb.0:
	str	x23, [sp, #-64]!        // 8-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	x19, x1
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	mov	x20, x0
	bl	_mcount
	ldr	x8, [x19, #2296]
	ldr	x8, [x8, #488]
	ldr	x22, [x8, #272]
	add	x23, x8, #264           // =264
	cmp	x23, x22
	b.eq	.LBB62_7
.LBB62_1:                               // =>This Inner Loop Header: Depth=1
	sub	x21, x22, #424          // =424
	mov	x0, x21
	mov	x1, x20
	bl	blk_rq_merge_ok
	tbz	w0, #0, .LBB62_6
// %bb.2:                               //   in Loop: Header=BB62_1 Depth=1
	mov	x0, x21
	mov	x1, x20
	bl	blk_try_merge
	cmp	w0, #1                  // =1
	b.eq	.LBB62_5
// %bb.3:                               //   in Loop: Header=BB62_1 Depth=1
	cmp	w0, #2                  // =2
	b.ne	.LBB62_6
// %bb.4:                               //   in Loop: Header=BB62_1 Depth=1
	mov	x0, x19
	mov	x1, x21
	mov	x2, x20
	bl	bio_attempt_back_merge
	tbz	w0, #0, .LBB62_6
	b	.LBB62_9
.LBB62_5:                               //   in Loop: Header=BB62_1 Depth=1
	mov	x0, x19
	mov	x1, x21
	mov	x2, x20
	bl	bio_attempt_front_merge
	tbnz	w0, #0, .LBB62_9
.LBB62_6:                               //   in Loop: Header=BB62_1 Depth=1
	ldr	x22, [x22, #8]
	cmp	x23, x22
	b.ne	.LBB62_1
.LBB62_7:
	mov	w0, wzr
.LBB62_8:
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldr	x23, [sp], #64          // 8-byte Folded Reload
	ret
.LBB62_9:
	orr	w0, wzr, #0x1
	b	.LBB62_8
.Lfunc_end62:
	.size	ufs_mq_async_sched_fifo_attempt_merge_bio, .Lfunc_end62-ufs_mq_async_sched_fifo_attempt_merge_bio
                                        // -- End function
	.p2align	3               // -- Begin function ufs_mq_async_sched_fifo_empty
	.type	ufs_mq_async_sched_fifo_empty,@function
ufs_mq_async_sched_fifo_empty:          // @ufs_mq_async_sched_fifo_empty
// %bb.0:
	ldr	x8, [x0, #264]
	add	x9, x0, #264            // =264
	cmp	x9, x8
	cset	w0, eq
	ret
.Lfunc_end63:
	.size	ufs_mq_async_sched_fifo_empty, .Lfunc_end63-ufs_mq_async_sched_fifo_empty
                                        // -- End function
	.type	.L.str,@object          // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"\0013[BLK-IO]hp_sync_disp_list:\n"
	.size	.L.str, 30

	.type	.L.str.1,@object        // @.str.1
.L.str.1:
	.asciz	"\0013[BLK-IO]sync_disp_list:\n"
	.size	.L.str.1, 27

	.type	.L.str.2,@object        // @.str.2
.L.str.2:
	.asciz	"\0013[BLK-IO]async_fifo_list:\n"
	.size	.L.str.2, 28

	.type	.L.str.3,@object        // @.str.3
.L.str.3:
	.asciz	"cp_enabled: %d\n"
	.size	.L.str.3, 16

	.type	cp_debug_en,@object     // @cp_debug_en
	.local	cp_debug_en
	.comm	cp_debug_en,4,4
	.type	.L.str.4,@object        // @.str.4
.L.str.4:
	.asciz	"cp_debug_en: %d\n"
	.size	.L.str.4, 17

	.type	.L.str.5,@object        // @.str.5
.L.str.5:
	.asciz	"cp_io_limit: %u\n"
	.size	.L.str.5, 17

	.type	.Lufs_mq_flush_plug_list.bd,@object // @ufs_mq_flush_plug_list.bd
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	3
.Lufs_mq_flush_plug_list.bd:
	.xword	0
	.byte	1                       // 0x1
	.zero	7
	.size	.Lufs_mq_flush_plug_list.bd, 16

	.type	io_guard_queue_list_lock,@object // @io_guard_queue_list_lock
	.data
	.p2align	3
io_guard_queue_list_lock:
	.zero	4
	.word	3735899821              // 0xdead4ead
	.word	4294967295              // 0xffffffff
	.zero	4
	.xword	-1
	.xword	0
	.zero	16
	.xword	.L.str.30
	.word	0                       // 0x0
	.zero	4
	.xword	0                       // 0x0
	.xword	0                       // 0x0
	.size	io_guard_queue_list_lock, 80

	.type	mas_io_guard_queue_list,@object // @mas_io_guard_queue_list
	.p2align	3
mas_io_guard_queue_list:
	.xword	mas_io_guard_queue_list
	.xword	mas_io_guard_queue_list
	.size	mas_io_guard_queue_list, 16

	.type	mas_blk_io_guard_wq,@object // @mas_blk_io_guard_wq
	.local	mas_blk_io_guard_wq
	.comm	mas_blk_io_guard_wq,8,8
	.type	mas_io_guard_work,@object // @mas_io_guard_work
	.local	mas_io_guard_work
	.comm	mas_io_guard_work,200,8
	.type	.L.str.7,@object        // @.str.7
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.7:
	.asciz	"Reinit unreleased request!"
	.size	.L.str.7, 27

	.type	mas_blk_mq_sync_disp_wq,@object // @mas_blk_mq_sync_disp_wq
	.local	mas_blk_mq_sync_disp_wq
	.comm	mas_blk_mq_sync_disp_wq,8,8
	.type	.L.str.8,@object        // @.str.8
.L.str.8:
	.asciz	"\0013[BLK-IO]%s: vip_wait_cnt: %d\n"
	.size	.L.str.8, 32

	.type	.L.str.9,@object        // @.str.9
.L.str.9:
	.asciz	"\0013[BLK-IO]%s: h_tag_used_cnt: %d tag_used_cnt: %d r_tag_used_cnt: %d\n"
	.size	.L.str.9, 70

	.type	.L.str.10,@object       // @.str.10
.L.str.10:
	.asciz	"\0013[BLK-IO]%s: fg_inflt: %d, vip_inflt: %d, s_inflt: %d a_inflt: %d, cp_inflt: %d\n"
	.size	.L.str.10, 82

	.type	.L.str.11,@object       // @.str.11
.L.str.11:
	.asciz	"\0013[BLK-IO]%s %d Failed to alloc sched_ds!\n"
	.size	.L.str.11, 43

	.type	.L__func__.ufs_mq_iosched_init,@object // @__func__.ufs_mq_iosched_init
.L__func__.ufs_mq_iosched_init:
	.asciz	"ufs_mq_iosched_init"
	.size	.L__func__.ufs_mq_iosched_init, 20

	.type	ufs_mq_iosched_init.__key,@object // @ufs_mq_iosched_init.__key
	.local	ufs_mq_iosched_init.__key
	.comm	ufs_mq_iosched_init.__key,8,1
	.type	.L.str.12,@object       // @.str.12
.L.str.12:
	.asciz	"(work_completion)(&(&sched_ds->sync_dispatch_work.io_dispatch_work)->work)"
	.size	.L.str.12, 75

	.type	ufs_mq_iosched_init.__key.13,@object // @ufs_mq_iosched_init.__key.13
	.local	ufs_mq_iosched_init.__key.13
	.comm	ufs_mq_iosched_init.__key.13,8,1
	.type	.L.str.14,@object       // @.str.14
.L.str.14:
	.asciz	"&(&sched_ds->sync_dispatch_work.io_dispatch_work)->timer"
	.size	.L.str.14, 57

	.type	ufs_mq_iosched_init.__key.15,@object // @ufs_mq_iosched_init.__key.15
	.local	ufs_mq_iosched_init.__key.15
	.comm	ufs_mq_iosched_init.__key.15,8,1
	.type	.L.str.16,@object       // @.str.16
.L.str.16:
	.asciz	"(work_completion)(&(&sched_ds->async_dispatch_work.io_dispatch_work)->work)"
	.size	.L.str.16, 76

	.type	ufs_mq_iosched_init.__key.17,@object // @ufs_mq_iosched_init.__key.17
	.local	ufs_mq_iosched_init.__key.17
	.comm	ufs_mq_iosched_init.__key.17,8,1
	.type	.L.str.18,@object       // @.str.18
.L.str.18:
	.asciz	"&(&sched_ds->async_dispatch_work.io_dispatch_work)->timer"
	.size	.L.str.18, 58

	.type	mas_ufs_mq_async_io_fifo_sched,@object // @mas_ufs_mq_async_io_fifo_sched
	.data
	.p2align	3
mas_ufs_mq_async_io_fifo_sched:
	.word	0                       // 0x0
	.zero	4
	.xword	ufs_mq_async_sched_fifo_init
	.xword	ufs_mq_async_sched_fifo_insert
	.xword	ufs_mq_async_sched_fifo_seek
	.xword	ufs_mq_async_sched_fifo_requeue
	.xword	ufs_mq_async_sched_fifo_attempt_merge_bio
	.xword	ufs_mq_async_sched_fifo_empty
	.size	mas_ufs_mq_async_io_fifo_sched, 56

	.type	mas_ufs_mq,@object      // @mas_ufs_mq
	.globl	mas_ufs_mq
	.p2align	3
mas_ufs_mq:
	.xword	mas_ufs_mq_async_io_fifo_sched
	.size	mas_ufs_mq, 8

	.type	.L.str.19,@object       // @.str.19
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.19:
	.asciz	"nr_high_prio_tags is zero!"
	.size	.L.str.19, 27

	.type	.L.str.20,@object       // @.str.20
.L.str.20:
	.asciz	"nr_reserved_tags is zero!"
	.size	.L.str.20, 26

	.type	.L.str.22,@object       // @.str.22
.L.str.22:
	.asciz	"\0013[BLK-IO]lst_queue_t: %lld, lst_in_t: %lld, lst_out_t: %lld\n"
	.size	.L.str.22, 62

	.type	.L.str.23,@object       // @.str.23
.L.str.23:
	.asciz	"\0013[BLK-IO]CP limited to %d!\n"
	.size	.L.str.23, 29

	.type	.L.str.24,@object       // @.str.24
.L.str.24:
	.asciz	"\0013[BLK-IO]Forbid CP IO!\n"
	.size	.L.str.24, 25

	.type	.L.str.25,@object       // @.str.25
.L.str.25:
	.asciz	"rq has cp flag set already!"
	.size	.L.str.25, 28

	.type	.L.str.26,@object       // @.str.26
.L.str.26:
	.asciz	"\0013[BLK-IO]mas_cp: add cp flag, %s\n"
	.size	.L.str.26, 35

	.type	.L.str.29,@object       // @.str.29
.L.str.29:
	.asciz	"unknown sb_dispatch_level!"
	.size	.L.str.29, 27

	.type	mas_blk_mq_async_disp_wq,@object // @mas_blk_mq_async_disp_wq
	.local	mas_blk_mq_async_disp_wq
	.comm	mas_blk_mq_async_disp_wq,8,8
	.type	.L.str.30,@object       // @.str.30
.L.str.30:
	.asciz	"io_guard_queue_list_lock"
	.size	.L.str.30, 25

	.type	.L.str.31,@object       // @.str.31
.L.str.31:
	.asciz	"\0013[BLK-IO]%s\n"
	.size	.L.str.31, 14

	.type	.L.str.32,@object       // @.str.32
.L.str.32:
	.asciz	"high_prio_sync_io is 0!"
	.size	.L.str.32, 24

	.type	.L.str.33,@object       // @.str.33
.L.str.33:
	.asciz	"sync_io_inflt_cnt is 0!"
	.size	.L.str.33, 24

	.type	.L.str.34,@object       // @.str.34
.L.str.34:
	.asciz	"async_io_inflt_cnt is 0!"
	.size	.L.str.34, 25

	.type	.L.str.35,@object       // @.str.35
.L.str.35:
	.asciz	"cp_io_inflt_cnt is zero!"
	.size	.L.str.35, 25

	.type	.L.str.36,@object       // @.str.36
.L.str.36:
	.asciz	"async_dispatch_work_trigger_judgement error!"
	.size	.L.str.36, 45

	.type	.L.str.37,@object       // @.str.37
.L.str.37:
	.asciz	"dump"
	.size	.L.str.37, 5

	.type	.L.str.38,@object       // @.str.38
.L.str.38:
	.asciz	"io_latency"
	.size	.L.str.38, 11

	.type	ufs_mq_sched_ds_lld_init.__key,@object // @ufs_mq_sched_ds_lld_init.__key
	.local	ufs_mq_sched_ds_lld_init.__key
	.comm	ufs_mq_sched_ds_lld_init.__key,8,1
	.type	.L.str.39,@object       // @.str.39
.L.str.39:
	.asciz	"(&ds_lld->turbo_timer)"
	.size	.L.str.39, 23

	.type	ufs_mq_sched_ds_lld_init.__key.40,@object // @ufs_mq_sched_ds_lld_init.__key.40
	.local	ufs_mq_sched_ds_lld_init.__key.40
	.comm	ufs_mq_sched_ds_lld_init.__key.40,8,1
	.type	.L.str.41,@object       // @.str.41
.L.str.41:
	.asciz	"(work_completion)(&(&ds_lld->datasync_work)->work)"
	.size	.L.str.41, 51

	.type	ufs_mq_sched_ds_lld_init.__key.42,@object // @ufs_mq_sched_ds_lld_init.__key.42
	.local	ufs_mq_sched_ds_lld_init.__key.42
	.comm	ufs_mq_sched_ds_lld_init.__key.42,8,1
	.type	.L.str.43,@object       // @.str.43
.L.str.43:
	.asciz	"&(&ds_lld->datasync_work)->timer"
	.size	.L.str.43, 33

	.type	ufs_mq_sched_ds_lld_init.__key.44,@object // @ufs_mq_sched_ds_lld_init.__key.44
	.local	ufs_mq_sched_ds_lld_init.__key.44
	.comm	ufs_mq_sched_ds_lld_init.__key.44,8,1
	.type	.L.str.45,@object       // @.str.45
.L.str.45:
	.asciz	"(&ds_lld->sb_dispatch_check_timer)"
	.size	.L.str.45, 35

	.type	ufs_mq_sched_ds_lld_init.__key.46,@object // @ufs_mq_sched_ds_lld_init.__key.46
	.local	ufs_mq_sched_ds_lld_init.__key.46
	.comm	ufs_mq_sched_ds_lld_init.__key.46,8,1
	.type	.L.str.47,@object       // @.str.47
.L.str.47:
	.asciz	"(&ds_lld->write_throttle_check_timer)"
	.size	.L.str.47, 38

	.type	ufs_mq_sched_ds_lld_init.__key.48,@object // @ufs_mq_sched_ds_lld_init.__key.48
	.local	ufs_mq_sched_ds_lld_init.__key.48
	.comm	ufs_mq_sched_ds_lld_init.__key.48,8,1
	.type	.L.str.49,@object       // @.str.49
.L.str.49:
	.asciz	"&(&ds_lld->async_limit_update_lock)->rlock"
	.size	.L.str.49, 43

	.type	ufs_turbo_check_timer_expire.check_count,@object // @ufs_turbo_check_timer_expire.check_count
	.data
	.p2align	2
ufs_turbo_check_timer_expire.check_count:
	.word	18                      // 0x12
	.size	ufs_turbo_check_timer_expire.check_count, 4

	.type	.L.str.50,@object       // @.str.50
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.50:
	.asciz	"\0013[BLK-IO]%s: check_count = %d turbo_mode = %d prio io = %d, sync io = %d fg_inflt: %d, vip_inflt: %d, s_inflt: %d a_inflt: %d\n"
	.size	.L.str.50, 128

	.type	.L__func__.ufs_turbo_check_timer_expire,@object // @__func__.ufs_turbo_check_timer_expire
.L__func__.ufs_turbo_check_timer_expire:
	.asciz	"ufs_turbo_check_timer_expire"
	.size	.L__func__.ufs_turbo_check_timer_expire, 29

	.type	.L.str.51,@object       // @.str.51
.L.str.51:
	.asciz	"\0013[BLK-IO]UFS Sync start\n"
	.size	.L.str.51, 26

	.type	.L.str.52,@object       // @.str.52
.L.str.52:
	.asciz	"\0013[BLK-IO]UFS Sync complete\n"
	.size	.L.str.52, 29

	.type	ufs_mq_dispatch_list_init.__key,@object // @ufs_mq_dispatch_list_init.__key
	.local	ufs_mq_dispatch_list_init.__key
	.comm	ufs_mq_dispatch_list_init.__key,8,1
	.type	.L.str.53,@object       // @.str.53
.L.str.53:
	.asciz	"&(&ds_lld->sync_disp_lock)->rlock"
	.size	.L.str.53, 34

	.type	ufs_mq_dispatch_list_init.__key.54,@object // @ufs_mq_dispatch_list_init.__key.54
	.local	ufs_mq_dispatch_list_init.__key.54
	.comm	ufs_mq_dispatch_list_init.__key.54,8,1
	.type	.L.str.55,@object       // @.str.55
.L.str.55:
	.asciz	"&(&ds_lld->async_disp_lock)->rlock"
	.size	.L.str.55, 35

	.type	ufs_mq_workqueue_init.__key,@object // @ufs_mq_workqueue_init.__key
	.local	ufs_mq_workqueue_init.__key
	.comm	ufs_mq_workqueue_init.__key,8,1
	.type	.L.str.56,@object       // @.str.56
.L.str.56:
	.asciz	"(wq_completion)\"sync_dispatch\""
	.size	.L.str.56, 31

	.type	.L.str.57,@object       // @.str.57
.L.str.57:
	.asciz	"sync_dispatch"
	.size	.L.str.57, 14

	.type	.L.str.58,@object       // @.str.58
.L.str.58:
	.asciz	"\0013[BLK-IO]%s %d Failed to alloc sync_dispatch_workqueue\n"
	.size	.L.str.58, 57

	.type	.L__func__.ufs_mq_workqueue_init,@object // @__func__.ufs_mq_workqueue_init
.L__func__.ufs_mq_workqueue_init:
	.asciz	"ufs_mq_workqueue_init"
	.size	.L__func__.ufs_mq_workqueue_init, 22

	.type	ufs_mq_workqueue_init.__key.59,@object // @ufs_mq_workqueue_init.__key.59
	.local	ufs_mq_workqueue_init.__key.59
	.comm	ufs_mq_workqueue_init.__key.59,8,1
	.type	.L.str.60,@object       // @.str.60
.L.str.60:
	.asciz	"(wq_completion)\"async_dispatch\""
	.size	.L.str.60, 32

	.type	.L.str.61,@object       // @.str.61
.L.str.61:
	.asciz	"async_dispatch"
	.size	.L.str.61, 15

	.type	ufs_mq_workqueue_init.__key.62,@object // @ufs_mq_workqueue_init.__key.62
	.local	ufs_mq_workqueue_init.__key.62
	.comm	ufs_mq_workqueue_init.__key.62,8,1
	.type	.L.str.63,@object       // @.str.63
.L.str.63:
	.asciz	"(wq_completion)\"io_guard\""
	.size	.L.str.63, 26

	.type	.L.str.64,@object       // @.str.64
.L.str.64:
	.asciz	"io_guard"
	.size	.L.str.64, 9

	.type	ufs_mq_workqueue_init.__key.65,@object // @ufs_mq_workqueue_init.__key.65
	.local	ufs_mq_workqueue_init.__key.65
	.comm	ufs_mq_workqueue_init.__key.65,8,1
	.type	.L.str.66,@object       // @.str.66
.L.str.66:
	.asciz	"(work_completion)(&(&mas_io_guard_work)->work)"
	.size	.L.str.66, 47

	.type	ufs_mq_workqueue_init.__key.67,@object // @ufs_mq_workqueue_init.__key.67
	.local	ufs_mq_workqueue_init.__key.67
	.comm	ufs_mq_workqueue_init.__key.67,8,1
	.type	.L.str.68,@object       // @.str.68
.L.str.68:
	.asciz	"&(&mas_io_guard_work)->timer"
	.size	.L.str.68, 29

	.type	.L.str.69,@object       // @.str.69
.L.str.69:
	.asciz	"\0013[BLK-IO]%s init Failed!\n"
	.size	.L.str.69, 27


	.ident	"Snapdragon LLVM ARM Compiler 8.0.12 for Android NDK (based on llvm.org 7.0+)"
	.section	".note.GNU-stack","",@progbits
