	.text
	.file	"mas_blk_core.c"
	.globl	mas_blk_get_lld         // -- Begin function mas_blk_get_lld
	.p2align	3
	.type	mas_blk_get_lld,@function
mas_blk_get_lld:                        // @mas_blk_get_lld
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	x8, [x19, #400]
	cbz	x8, .LBB0_5
// %bb.1:
	ldr	x8, [x19, #4872]
	cbz	x8, .LBB0_3
// %bb.2:
	add	x0, x8, #16             // =16
	b	.LBB0_4
.LBB0_3:
	add	x0, x19, #2312          // =2312
.LBB0_4:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.LBB0_5:
	ldr	x8, [x19, #976]
	add	x9, x19, #2312          // =2312
	add	x10, x8, #240           // =240
	cmp	x8, #0                  // =0
	csel	x0, x9, x10, eq
	b	.LBB0_4
.Lfunc_end0:
	.size	mas_blk_get_lld, .Lfunc_end0-mas_blk_get_lld
                                        // -- End function
	.globl	mas_blk_get_queue_by_lld // -- Begin function mas_blk_get_queue_by_lld
	.p2align	3
	.type	mas_blk_get_queue_by_lld,@function
mas_blk_get_queue_by_lld:               // @mas_blk_get_queue_by_lld
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	w8, [x19, #4]
	cmp	w8, #2                  // =2
	b.eq	.LBB1_5
// %bb.1:
	cmp	w8, #1                  // =1
	b.eq	.LBB1_4
// %bb.2:
	cbnz	w8, .LBB1_8
// %bb.3:
	ldr	x0, [x19, #8]
	b	.LBB1_7
.LBB1_4:
	ldr	x8, [x19, #8]
	ldr	x8, [x8, #232]
	b	.LBB1_6
.LBB1_5:
	ldr	x8, [x19, #8]
	ldr	x8, [x8, #1792]
.LBB1_6:
	mov	x9, #-4880
	add	x0, x8, x9
.LBB1_7:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.LBB1_8:
	adrp	x0, .L.str.7
	adrp	x1, .L.str
	add	x0, x0, :lo12:.L.str.7
	add	x1, x1, :lo12:.L.str
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.Lfunc_end1:
	.size	mas_blk_get_queue_by_lld, .Lfunc_end1-mas_blk_get_queue_by_lld
                                        // -- End function
	.globl	blk_dio_ck              // -- Begin function blk_dio_ck
	.p2align	3
	.type	blk_dio_ck,@function
blk_dio_ck:                             // @blk_dio_ck
// %bb.0:
	stp	x22, x21, [sp, #-48]!   // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	w19, w3
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	w21, w2
	mov	x20, x1
	mov	x22, x0
	bl	_mcount
	cbz	x22, .LBB2_18
// %bb.1:
	ldr	x8, [x22, #1712]
	cbz	x8, .LBB2_18
// %bb.2:
	cmp	w21, #1                 // =1
	b.eq	.LBB2_7
// %bb.3:
	cbnz	w21, .LBB2_18
// %bb.4:
	ldr	x9, [x8, #400]
	cbz	x9, .LBB2_11
// %bb.5:
	ldr	x9, [x8, #4872]
	cbz	x9, .LBB2_13
// %bb.6:
	add	x8, x9, #16             // =16
	b	.LBB2_14
.LBB2_7:
	ldr	x9, [x8, #400]
	cbz	x9, .LBB2_19
// %bb.8:
	ldr	x9, [x8, #4872]
	cbz	x9, .LBB2_10
// %bb.9:
	add	x8, x9, #16             // =16
	ldrsw	x21, [x8, #1524]
	cbnz	w21, .LBB2_15
	b	.LBB2_18
.LBB2_10:
	add	x8, x8, #2312           // =2312
	ldrsw	x21, [x8, #1524]
	cbnz	w21, .LBB2_15
	b	.LBB2_18
.LBB2_11:
	ldr	x9, [x8, #976]
	cbz	x9, .LBB2_13
// %bb.12:
	add	x8, x9, #240            // =240
	b	.LBB2_14
.LBB2_13:
	add	x8, x8, #2312           // =2312
.LBB2_14:
	ldrsw	x21, [x8, #1520]
	cbz	w21, .LBB2_18
.LBB2_15:
	bl	ktime_get
	sub	x8, x0, x20
	cmn	x8, #999                // =999
	b.lt	.LBB2_18
// %bb.16:
	mov	x10, #63439
	movk	x10, #58195, lsl #16
	mov	w9, #3906
	movk	x10, #39845, lsl #32
	movk	x10, #8388, lsl #48
	smull	x9, w19, w9
	smulh	x8, x8, x10
	sdiv	x9, x9, x21
	asr	x10, x8, #7
	add	x8, x10, x8, lsr #63
	sub	x0, x9, x8
	cmp	x0, #1                  // =1
	b.lt	.LBB2_18
// %bb.17:
	bl	__udelay
.LBB2_18:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldp	x22, x21, [sp], #48     // 16-byte Folded Reload
	ret
.LBB2_19:
	ldr	x9, [x8, #976]
	add	x8, x8, #2312           // =2312
	add	x10, x9, #240           // =240
	cmp	x9, #0                  // =0
	csel	x8, x8, x10, eq
	ldrsw	x21, [x8, #1524]
	cbnz	w21, .LBB2_15
	b	.LBB2_18
.Lfunc_end2:
	.size	blk_dio_ck, .Lfunc_end2-blk_dio_ck
                                        // -- End function
	.globl	blk_mq_tagset_vl_setup  // -- Begin function blk_mq_tagset_vl_setup
	.p2align	3
	.type	blk_mq_tagset_vl_setup,@function
blk_mq_tagset_vl_setup:                 // @blk_mq_tagset_vl_setup
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	lsr	x8, x19, #28
	str	wzr, [x20, #1536]
	cmp	x8, #0                  // =0
	mov	w8, #500
	mov	w9, #300
	csel	w8, w9, w8, eq
	str	w8, [x20, #1540]
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end3:
	.size	blk_mq_tagset_vl_setup, .Lfunc_end3-blk_mq_tagset_vl_setup
                                        // -- End function
	.globl	blk_queue_set_inline_crypto_flag // -- Begin function blk_queue_set_inline_crypto_flag
	.p2align	3
	.type	blk_queue_set_inline_crypto_flag,@function
blk_queue_set_inline_crypto_flag:       // @blk_queue_set_inline_crypto_flag
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	w19, w1
	mov	x20, x0
	bl	_mcount
	ldr	x8, [x20, #400]
	cbz	x8, .LBB4_3
// %bb.1:
	ldr	x8, [x20, #4872]
	add	x9, x20, #2312          // =2312
	add	x10, x8, #16            // =16
.LBB4_2:
	cmp	x8, #0                  // =0
	csel	x8, x9, x10, eq
	tst	w19, #0x1
	ldr	x9, [x8, #24]
	orr	x10, x9, #0x10
	and	x9, x9, #0xffffffffffffffef
	csel	x9, x10, x9, ne
	str	x9, [x8, #24]
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.LBB4_3:
	ldr	x8, [x20, #976]
	add	x9, x20, #2312          // =2312
	add	x10, x8, #240           // =240
	b	.LBB4_2
.Lfunc_end4:
	.size	blk_queue_set_inline_crypto_flag, .Lfunc_end4-blk_queue_set_inline_crypto_flag
                                        // -- End function
	.globl	mas_blk_queue_usr_ctrl_set // -- Begin function mas_blk_queue_usr_ctrl_set
	.p2align	3
	.type	mas_blk_queue_usr_ctrl_set,@function
mas_blk_queue_usr_ctrl_set:             // @mas_blk_queue_usr_ctrl_set
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	x8, [x19, #1888]
	mov	w9, #28570
	movk	w9, #4, lsl #16
	cmp	x8, x9
	b.ne	.LBB5_2
// %bb.1:
	mov	w8, #100
	adrp	x9, jiffies
	add	x0, x19, #2200          // =2200
	str	x8, [x19, #2192]
	ldr	x8, [x9, :lo12:jiffies]
	mov	w9, #48032
	movk	w9, #13, lsl #16
	add	x1, x8, x9
	bl	mod_timer
	b	.LBB5_3
.LBB5_2:
	add	x0, x19, #2200          // =2200
	str	xzr, [x19, #2192]
	bl	del_timer_sync
.LBB5_3:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end5:
	.size	mas_blk_queue_usr_ctrl_set, .Lfunc_end5-mas_blk_queue_usr_ctrl_set
                                        // -- End function
	.globl	mas_blk_queue_usr_ctrl_recovery_timer_expire // -- Begin function mas_blk_queue_usr_ctrl_recovery_timer_expire
	.p2align	3
	.type	mas_blk_queue_usr_ctrl_recovery_timer_expire,@function
mas_blk_queue_usr_ctrl_recovery_timer_expire: // @mas_blk_queue_usr_ctrl_recovery_timer_expire
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	str	xzr, [x19, #1888]
	str	xzr, [x19, #2192]
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end6:
	.size	mas_blk_queue_usr_ctrl_recovery_timer_expire, .Lfunc_end6-mas_blk_queue_usr_ctrl_recovery_timer_expire
                                        // -- End function
	.globl	mas_blk_bio_queue_split // -- Begin function mas_blk_bio_queue_split
	.p2align	3
	.type	mas_blk_bio_queue_split,@function
mas_blk_bio_queue_split:                // @mas_blk_bio_queue_split
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x2
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x20, x1
	mov	x21, x0
	bl	_mcount
	ldr	x0, [x20]
	bl	mas_blk_busyidle_check_bio_endio
	mov	x0, x21
	mov	x1, x19
	bl	mas_blk_busyidle_check_bio
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.Lfunc_end7:
	.size	mas_blk_bio_queue_split, .Lfunc_end7-mas_blk_bio_queue_split
                                        // -- End function
	.globl	mas_blk_bio_split_pre   // -- Begin function mas_blk_bio_split_pre
	.p2align	3
	.type	mas_blk_bio_split_pre,@function
mas_blk_bio_split_pre:                  // @mas_blk_bio_split_pre
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	ldr	x8, [x20, #320]
	cbz	x8, .LBB8_4
// %bb.1:
	ldr	w9, [x20, #328]
	cmp	w9, #48                 // =48
	b.eq	.LBB8_3
// %bb.2:
	cmp	w9, #64                 // =64
	b.ne	.LBB8_5
.LBB8_3:
	str	x8, [x19, #320]
	ldr	w8, [x20, #328]
	str	w8, [x19, #328]
	ldr	w8, [x20, #332]
	str	w8, [x19, #332]
	ldr	x8, [x20, #336]
	str	x8, [x19, #336]
.LBB8_4:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.LBB8_5:
	adrp	x0, .L.str.9
	adrp	x1, .L__func__.mas_blk_lld_inline_crypto_bio_split_pre
	add	x0, x0, :lo12:.L.str.9
	add	x1, x1, :lo12:.L__func__.mas_blk_lld_inline_crypto_bio_split_pre
	bl	printk
	ldr	x8, [x20, #320]
	b	.LBB8_3
.Lfunc_end8:
	.size	mas_blk_bio_split_pre, .Lfunc_end8-mas_blk_bio_split_pre
                                        // -- End function
	.globl	mas_blk_bio_split_post  // -- Begin function mas_blk_bio_split_post
	.p2align	3
	.type	mas_blk_bio_split_post,@function
mas_blk_bio_split_post:                 // @mas_blk_bio_split_post
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	x8, [x19, #320]
	cbz	x8, .LBB9_4
// %bb.1:
	ldr	w8, [x19, #328]
	cmp	w8, #48                 // =48
	b.eq	.LBB9_3
// %bb.2:
	cmp	w8, #64                 // =64
	b.ne	.LBB9_5
.LBB9_3:
	ldr	w8, [x19, #52]
	ldr	x9, [x19, #440]
	lsl	x8, x8, #4
	ldr	x8, [x9, x8]
	ldr	x8, [x8, #32]
	str	x8, [x19, #336]
.LBB9_4:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.LBB9_5:
	adrp	x0, .L.str.10
	adrp	x1, .L__func__.mas_blk_lld_inline_crypto_bio_split_post
	add	x0, x0, :lo12:.L.str.10
	add	x1, x1, :lo12:.L__func__.mas_blk_lld_inline_crypto_bio_split_post
	bl	printk
	b	.LBB9_3
.Lfunc_end9:
	.size	mas_blk_bio_split_post, .Lfunc_end9-mas_blk_bio_split_post
                                        // -- End function
	.globl	mas_blk_bio_merge_allow // -- Begin function mas_blk_bio_merge_allow
	.p2align	3
	.type	mas_blk_bio_merge_allow,@function
mas_blk_bio_merge_allow:                // @mas_blk_bio_merge_allow
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x1
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x20, x0
	bl	_mcount
	ldr	x8, [x20]
	ldr	x9, [x8, #400]
	cbz	x9, .LBB10_18
// %bb.1:
	ldr	x9, [x8, #4872]
	add	x8, x8, #2312           // =2312
	add	x10, x9, #16            // =16
.LBB10_2:
	cmp	x9, #0                  // =0
	csel	x8, x8, x10, eq
	ldrb	w8, [x8, #24]
	tbz	w8, #4, .LBB10_13
// %bb.3:
	ldr	x8, [x19, #320]
	ldr	x9, [x20, #400]
	cbz	x8, .LBB10_12
// %bb.4:
	cbz	x9, .LBB10_12
// %bb.5:
	ldr	w10, [x19, #328]
	ldr	w11, [x20, #408]
	cmp	w10, w11
	b.ne	.LBB10_16
// %bb.6:
	cmp	w10, #48                // =48
	b.eq	.LBB10_8
// %bb.7:
	cmp	w10, #64                // =64
	b.ne	.LBB10_15
.LBB10_8:
	cmp	x8, x9
	b.ne	.LBB10_16
.LBB10_9:
	ldr	x21, [x20, #72]
	mov	x0, x20
	mov	x1, x19
	bl	blk_try_merge
	cmp	w0, #1                  // =1
	b.eq	.LBB10_14
// %bb.10:
	cmp	w0, #2                  // =2
	b.ne	.LBB10_16
// %bb.11:
	ldr	x8, [x21, #336]
	ldrh	w9, [x21, #428]
	ldr	x10, [x19, #336]
	add	x8, x8, x9
	cmp	x8, x10
	b.eq	.LBB10_13
	b	.LBB10_16
.LBB10_12:
	orr	x8, x8, x9
	cbnz	x8, .LBB10_16
.LBB10_13:
	ldr	w8, [x20, #240]
	ldr	w9, [x19, #344]
	eor	w8, w9, w8, lsr #3
	tst	w8, #0x1
	cset	w0, eq
	b	.LBB10_17
.LBB10_14:
	ldr	x8, [x20, #64]
	ldr	x9, [x19, #336]
	ldrh	w10, [x19, #428]
	ldr	x8, [x8, #336]
	add	x9, x9, x10
	cmp	x9, x8
	b.eq	.LBB10_13
	b	.LBB10_16
.LBB10_15:
	adrp	x0, .L.str.11
	adrp	x1, .L__func__.mas_blk_lld_inline_crypto_bio_merge_allow
	add	x0, x0, :lo12:.L.str.11
	add	x1, x1, :lo12:.L__func__.mas_blk_lld_inline_crypto_bio_merge_allow
	bl	printk
	ldr	x8, [x19, #320]
	ldr	x9, [x20, #400]
	cmp	x8, x9
	b.eq	.LBB10_9
.LBB10_16:
	mov	w0, wzr
.LBB10_17:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.LBB10_18:
	ldr	x9, [x8, #976]
	add	x8, x8, #2312           // =2312
	add	x10, x9, #240           // =240
	b	.LBB10_2
.Lfunc_end10:
	.size	mas_blk_bio_merge_allow, .Lfunc_end10-mas_blk_bio_merge_allow
                                        // -- End function
	.globl	mas_blk_bio_merge_done  // -- Begin function mas_blk_bio_merge_done
	.p2align	3
	.type	mas_blk_bio_merge_done,@function
mas_blk_bio_merge_done:                 // @mas_blk_bio_merge_done
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x2
	mov	x20, x1
	bl	_mcount
	mov	x0, x20
	mov	x1, x19
	bl	mas_blk_latency_for_merge
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end11:
	.size	mas_blk_bio_merge_done, .Lfunc_end11-mas_blk_bio_merge_done
                                        // -- End function
	.globl	mas_blk_account_io_completion // -- Begin function mas_blk_account_io_completion
	.p2align	3
	.type	mas_blk_account_io_completion,@function
mas_blk_account_io_completion:          // @mas_blk_account_io_completion
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	w19, w1
	mov	x20, x0
	bl	_mcount
	cbz	x20, .LBB12_4
// %bb.1:
	ldr	x8, [x20]
	ldr	x9, [x8, #400]
	cbz	x9, .LBB12_10
// %bb.2:
	ldr	x9, [x8, #4872]
	cbz	x9, .LBB12_5
// %bb.3:
	add	x8, x9, #16             // =16
	cbnz	x8, .LBB12_6
	b	.LBB12_11
.LBB12_4:
	mov	w0, #-1
	b	.LBB12_12
.LBB12_5:
	add	x8, x8, #2312           // =2312
	cbz	x8, .LBB12_11
.LBB12_6:
	ldrb	w9, [x20, #20]
	cmp	w9, #3                  // =3
	b.ne	.LBB12_8
// %bb.7:
	ldr	x9, [x8, #1304]
	add	x9, x9, w19, uxtw
	str	x9, [x8, #1304]
	ldrb	w9, [x20, #20]
.LBB12_8:
	cmp	w9, #1                  // =1
	b.ne	.LBB12_11
// %bb.9:
	ldr	x9, [x8, #1296]
	mov	w0, wzr
	add	x9, x9, w19, uxtw
	str	x9, [x8, #1296]
	b	.LBB12_12
.LBB12_10:
	ldr	x9, [x8, #976]
	add	x8, x8, #2312           // =2312
	add	x10, x9, #240           // =240
	cmp	x9, #0                  // =0
	csel	x8, x8, x10, eq
	cbnz	x8, .LBB12_6
.LBB12_11:
	mov	w0, wzr
.LBB12_12:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end12:
	.size	mas_blk_account_io_completion, .Lfunc_end12-mas_blk_account_io_completion
                                        // -- End function
	.globl	mas_queue_io_prio_sim_show // -- Begin function mas_queue_io_prio_sim_show
	.p2align	3
	.type	mas_queue_io_prio_sim_show,@function
mas_queue_io_prio_sim_show:             // @mas_queue_io_prio_sim_show
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	ldrb	w3, [x20, #1896]
	adrp	x2, .L.str.1
	add	x2, x2, :lo12:.L.str.1
	orr	w1, wzr, #0x1000
	mov	x0, x19
	bl	snprintf
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
                                        // kill: def $w0 killed $w0 def $x0
	sxtw	x0, w0
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end13:
	.size	mas_queue_io_prio_sim_show, .Lfunc_end13-mas_queue_io_prio_sim_show
                                        // -- End function
	.globl	mas_queue_io_prio_sim_store // -- Begin function mas_queue_io_prio_sim_store
	.p2align	3
	.type	mas_queue_io_prio_sim_store,@function
mas_queue_io_prio_sim_store:            // @mas_queue_io_prio_sim_store
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
	mov	x0, sp
	mov	x1, x20
	mov	x2, x19
	bl	queue_var_store
	ldr	x8, [sp]
	cmp	x0, #0                  // =0
	cset	w9, ge
	cmp	x8, #0                  // =0
	cset	w8, ne
	and	w8, w9, w8
	adrp	x9, __stack_chk_guard
	strb	w8, [x21, #1896]
	ldr	x8, [sp, #8]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB14_2
// %bb.1:
	mov	x0, x19
	ldr	x21, [sp, #16]          // 8-byte Folded Reload
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	add	sp, sp, #64             // =64
	ret
.LBB14_2:
	bl	__stack_chk_fail
.Lfunc_end14:
	.size	mas_queue_io_prio_sim_store, .Lfunc_end14-mas_queue_io_prio_sim_store
                                        // -- End function
	.globl	mas_blk_generic_make_request_check // -- Begin function mas_blk_generic_make_request_check
	.p2align	3
	.type	mas_blk_generic_make_request_check,@function
mas_blk_generic_make_request_check:     // @mas_blk_generic_make_request_check
// %bb.0:
	sub	sp, sp, #80             // =80
	adrp	x8, __stack_chk_guard
	str	x21, [sp, #32]          // 8-byte Folded Spill
	stp	x20, x19, [sp, #48]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #64]     // 16-byte Folded Spill
	add	x29, sp, #64            // =64
	ldr	x8, [x8, :lo12:__stack_chk_guard]
	str	x8, [sp, #24]
	bl	_mcount
	ldr	x8, [x19, #8]
	ldr	x20, [x8, #1712]
	ldrb	w8, [x20, #1896]
	cbnz	w8, .LBB15_5
.LBB15_1:
	mov	x0, x19
	mov	w1, wzr
	bl	mas_blk_latency_bio_check
	mov	x0, x20
	mov	x1, x19
	bl	mas_blk_flush_async_dispatch
	tbnz	w0, #0, .LBB15_7
// %bb.2:
	mov	x0, x20
	mov	x1, x19
	bl	mas_blk_busyidle_check_bio
	mov	w0, wzr
.LBB15_3:
	adrp	x9, __stack_chk_guard
	ldr	x8, [sp, #24]
	ldr	x9, [x9, :lo12:__stack_chk_guard]
	cmp	x9, x8
	b.ne	.LBB15_15
// %bb.4:
	ldp	x29, x30, [sp, #64]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]     // 16-byte Folded Reload
	ldr	x21, [sp, #32]          // 8-byte Folded Reload
	add	sp, sp, #80             // =80
	ret
.LBB15_5:
	add	x0, sp, #8              // =8
	//APP
	mrs x2, sp_el0
	//NO_APP
	orr	w1, wzr, #0x10
	bl	__get_task_comm
	adrp	x21, process_io_prio_array
	strb	wzr, [sp, #23]
	add	x21, x21, :lo12:process_io_prio_array
	add	x0, sp, #8              // =8
	mov	x1, x21
	bl	strstr
	cbz	x0, .LBB15_8
// %bb.6:
	mov	x8, xzr
	b	.LBB15_14
.LBB15_7:
	mov	x0, x19
	strb	wzr, [x19, #26]
	bl	bio_endio
	orr	w0, wzr, #0x1
	b	.LBB15_3
.LBB15_8:
	add	x1, x21, #28            // =28
	add	x0, sp, #8              // =8
	bl	strstr
	cbz	x0, .LBB15_10
// %bb.9:
	orr	w8, wzr, #0x1
	b	.LBB15_14
.LBB15_10:
	add	x1, x21, #56            // =56
	add	x0, sp, #8              // =8
	bl	strstr
	cbz	x0, .LBB15_12
// %bb.11:
	orr	w8, wzr, #0x2
	b	.LBB15_14
.LBB15_12:
	add	x1, x21, #84            // =84
	add	x0, sp, #8              // =8
	bl	strstr
	cbz	x0, .LBB15_1
// %bb.13:
	orr	w8, wzr, #0x3
.LBB15_14:
	orr	w9, wzr, #0x1c
	ldr	x10, [x19, #96]
	madd	x8, x8, x9, x21
	ldr	w9, [x19, #16]
	ldp	w11, w12, [x8, #16]
	ldr	w8, [x8, #24]
	orr	w9, w9, w11
	orr	x10, x10, x12
	bic	w8, w9, w8
	str	x10, [x19, #96]
	str	w8, [x19, #16]
	b	.LBB15_1
.LBB15_15:
	bl	__stack_chk_fail
.Lfunc_end15:
	.size	mas_blk_generic_make_request_check, .Lfunc_end15-mas_blk_generic_make_request_check
                                        // -- End function
	.globl	mas_blk_generic_make_request // -- Begin function mas_blk_generic_make_request
	.p2align	3
	.type	mas_blk_generic_make_request,@function
mas_blk_generic_make_request:           // @mas_blk_generic_make_request
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	orr	w1, wzr, #0x2
	mov	x0, x19
	bl	mas_blk_latency_bio_check
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end16:
	.size	mas_blk_generic_make_request, .Lfunc_end16-mas_blk_generic_make_request
                                        // -- End function
	.globl	mas_blk_start_plug      // -- Begin function mas_blk_start_plug
	.p2align	3
	.type	mas_blk_start_plug,@function
mas_blk_start_plug:                     // @mas_blk_start_plug
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	add	x8, x19, #48            // =48
	str	x8, [x19, #48]
	stp	x8, xzr, [x19, #56]
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end17:
	.size	mas_blk_start_plug, .Lfunc_end17-mas_blk_start_plug
                                        // -- End function
	.globl	mas_blk_flush_plug_list // -- Begin function mas_blk_flush_plug_list
	.p2align	3
	.type	mas_blk_flush_plug_list,@function
mas_blk_flush_plug_list:                // @mas_blk_flush_plug_list
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	w20, w1
	mov	x19, x0
	bl	_mcount
	mov	x8, x19
	ldr	x9, [x8, #48]!
	cmp	x8, x9
	b.eq	.LBB18_3
// %bb.1:
	ldr	x8, [x19, #64]
	cbz	x8, .LBB18_3
// %bb.2:
	and	w1, w20, #0x1
	mov	x0, x19
	blr	x8
.LBB18_3:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end18:
	.size	mas_blk_flush_plug_list, .Lfunc_end18-mas_blk_flush_plug_list
                                        // -- End function
	.globl	mas_blk_bio_endio       // -- Begin function mas_blk_bio_endio
	.p2align	3
	.type	mas_blk_bio_endio,@function
mas_blk_bio_endio:                      // @mas_blk_bio_endio
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	mov	x0, x19
	bl	mas_blk_busyidle_check_bio_endio
	orr	w1, wzr, #0x1
	mov	x0, x19
	bl	mas_blk_latency_bio_check
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end19:
	.size	mas_blk_bio_endio, .Lfunc_end19-mas_blk_bio_endio
                                        // -- End function
	.globl	mas_blk_bio_free        // -- Begin function mas_blk_bio_free
	.p2align	3
	.type	mas_blk_bio_free,@function
mas_blk_bio_free:                       // @mas_blk_bio_free
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldrb	w8, [x19, #152]
	tbnz	w8, #0, .LBB20_2
// %bb.1:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.LBB20_2:
	adrp	x0, .L.str.2
	add	x0, x0, :lo12:.L.str.2
	mov	x1, x19
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.Lfunc_end20:
	.size	mas_blk_bio_free, .Lfunc_end20-mas_blk_bio_free
                                        // -- End function
	.globl	mas_blk_request_init_from_bio // -- Begin function mas_blk_request_init_from_bio
	.p2align	3
	.type	mas_blk_request_init_from_bio,@function
mas_blk_request_init_from_bio:          // @mas_blk_request_init_from_bio
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	mov	x0, x20
	mov	w1, wzr
	bl	mas_blk_latency_req_check
	str	wzr, [x20, #252]
	str	x20, [x19, #112]
	ldr	x8, [x20]
	ldr	x9, [x8, #400]
	cbz	x9, .LBB21_13
// %bb.1:
	ldr	x9, [x8, #4872]
	add	x10, x8, #2312          // =2312
	add	x11, x9, #16            // =16
.LBB21_2:
	cmp	x9, #0                  // =0
	csel	x9, x10, x11, eq
	ldrb	w9, [x9, #24]
	tbz	w9, #4, .LBB21_7
// %bb.3:
	ldr	x9, [x19, #320]
	cbz	x9, .LBB21_7
// %bb.4:
	ldr	w10, [x19, #328]
	cmp	w10, #48                // =48
	b.eq	.LBB21_6
// %bb.5:
	cmp	w10, #64                // =64
	b.ne	.LBB21_14
.LBB21_6:
	str	x9, [x20, #400]
	ldr	w9, [x19, #328]
	str	w9, [x20, #408]
	ldr	w9, [x19, #332]
	str	w9, [x20, #412]
.LBB21_7:
	ldr	w9, [x19, #344]
	tbz	w9, #0, .LBB21_9
// %bb.8:
	ldr	x9, [x20, #240]
	orr	x9, x9, #0x8
	str	x9, [x20, #240]
	ldr	w9, [x19, #344]
.LBB21_9:
	tbz	w9, #0, .LBB21_12
// %bb.10:
	ldrb	w9, [x19, #16]
	cmp	w9, #1                  // =1
	b.ne	.LBB21_12
// %bb.11:
	ldr	w9, [x19, #48]
	ldr	x10, [x8, #1904]
	add	x9, x10, x9
	str	x9, [x8, #1904]
.LBB21_12:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.LBB21_13:
	ldr	x9, [x8, #976]
	add	x10, x8, #2312          // =2312
	add	x11, x9, #240           // =240
	b	.LBB21_2
.LBB21_14:
	adrp	x0, .L.str.12
	adrp	x1, .L__func__.mas_blk_lld_inline_crypto_init_request_from_bio
	add	x0, x0, :lo12:.L.str.12
	add	x1, x1, :lo12:.L__func__.mas_blk_lld_inline_crypto_init_request_from_bio
	orr	w2, wzr, #0x40
	orr	w3, wzr, #0x30
	bl	printk
	adrp	x0, .L.str.7
	adrp	x1, .L.str.13
	add	x0, x0, :lo12:.L.str.7
	add	x1, x1, :lo12:.L.str.13
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.Lfunc_end21:
	.size	mas_blk_request_init_from_bio, .Lfunc_end21-mas_blk_request_init_from_bio
                                        // -- End function
	.globl	mas_blk_insert_cloned_request // -- Begin function mas_blk_insert_cloned_request
	.p2align	3
	.type	mas_blk_insert_cloned_request,@function
mas_blk_insert_cloned_request:          // @mas_blk_insert_cloned_request
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	mov	x0, x20
	mov	x1, x19
	bl	mas_blk_busyidle_check_request_bio
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end22:
	.size	mas_blk_insert_cloned_request, .Lfunc_end22-mas_blk_insert_cloned_request
                                        // -- End function
	.globl	mas_blk_request_execute_nowait // -- Begin function mas_blk_request_execute_nowait
	.p2align	3
	.type	mas_blk_request_execute_nowait,@function
mas_blk_request_execute_nowait:         // @mas_blk_request_execute_nowait
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
	mov	x1, x20
	mov	x2, x19
	bl	mas_blk_busyidle_check_execute_request
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.Lfunc_end23:
	.size	mas_blk_request_execute_nowait, .Lfunc_end23-mas_blk_request_execute_nowait
                                        // -- End function
	.globl	mas_blk_mq_rq_ctx_init  // -- Begin function mas_blk_mq_rq_ctx_init
	.p2align	3
	.type	mas_blk_mq_rq_ctx_init,@function
mas_blk_mq_rq_ctx_init:                 // @mas_blk_mq_rq_ctx_init
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x2
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x20, x1
	mov	x21, x0
	bl	_mcount
	ldr	x8, [x21, #2304]
	cbz	x8, .LBB24_3
// %bb.1:
	ldr	x8, [x8, #32]
	cbz	x8, .LBB24_3
// %bb.2:
	mov	x0, x21
	mov	x1, x20
	mov	x2, x19
	blr	x8
.LBB24_3:
	mov	x8, #-4294967296
	stp	xzr, x8, [x19, #400]
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.Lfunc_end24:
	.size	mas_blk_mq_rq_ctx_init, .Lfunc_end24-mas_blk_mq_rq_ctx_init
                                        // -- End function
	.globl	mas_blk_mq_request_start // -- Begin function mas_blk_mq_request_start
	.p2align	3
	.type	mas_blk_mq_request_start,@function
mas_blk_mq_request_start:               // @mas_blk_mq_request_start
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	mov	w1, #5
	mov	x0, x19
	bl	mas_blk_latency_req_check
	ldr	x8, [x19]
	mov	w10, #28570
	movk	w10, #4, lsl #16
	ldr	x9, [x8, #1888]
	cmp	x9, x10
	b.eq	.LBB25_2
.LBB25_1:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.LBB25_2:
	ldrb	w9, [x19, #20]
	orr	w10, w9, #0x3
	cmp	w10, #35                // =35
	b.eq	.LBB25_1
// %bb.3:
	ldr	w10, [x19, #40]
	cbz	w10, .LBB25_1
// %bb.4:
	cmp	w9, #1                  // =1
	b.ne	.LBB25_11
// %bb.5:
	cmp	w10, #32, lsl #12       // =131072
	b.hi	.LBB25_8
// %bb.6:
	ldr	x0, [x8, #2192]
	cbz	x0, .LBB25_8
// %bb.7:
	bl	__udelay
.LBB25_8:
	ldr	x8, [x19]
	ldr	x0, [x8, #2176]
	cbz	x0, .LBB25_11
// %bb.9:
	ldr	w8, [x19, #40]
	cmp	w8, #32, lsl #12        // =131072
	b.ls	.LBB25_11
// %bb.10:
	bl	__udelay
.LBB25_11:
	ldrb	w8, [x19, #20]
	cbnz	w8, .LBB25_1
// %bb.12:
	ldr	x8, [x19]
	ldr	x0, [x8, #2184]
	cbz	x0, .LBB25_15
// %bb.13:
	ldr	w8, [x19, #40]
	cmp	w8, #32, lsl #12        // =131072
	b.hi	.LBB25_15
// %bb.14:
	bl	__udelay
.LBB25_15:
	ldr	x8, [x19]
	ldr	x0, [x8, #2168]
	cbz	x0, .LBB25_1
// %bb.16:
	ldr	w8, [x19, #40]
	cmp	w8, #32, lsl #12        // =131072
	b.ls	.LBB25_1
// %bb.17:
	bl	__udelay
	b	.LBB25_1
.Lfunc_end25:
	.size	mas_blk_mq_request_start, .Lfunc_end25-mas_blk_mq_request_start
                                        // -- End function
	.globl	mas_blk_request_start   // -- Begin function mas_blk_request_start
	.p2align	3
	.type	mas_blk_request_start,@function
mas_blk_request_start:                  // @mas_blk_request_start
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	mov	w1, #5
	mov	x0, x19
	bl	mas_blk_latency_req_check
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end26:
	.size	mas_blk_request_start, .Lfunc_end26-mas_blk_request_start
                                        // -- End function
	.globl	mas_blk_requeue_request // -- Begin function mas_blk_requeue_request
	.p2align	3
	.type	mas_blk_requeue_request,@function
mas_blk_requeue_request:                // @mas_blk_requeue_request
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	mov	w1, #11
	mov	x0, x19
	bl	mas_blk_latency_req_check
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end27:
	.size	mas_blk_requeue_request, .Lfunc_end27-mas_blk_requeue_request
                                        // -- End function
	.globl	mas_blk_request_update  // -- Begin function mas_blk_request_update
	.p2align	3
	.type	mas_blk_request_update,@function
mas_blk_request_update:                 // @mas_blk_request_update
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	w21, w2
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	w20, w1
	mov	x19, x0
	bl	_mcount
	ldr	x8, [x19]
	ldr	x9, [x8, #400]
	cbz	x9, .LBB28_3
// %bb.1:
	ldr	x9, [x8, #4872]
	cbz	x9, .LBB28_5
// %bb.2:
	add	x8, x9, #16             // =16
	b	.LBB28_6
.LBB28_3:
	ldr	x9, [x8, #976]
	cbz	x9, .LBB28_5
// %bb.4:
	add	x8, x9, #240            // =240
	b	.LBB28_6
.LBB28_5:
	add	x8, x8, #2312           // =2312
.LBB28_6:
	ldrb	w9, [x19, #20]
	cmp	w9, #3                  // =3
	b.eq	.LBB28_11
// %bb.7:
	cmp	w9, #1                  // =1
	b.eq	.LBB28_12
.LBB28_8:
	cmp	w9, #2                  // =2
	b.ne	.LBB28_10
.LBB28_9:
	and	w1, w20, #0xff
	mov	x0, x19
	bl	mas_blk_flush_update
.LBB28_10:
	mov	w1, #13
	mov	x0, x19
	bl	mas_blk_latency_req_check
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.LBB28_11:
	ldr	x9, [x8, #1304]
	add	x9, x9, w21, uxtw
	str	x9, [x8, #1304]
	ldrb	w9, [x19, #20]
	cmp	w9, #1                  // =1
	b.ne	.LBB28_8
.LBB28_12:
	ldr	x9, [x8, #1296]
	add	x9, x9, w21, uxtw
	str	x9, [x8, #1296]
	ldrb	w9, [x19, #20]
	cmp	w9, #2                  // =2
	b.eq	.LBB28_9
	b	.LBB28_10
.Lfunc_end28:
	.size	mas_blk_request_update, .Lfunc_end28-mas_blk_request_update
                                        // -- End function
	.globl	mas_blk_mq_request_free // -- Begin function mas_blk_mq_request_free
	.p2align	3
	.type	mas_blk_mq_request_free,@function
mas_blk_mq_request_free:                // @mas_blk_mq_request_free
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	orr	w1, wzr, #0xe
	str	xzr, [x19, #392]
	mov	x0, x19
	bl	mas_blk_latency_req_check
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end29:
	.size	mas_blk_mq_request_free, .Lfunc_end29-mas_blk_mq_request_free
                                        // -- End function
	.globl	mas_blk_request_put     // -- Begin function mas_blk_request_put
	.p2align	3
	.type	mas_blk_request_put,@function
mas_blk_request_put:                    // @mas_blk_request_put
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	orr	w1, wzr, #0xe
	str	xzr, [x19, #392]
	mov	x0, x19
	bl	mas_blk_latency_req_check
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end30:
	.size	mas_blk_request_put, .Lfunc_end30-mas_blk_request_put
                                        // -- End function
	.globl	mas_blk_check_partition_done // -- Begin function mas_blk_check_partition_done
	.p2align	3
	.type	mas_blk_check_partition_done,@function
mas_blk_check_partition_done:           // @mas_blk_check_partition_done
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	w19, w1
	mov	x20, x0
	bl	_mcount
	ldr	x8, [x20, #1712]
	and	w9, w19, #0x1
	strb	w9, [x8, #1880]
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end31:
	.size	mas_blk_check_partition_done, .Lfunc_end31-mas_blk_check_partition_done
                                        // -- End function
	.globl	mas_blk_allocated_queue_init // -- Begin function mas_blk_allocated_queue_init
	.p2align	3
	.type	mas_blk_allocated_queue_init,@function
mas_blk_allocated_queue_init:           // @mas_blk_allocated_queue_init
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	add	x8, x19, #2152          // =2152
	add	x0, x19, #2312          // =2312
	mov	w1, wzr
	mov	x2, x19
	str	x8, [x19, #2152]
	str	x8, [x19, #2160]
	strb	wzr, [x19, #1880]
	bl	mas_blk_dev_lld_init
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end32:
	.size	mas_blk_allocated_queue_init, .Lfunc_end32-mas_blk_allocated_queue_init
                                        // -- End function
	.p2align	3               // -- Begin function mas_blk_dev_lld_init
	.type	mas_blk_dev_lld_init,@function
mas_blk_dev_lld_init:                   // @mas_blk_dev_lld_init
// %bb.0:
	stp	x22, x21, [sp, #-48]!   // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x20, x2
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	w21, w1
	mov	x19, x0
	bl	_mcount
	ldr	w8, [x19]
	cmp	w8, #122                // =122
	b.eq	.LBB33_6
// %bb.1:
	adrp	x1, .L.str.15
	str	wzr, [x19, #1316]
	adrp	x2, mas_blk_dev_lld_init.__key
	mov	w8, #122
	add	x0, x19, #1320          // =1320
	add	x1, x1, :lo12:.L.str.15
	add	x2, x2, :lo12:mas_blk_dev_lld_init.__key
	str	w8, [x19]
	bl	__raw_spin_lock_init
	adrp	x1, .L.str.17
	adrp	x2, mas_blk_dev_lld_init.__key.16
	orr	w8, wzr, #0x1
	add	x0, x19, #1408          // =1408
	add	x1, x1, :lo12:.L.str.17
	add	x2, x2, :lo12:mas_blk_dev_lld_init.__key.16
	str	w8, [x19, #1400]
	bl	__raw_spin_lock_init
	add	x22, x19, #80           // =80
	add	x8, x19, #1488          // =1488
	mov	x0, x22
	str	x8, [x19, #1488]
	str	x8, [x19, #1496]
	str	w21, [x19, #4]
	str	x20, [x19, #8]
	bl	mas_blk_busyidle_state_init
	ldr	x8, [x19, #24]
	cbz	w0, .LBB33_3
// %bb.2:
	and	x8, x8, #0xfffffffffffffff7
	str	x8, [x19, #24]
.LBB33_3:
	tbz	w8, #6, .LBB33_5
// %bb.4:
	orr	w9, wzr, #0x1
	strb	w9, [x22]
.LBB33_5:
	and	x8, x8, #0xfffffffffffffe7f
	strb	wzr, [x19, #1312]
	orr	x8, x8, #0x80
	str	xzr, [x19, #1520]
	str	x8, [x19, #24]
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldp	x22, x21, [sp], #48     // 16-byte Folded Reload
	ret
.LBB33_6:
	adrp	x0, .L.str.7
	adrp	x1, .L.str.14
	add	x0, x0, :lo12:.L.str.7
	add	x1, x1, :lo12:.L.str.14
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.Lfunc_end33:
	.size	mas_blk_dev_lld_init, .Lfunc_end33-mas_blk_dev_lld_init
                                        // -- End function
	.globl	mas_blk_sq_init_allocated_queue // -- Begin function mas_blk_sq_init_allocated_queue
	.p2align	3
	.type	mas_blk_sq_init_allocated_queue,@function
mas_blk_sq_init_allocated_queue:        // @mas_blk_sq_init_allocated_queue
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	mov	x0, x19
	bl	mas_blk_dump_register_queue
	mov	x0, x19
	bl	mas_blk_queue_latency_init
	mov	x0, x19
	bl	mas_blk_queue_async_flush_init
	adrp	x1, _cfi_mas_blk_queue_usr_ctrl_recovery_timer_expire
	str	xzr, [x19, #2192]
	adrp	x3, .L.str.18
	str	xzr, [x19, #2184]
	adrp	x4, mas_blk_io_speed_adj_init.__key
	str	xzr, [x19, #2176]
	add	x0, x19, #2200          // =2200
	str	xzr, [x19, #2168]
	add	x1, x1, :lo12:_cfi_mas_blk_queue_usr_ctrl_recovery_timer_expire
	add	x3, x3, :lo12:.L.str.18
	add	x4, x4, :lo12:mas_blk_io_speed_adj_init.__key
	mov	w2, wzr
	bl	init_timer_key
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end34:
	.size	mas_blk_sq_init_allocated_queue, .Lfunc_end34-mas_blk_sq_init_allocated_queue
                                        // -- End function
	.globl	mas_blk_mq_init_allocated_queue // -- Begin function mas_blk_mq_init_allocated_queue
	.p2align	3
	.type	mas_blk_mq_init_allocated_queue,@function
mas_blk_mq_init_allocated_queue:        // @mas_blk_mq_init_allocated_queue
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	x20, [x19, #4872]
	ldr	w8, [x20, #1556]
	cbz	w8, .LBB35_5
// %bb.1:
	mov	x9, xzr
.LBB35_2:                               // =>This Inner Loop Header: Depth=1
	ldr	x10, [x20, #1592]
	ldr	x10, [x10, x9, lsl #3]
	cbz	x10, .LBB35_4
// %bb.3:                               //   in Loop: Header=BB35_2 Depth=1
	str	x20, [x10, #24]
	ldr	w8, [x20, #1556]
.LBB35_4:                               //   in Loop: Header=BB35_2 Depth=1
	add	x9, x9, #1              // =1
	cmp	x9, w8, uxtw
	b.lo	.LBB35_2
.LBB35_5:
	mov	x0, x19
	bl	mas_blk_dump_register_queue
	mov	x0, x19
	bl	mas_blk_queue_latency_init
	mov	x0, x19
	bl	mas_blk_queue_async_flush_init
	adrp	x1, _cfi_mas_blk_queue_usr_ctrl_recovery_timer_expire
	str	xzr, [x19, #2192]
	adrp	x3, .L.str.18
	str	xzr, [x19, #2184]
	adrp	x4, mas_blk_io_speed_adj_init.__key
	str	xzr, [x19, #2176]
	add	x0, x19, #2200          // =2200
	str	xzr, [x19, #2168]
	add	x1, x1, :lo12:_cfi_mas_blk_queue_usr_ctrl_recovery_timer_expire
	add	x3, x3, :lo12:.L.str.18
	add	x4, x4, :lo12:mas_blk_io_speed_adj_init.__key
	mov	w2, wzr
	bl	init_timer_key
	ldr	x8, [x20, #1544]
	cbz	x8, .LBB35_10
// %bb.6:
	ldr	x8, [x8, #40]
	str	x8, [x19, #2304]
	cbz	x8, .LBB35_11
// %bb.7:
	ldr	x8, [x8, #8]
	cbz	x8, .LBB35_11
// %bb.8:
	mov	x0, x19
	blr	x8
	cbz	w0, .LBB35_11
// %bb.9:
	mov	w2, w0
	adrp	x0, .L.str.3
	adrp	x1, .L__func__.mas_blk_mq_init_allocated_queue
	add	x0, x0, :lo12:.L.str.3
	add	x1, x1, :lo12:.L__func__.mas_blk_mq_init_allocated_queue
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.LBB35_10:
	str	xzr, [x19, #2304]
.LBB35_11:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end35:
	.size	mas_blk_mq_init_allocated_queue, .Lfunc_end35-mas_blk_mq_init_allocated_queue
                                        // -- End function
	.globl	mas_blk_mq_free_queue   // -- Begin function mas_blk_mq_free_queue
	.p2align	3
	.type	mas_blk_mq_free_queue,@function
mas_blk_mq_free_queue:                  // @mas_blk_mq_free_queue
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	x8, [x19, #2304]
	cbz	x8, .LBB36_3
// %bb.1:
	ldr	x8, [x8, #16]
	cbz	x8, .LBB36_3
// %bb.2:
	mov	x0, x19
	blr	x8
.LBB36_3:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end36:
	.size	mas_blk_mq_free_queue, .Lfunc_end36-mas_blk_mq_free_queue
                                        // -- End function
	.globl	mas_blk_cleanup_queue   // -- Begin function mas_blk_cleanup_queue
	.p2align	3
	.type	mas_blk_cleanup_queue,@function
mas_blk_cleanup_queue:                  // @mas_blk_cleanup_queue
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	mov	x0, x19
	bl	mas_blk_dump_unregister_queue
	add	x0, x19, #2200          // =2200
	bl	del_timer_sync
	mov	x0, x19
	bl	mas_blk_flush_reduced_queue_unregister
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end37:
	.size	mas_blk_cleanup_queue, .Lfunc_end37-mas_blk_cleanup_queue
                                        // -- End function
	.globl	mas_blk_allocated_tags_init // -- Begin function mas_blk_allocated_tags_init
	.p2align	3
	.type	mas_blk_allocated_tags_init,@function
mas_blk_allocated_tags_init:            // @mas_blk_allocated_tags_init
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	adrp	x1, .L.str.4
	adrp	x2, mas_blk_allocated_tags_init.__key
	add	x0, x19, #40            // =40
	add	x1, x1, :lo12:.L.str.4
	add	x2, x2, :lo12:mas_blk_allocated_tags_init.__key
	bl	__mutex_init
	add	x20, x19, #240          // =240
	add	x8, x19, #224           // =224
	mov	w2, #1528
	mov	x0, x20
	mov	w1, wzr
	str	x8, [x19, #224]
	str	x8, [x19, #232]
	bl	memset
	orr	w1, wzr, #0x1
	mov	x0, x20
	mov	x2, x19
	bl	mas_blk_dev_lld_init
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end38:
	.size	mas_blk_allocated_tags_init, .Lfunc_end38-mas_blk_allocated_tags_init
                                        // -- End function
	.globl	blk_add_queue_tags      // -- Begin function blk_add_queue_tags
	.p2align	3
	.type	blk_add_queue_tags,@function
blk_add_queue_tags:                     // @blk_add_queue_tags
// %bb.0:
	stp	x24, x23, [sp, #-64]!   // 16-byte Folded Spill
	stp	x22, x21, [sp, #16]     // 16-byte Folded Spill
	mov	x21, x0
	stp	x20, x19, [sp, #32]     // 16-byte Folded Spill
	mov	x19, x1
	stp	x29, x30, [sp, #48]     // 16-byte Folded Spill
	add	x29, sp, #48            // =48
	bl	_mcount
	add	x20, x21, #40           // =40
	mov	x0, x20
	mov	w1, wzr
	bl	mutex_lock_nested
	ldr	x22, [x21, #232]
	mov	w8, #4880
	add	x23, x19, x8
	add	x24, x21, #224          // =224
	mov	x0, x23
	mov	x1, x22
	mov	x2, x24
	bl	__list_add_valid
	tbz	w0, #0, .LBB39_2
// %bb.1:
	str	x23, [x21, #232]
	str	x24, [x19, #4880]
	str	x22, [x19, #4888]
	str	x23, [x22]
.LBB39_2:
	mov	x0, x20
	bl	mutex_unlock
	ldp	x29, x30, [sp, #48]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]     // 16-byte Folded Reload
	ldp	x24, x23, [sp], #64     // 16-byte Folded Reload
	ret
.Lfunc_end39:
	.size	blk_add_queue_tags, .Lfunc_end39-blk_add_queue_tags
                                        // -- End function
	.globl	mas_blk_mq_allocated_tagset_init // -- Begin function mas_blk_mq_allocated_tagset_init
	.p2align	3
	.type	mas_blk_mq_allocated_tagset_init,@function
mas_blk_mq_allocated_tagset_init:       // @mas_blk_mq_allocated_tagset_init
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	add	x0, x19, #16            // =16
	orr	w1, wzr, #0x2
	mov	x2, x19
	bl	mas_blk_dev_lld_init
	ldr	x8, [x19, #40]
	adrp	x9, mas_ufs_blk_tagset_ops
	add	x9, x9, :lo12:mas_ufs_blk_tagset_ops
	lsl	x8, x8, #58
	and	x8, x9, x8, asr #63
	str	x8, [x19, #1544]
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end40:
	.size	mas_blk_mq_allocated_tagset_init, .Lfunc_end40-mas_blk_mq_allocated_tagset_init
                                        // -- End function
	.globl	mas_blk_queue_register  // -- Begin function mas_blk_queue_register
	.p2align	3
	.type	mas_blk_queue_register,@function
mas_blk_queue_register:                 // @mas_blk_queue_register
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x1
	mov	x20, x0
	bl	_mcount
	str	x19, [x20, #1872]
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end41:
	.size	mas_blk_queue_register, .Lfunc_end41-mas_blk_queue_register
                                        // -- End function
	.section	.init.text,"ax",@progbits
	.globl	mas_blk_dev_init        // -- Begin function mas_blk_dev_init
	.p2align	2
	.type	mas_blk_dev_init,@function
mas_blk_dev_init:                       // @mas_blk_dev_init
// %bb.0:
	stp	x29, x30, [sp, #-16]!   // 16-byte Folded Spill
	mov	x29, sp
	bl	_mcount
	bl	mas_blk_dump_init
	bl	mas_blk_latency_init
	mov	w0, wzr
	ldp	x29, x30, [sp], #16     // 16-byte Folded Reload
	ret
.Lfunc_end42:
	.size	mas_blk_dev_init, .Lfunc_end42-mas_blk_dev_init
                                        // -- End function
	.text
	.globl	blk_write_throttle      // -- Begin function blk_write_throttle
	.p2align	3
	.type	blk_write_throttle,@function
blk_write_throttle:                     // @blk_write_throttle
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	w20, w1
	mov	x19, x0
	bl	_mcount
	cbz	x19, .LBB43_4
// %bb.1:
	ldr	x8, [x19, #2304]
	cbz	x8, .LBB43_4
// %bb.2:
	ldr	x8, [x8, #152]
	cbz	x8, .LBB43_4
// %bb.3:
	cmp	w20, #0                 // =0
	cset	w1, ne
	mov	x0, x19
	blr	x8
.LBB43_4:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.Lfunc_end43:
	.size	blk_write_throttle, .Lfunc_end43-blk_write_throttle
                                        // -- End function
	.globl	blk_generic_freeze      // -- Begin function blk_generic_freeze
	.p2align	3
	.type	blk_generic_freeze,@function
blk_generic_freeze:                     // @blk_generic_freeze
// %bb.0:
	stp	x22, x21, [sp, #-48]!   // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	w19, w2
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	w21, w1
	mov	x20, x0
	bl	_mcount
	cbz	x20, .LBB44_26
// %bb.1:
	cmp	w21, #1                 // =1
	b.eq	.LBB44_9
// %bb.2:
	cbnz	w21, .LBB44_27
// %bb.3:
	ldr	w8, [x20, #4]
	cmp	w8, #2                  // =2
	b.eq	.LBB44_12
// %bb.4:
	cmp	w8, #1                  // =1
	b.eq	.LBB44_24
// %bb.5:
	cbnz	w8, .LBB44_28
// %bb.6:
	ldr	x0, [x20, #8]
	ldr	x8, [x0, #400]
	cbz	x8, .LBB44_24
// %bb.7:
	tbnz	w19, #0, .LBB44_11
.LBB44_8:
	bl	blk_mq_unfreeze_queue
	b	.LBB44_24
.LBB44_9:
	ldr	x8, [x20, #400]
	cbz	x8, .LBB44_24
// %bb.10:
	mov	x0, x20
	tbz	w19, #0, .LBB44_8
.LBB44_11:
	bl	blk_mq_freeze_queue
	b	.LBB44_24
.LBB44_12:
	ldr	x8, [x20, #8]
	ldr	x20, [x8, #1784]
	add	x21, x8, #1784          // =1784
	cmp	x21, x20
	b.eq	.LBB44_24
// %bb.13:
	tbz	w19, #0, .LBB44_19
// %bb.14:
	mov	x19, #-4880
	mov	x22, #-4480
.LBB44_15:                              // =>This Inner Loop Header: Depth=1
	adds	x0, x20, x19
	b.eq	.LBB44_25
// %bb.16:                              //   in Loop: Header=BB44_15 Depth=1
	ldr	x8, [x20, x22]
	cbz	x8, .LBB44_18
// %bb.17:                              //   in Loop: Header=BB44_15 Depth=1
	bl	blk_mq_freeze_queue
.LBB44_18:                              //   in Loop: Header=BB44_15 Depth=1
	ldr	x20, [x20]
	cmp	x21, x20
	b.ne	.LBB44_15
	b	.LBB44_24
.LBB44_19:
	mov	x19, #-4880
	mov	x22, #-4480
.LBB44_20:                              // =>This Inner Loop Header: Depth=1
	adds	x0, x20, x19
	b.eq	.LBB44_25
// %bb.21:                              //   in Loop: Header=BB44_20 Depth=1
	ldr	x8, [x20, x22]
	cbz	x8, .LBB44_23
// %bb.22:                              //   in Loop: Header=BB44_20 Depth=1
	bl	blk_mq_unfreeze_queue
.LBB44_23:                              //   in Loop: Header=BB44_20 Depth=1
	ldr	x20, [x20]
	cmp	x21, x20
	b.ne	.LBB44_20
.LBB44_24:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldp	x22, x21, [sp], #48     // 16-byte Folded Reload
	ret
.LBB44_25:
	adrp	x0, .L.str.7
	adrp	x1, .L.str.5
	add	x0, x0, :lo12:.L.str.7
	add	x1, x1, :lo12:.L.str.5
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.LBB44_26:
	adrp	x0, .L.str.7
	adrp	x1, .L.str.5
	add	x0, x0, :lo12:.L.str.7
	add	x1, x1, :lo12:.L.str.5
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.LBB44_27:
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.LBB44_28:
	adrp	x0, .L.str.7
	adrp	x1, .L.str
	add	x0, x0, :lo12:.L.str.7
	add	x1, x1, :lo12:.L.str
	bl	printk
	//APP
	.pushsection __bug_table,"aw"; .align 2; 14470: .long 14471f - 14470b; .pushsection .rodata.str,"aMS",@progbits,1; 14472: .string "/mnt/disk/jenkins/ci/workspace/chipset_pipeline_release/opensource/component_code/out/kernel/block/mas_blk.h"; .popsection; .long 14472b - 14470b; .short 375; .short 0; .popsection; 14471: brk 0x800
	//NO_APP
.Lfunc_end44:
	.size	blk_generic_freeze, .Lfunc_end44-blk_generic_freeze
                                        // -- End function
	.globl	blk_dev_write_order_preserved // -- Begin function blk_dev_write_order_preserved
	.p2align	3
	.type	blk_dev_write_order_preserved,@function
blk_dev_write_order_preserved:          // @blk_dev_write_order_preserved
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	cbz	x19, .LBB45_7
// %bb.1:
	ldr	x8, [x19, #280]
	cbz	x8, .LBB45_7
// %bb.2:
	ldr	x8, [x8, #1712]
	cbz	x8, .LBB45_7
// %bb.3:
	ldr	x9, [x8, #400]
	cbz	x9, .LBB45_8
// %bb.4:
	ldr	x9, [x8, #4872]
	add	x8, x8, #2312           // =2312
	add	x10, x9, #16            // =16
.LBB45_5:
	cmp	x9, #0                  // =0
	csel	x8, x8, x10, eq
	ldrb	w8, [x8, #25]
	and	w0, w8, #0x1
.LBB45_6:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.LBB45_7:
	mov	w0, wzr
	b	.LBB45_6
.LBB45_8:
	ldr	x9, [x8, #976]
	add	x8, x8, #2312           // =2312
	add	x10, x9, #240           // =240
	b	.LBB45_5
.Lfunc_end45:
	.size	blk_dev_write_order_preserved, .Lfunc_end45-blk_dev_write_order_preserved
                                        // -- End function
	.globl	blk_req_set_make_req_nr // -- Begin function blk_req_set_make_req_nr
	.p2align	3
	.type	blk_req_set_make_req_nr,@function
blk_req_set_make_req_nr:                // @blk_req_set_make_req_nr
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x19, x0
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	bl	_mcount
	ldr	x8, [x19]
	ldr	x9, [x8, #400]
	cbz	x9, .LBB46_6
// %bb.1:
	ldr	x9, [x8, #4872]
	add	x8, x8, #2312           // =2312
	add	x10, x9, #16            // =16
.LBB46_2:
	cmp	x9, #0                  // =0
	csel	x21, x8, x10, eq
	ldrb	w8, [x21, #25]
	tst	w8, #0x3
	b.eq	.LBB46_5
// %bb.3:
	ldr	x8, [x19, #240]
	add	x20, x21, #1408         // =1408
	mov	x0, x20
	orr	x8, x8, #0x4
	str	x8, [x19, #240]
	bl	_raw_spin_lock_irqsave
	ldr	w8, [x21, #1400]
	mov	x1, x0
	cbz	w8, .LBB46_7
.LBB46_4:
	add	w9, w8, #1              // =1
	mov	x0, x20
	str	w9, [x21, #1400]
	str	w8, [x19, #392]
	bl	_raw_spin_unlock_irqrestore
.LBB46_5:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.LBB46_6:
	ldr	x9, [x8, #976]
	add	x8, x8, #2312           // =2312
	add	x10, x9, #240           // =240
	b	.LBB46_2
.LBB46_7:
	orr	w8, wzr, #0x1
	str	w8, [x21, #1400]
	b	.LBB46_4
.Lfunc_end46:
	.size	blk_req_set_make_req_nr, .Lfunc_end46-blk_req_set_make_req_nr
                                        // -- End function
	.globl	blk_req_get_order_nr    // -- Begin function blk_req_get_order_nr
	.p2align	3
	.type	blk_req_get_order_nr,@function
blk_req_get_order_nr:                   // @blk_req_get_order_nr
// %bb.0:
	stp	x22, x21, [sp, #-48]!   // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	w20, w1
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x19, x0
	bl	_mcount
	ldrb	w8, [x19, #240]
	tbnz	w8, #1, .LBB47_5
// %bb.1:
	ldr	x8, [x19]
	ldr	x9, [x8, #400]
	cbz	x9, .LBB47_14
// %bb.2:
	ldr	x9, [x8, #4872]
	add	x8, x8, #2312           // =2312
	add	x10, x9, #16            // =16
.LBB47_3:
	cmp	x9, #0                  // =0
	ldr	w1, [x19, #396]
	csel	x22, x8, x10, eq
	cbnz	w1, .LBB47_13
// %bb.4:
	ldrb	w8, [x22, #25]
	tbnz	w8, #0, .LBB47_8
.LBB47_5:
	mov	w21, wzr
.LBB47_6:
	str	w21, [x19, #396]
.LBB47_7:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	mov	w0, w21
	ldp	x22, x21, [sp], #48     // 16-byte Folded Reload
	ret
.LBB47_8:
	tbz	w20, #0, .LBB47_10
// %bb.9:
                                        // implicit-def: $x1
	b	.LBB47_11
.LBB47_10:
	add	x0, x22, #1320          // =1320
	bl	_raw_spin_lock_irqsave
	mov	x1, x0
.LBB47_11:
	ldr	w8, [x22, #1316]
	cmn	w8, #1                  // =1
	add	w9, w8, #2              // =2
	csinc	w21, w9, w8, eq
	str	w21, [x22, #1316]
	tbnz	w20, #0, .LBB47_6
// %bb.12:
	add	x0, x22, #1320          // =1320
	bl	_raw_spin_unlock_irqrestore
	b	.LBB47_6
.LBB47_13:
	adrp	x0, .L.str.6
	add	x0, x0, :lo12:.L.str.6
	bl	printk
	ldr	w21, [x19, #396]
	b	.LBB47_7
.LBB47_14:
	ldr	x9, [x8, #976]
	add	x8, x8, #2312           // =2312
	add	x10, x9, #240           // =240
	b	.LBB47_3
.Lfunc_end47:
	.size	blk_req_get_order_nr, .Lfunc_end47-blk_req_get_order_nr
                                        // -- End function
	.globl	blk_queue_order_enable  // -- Begin function blk_queue_order_enable
	.p2align	3
	.type	blk_queue_order_enable,@function
blk_queue_order_enable:                 // @blk_queue_order_enable
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	w19, w1
	mov	x20, x0
	bl	_mcount
	ldr	x8, [x20, #400]
	cbz	x8, .LBB48_3
// %bb.1:
	ldr	x8, [x20, #4872]
	add	x9, x20, #2312          // =2312
	add	x10, x8, #16            // =16
.LBB48_2:
	cmp	x8, #0                  // =0
	csel	x8, x9, x10, eq
	tst	w19, #0x1
	ldr	x9, [x8, #24]
	orr	x10, x9, #0x100
	and	x9, x9, #0xfffffffffffffeff
	csel	x9, x10, x9, ne
	and	w10, w19, #0x1
	str	x9, [x8, #24]
	strb	w10, [x8, #1312]
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.LBB48_3:
	ldr	x8, [x20, #976]
	add	x9, x20, #2312          // =2312
	add	x10, x8, #240           // =240
	b	.LBB48_2
.Lfunc_end48:
	.size	blk_queue_order_enable, .Lfunc_end48-blk_queue_order_enable
                                        // -- End function
	.globl	blk_queue_query_order_enable // -- Begin function blk_queue_query_order_enable
	.p2align	3
	.type	blk_queue_query_order_enable,@function
blk_queue_query_order_enable:           // @blk_queue_query_order_enable
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	ldr	x8, [x19, #400]
	cbz	x8, .LBB49_3
// %bb.1:
	ldr	x8, [x19, #4872]
	add	x9, x19, #2312          // =2312
	add	x10, x8, #16            // =16
.LBB49_2:
	cmp	x8, #0                  // =0
	csel	x8, x9, x10, eq
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldrb	w8, [x8, #25]
	and	w0, w8, #0x1
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.LBB49_3:
	ldr	x8, [x19, #976]
	add	x9, x19, #2312          // =2312
	add	x10, x8, #240           // =240
	b	.LBB49_2
.Lfunc_end49:
	.size	blk_queue_query_order_enable, .Lfunc_end49-blk_queue_query_order_enable
                                        // -- End function
	.globl	blk_order_nr_reset      // -- Begin function blk_order_nr_reset
	.p2align	3
	.type	blk_order_nr_reset,@function
blk_order_nr_reset:                     // @blk_order_nr_reset
// %bb.0:
	str	x19, [sp, #-32]!        // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	x19, x0
	bl	_mcount
	cbz	x19, .LBB50_2
// %bb.1:
	str	wzr, [x19, #1332]
.LBB50_2:
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldr	x19, [sp], #32          // 8-byte Folded Reload
	ret
.Lfunc_end50:
	.size	blk_order_nr_reset, .Lfunc_end50-blk_order_nr_reset
                                        // -- End function
	.globl	blk_queue_cp_enable     // -- Begin function blk_queue_cp_enable
	.p2align	3
	.type	blk_queue_cp_enable,@function
blk_queue_cp_enable:                    // @blk_queue_cp_enable
// %bb.0:
	stp	x20, x19, [sp, #-32]!   // 16-byte Folded Spill
	stp	x29, x30, [sp, #16]     // 16-byte Folded Spill
	add	x29, sp, #16            // =16
	mov	w19, w1
	mov	x20, x0
	bl	_mcount
	ldr	x8, [x20, #400]
	cbz	x8, .LBB51_3
// %bb.1:
	ldr	x8, [x20, #4872]
	add	x9, x20, #2312          // =2312
	add	x10, x8, #16            // =16
.LBB51_2:
	cmp	x8, #0                  // =0
	csel	x8, x9, x10, eq
	tst	w19, #0x1
	ldr	x9, [x8, #24]
	orr	x10, x9, #0x80
	and	x9, x9, #0xffffffffffffff7f
	csel	x9, x10, x9, ne
	str	x9, [x8, #24]
	ldp	x29, x30, [sp, #16]     // 16-byte Folded Reload
	ldp	x20, x19, [sp], #32     // 16-byte Folded Reload
	ret
.LBB51_3:
	ldr	x8, [x20, #976]
	add	x9, x20, #2312          // =2312
	add	x10, x8, #240           // =240
	b	.LBB51_2
.Lfunc_end51:
	.size	blk_queue_cp_enable, .Lfunc_end51-blk_queue_cp_enable
                                        // -- End function
	.globl	mas_queue_status_show   // -- Begin function mas_queue_status_show
	.p2align	3
	.type	mas_queue_status_show,@function
mas_queue_status_show:                  // @mas_queue_status_show
// %bb.0:
	stp	x22, x21, [sp, #-48]!   // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	mov	x20, x2
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	mov	x21, x1
	mov	x19, x0
	bl	_mcount
	ldr	x8, [x19, #400]
	cbz	x8, .LBB52_3
// %bb.1:
	ldr	x8, [x19, #4872]
	add	x9, x19, #2312          // =2312
	add	x10, x8, #16            // =16
.LBB52_2:
	cmp	x8, #0                  // =0
	csel	x0, x9, x10, eq
	mov	x1, x21
	mov	w2, w20
	bl	mas_blk_dump_lld_status
	mov	w22, w0
	sub	w2, w20, w0
	add	x1, x21, w0, sxtw
	mov	x0, x19
	bl	mas_blk_dump_queue_status2
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	add	w8, w0, w22
	sxtw	x0, w8
	ldp	x22, x21, [sp], #48     // 16-byte Folded Reload
	ret
.LBB52_3:
	ldr	x8, [x19, #976]
	add	x9, x19, #2312          // =2312
	add	x10, x8, #240           // =240
	b	.LBB52_2
.Lfunc_end52:
	.size	mas_queue_status_show, .Lfunc_end52-mas_queue_status_show
                                        // -- End function
	.type	.L.str,@object          // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Unknown lld type"
	.size	.L.str, 17

	.type	.L.str.1,@object        // @.str.1
.L.str.1:
	.asciz	"%d\n"
	.size	.L.str.1, 4

	.type	process_io_prio_array,@object // @process_io_prio_array
	.section	.rodata,"a",@progbits
	.p2align	2
process_io_prio_array:
	.asciz	"fio_vip\000\000\000\000\000\000\000\000"
	.word	2099200                 // 0x200800
	.word	16777216                // 0x1000000
	.word	0                       // 0x0
	.asciz	"fio_fg\000\000\000\000\000\000\000\000\000"
	.word	2099200                 // 0x200800
	.word	0                       // 0x0
	.word	0                       // 0x0
	.asciz	"fio_sync\000\000\000\000\000\000\000"
	.word	2048                    // 0x800
	.word	0                       // 0x0
	.word	0                       // 0x0
	.asciz	"fio_async\000\000\000\000\000\000"
	.word	0                       // 0x0
	.word	0                       // 0x0
	.word	2048                    // 0x800
	.size	process_io_prio_array, 112

	.type	.L.str.2,@object        // @.str.2
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.2:
	.asciz	"\0010[BLK-IO]free counted bio, bio=0x%lx\n"
	.size	.L.str.2, 39

	.type	.L.str.3,@object        // @.str.3
.L.str.3:
	.asciz	"\0013[BLK-IO]%s: mq_iosched_init_fn failed. err = %d\n"
	.size	.L.str.3, 51

	.type	.L__func__.mas_blk_mq_init_allocated_queue,@object // @__func__.mas_blk_mq_init_allocated_queue
.L__func__.mas_blk_mq_init_allocated_queue:
	.asciz	"mas_blk_mq_init_allocated_queue"
	.size	.L__func__.mas_blk_mq_init_allocated_queue, 32

	.type	mas_blk_allocated_tags_init.__key,@object // @mas_blk_allocated_tags_init.__key
	.local	mas_blk_allocated_tags_init.__key
	.comm	mas_blk_allocated_tags_init.__key,8,1
	.type	.L.str.4,@object        // @.str.4
.L.str.4:
	.asciz	"&tags->tag_list_lock"
	.size	.L.str.4, 21

	.type	.L.str.5,@object        // @.str.5
.L.str.5:
	.asciz	"freeze_obj is NULL!"
	.size	.L.str.5, 20

	.type	.L.str.6,@object        // @.str.6
.L.str.6:
	.asciz	"\0013[BLK-IO]old protocol_nr exist! %u\n"
	.size	.L.str.6, 37

	.type	.L.str.7,@object        // @.str.7
.L.str.7:
	.asciz	"\0013[BLK-IO]%s\n"
	.size	.L.str.7, 14

	.type	.L.str.9,@object        // @.str.9
.L.str.9:
	.asciz	"\0013[BLK-IO]%s: Invalid ci_key_len!\n"
	.size	.L.str.9, 35

	.type	.L__func__.mas_blk_lld_inline_crypto_bio_split_pre,@object // @__func__.mas_blk_lld_inline_crypto_bio_split_pre
.L__func__.mas_blk_lld_inline_crypto_bio_split_pre:
	.asciz	"mas_blk_lld_inline_crypto_bio_split_pre"
	.size	.L__func__.mas_blk_lld_inline_crypto_bio_split_pre, 40

	.type	.L.str.10,@object       // @.str.10
.L.str.10:
	.asciz	"\0013[BLK-IO]%s: init key len invalid!\n"
	.size	.L.str.10, 37

	.type	.L__func__.mas_blk_lld_inline_crypto_bio_split_post,@object // @__func__.mas_blk_lld_inline_crypto_bio_split_post
.L__func__.mas_blk_lld_inline_crypto_bio_split_post:
	.asciz	"mas_blk_lld_inline_crypto_bio_split_post"
	.size	.L__func__.mas_blk_lld_inline_crypto_bio_split_post, 41

	.type	.L.str.11,@object       // @.str.11
.L.str.11:
	.asciz	"\0013[BLK-IO]%s: key len invalid!\n"
	.size	.L.str.11, 32

	.type	.L__func__.mas_blk_lld_inline_crypto_bio_merge_allow,@object // @__func__.mas_blk_lld_inline_crypto_bio_merge_allow
.L__func__.mas_blk_lld_inline_crypto_bio_merge_allow:
	.asciz	"mas_blk_lld_inline_crypto_bio_merge_allow"
	.size	.L__func__.mas_blk_lld_inline_crypto_bio_merge_allow, 42

	.type	.L.str.12,@object       // @.str.12
.L.str.12:
	.asciz	"\0013[BLK-IO]%s: init rq key len not %d or %d\n"
	.size	.L.str.12, 44

	.type	.L__func__.mas_blk_lld_inline_crypto_init_request_from_bio,@object // @__func__.mas_blk_lld_inline_crypto_init_request_from_bio
.L__func__.mas_blk_lld_inline_crypto_init_request_from_bio:
	.asciz	"mas_blk_lld_inline_crypto_init_request_from_bio"
	.size	.L__func__.mas_blk_lld_inline_crypto_init_request_from_bio, 48

	.type	.L.str.13,@object       // @.str.13
.L.str.13:
	.asciz	"Invalid ci_key_len!"
	.size	.L.str.13, 20

	.type	.L.str.14,@object       // @.str.14
.L.str.14:
	.asciz	"blk_lld has been inited already!"
	.size	.L.str.14, 33

	.type	mas_blk_dev_lld_init.__key,@object // @mas_blk_dev_lld_init.__key
	.local	mas_blk_dev_lld_init.__key
	.comm	mas_blk_dev_lld_init.__key,8,1
	.type	.L.str.15,@object       // @.str.15
.L.str.15:
	.asciz	"&(&blk_lld->write_num_lock)->rlock"
	.size	.L.str.15, 35

	.type	mas_blk_dev_lld_init.__key.16,@object // @mas_blk_dev_lld_init.__key.16
	.local	mas_blk_dev_lld_init.__key.16
	.comm	mas_blk_dev_lld_init.__key.16,8,1
	.type	.L.str.17,@object       // @.str.17
.L.str.17:
	.asciz	"&(&blk_lld->make_req_nr_lock)->rlock"
	.size	.L.str.17, 37

	.type	mas_blk_io_speed_adj_init.__key,@object // @mas_blk_io_speed_adj_init.__key
	.local	mas_blk_io_speed_adj_init.__key
	.comm	mas_blk_io_speed_adj_init.__key,8,1
	.type	.L.str.18,@object       // @.str.18
.L.str.18:
	.asciz	"(&q->mas_queue.limit_setting_protect_timer)"
	.size	.L.str.18, 44


	.ident	"Snapdragon LLVM ARM Compiler 8.0.12 for Android NDK (based on llvm.org 7.0+)"
	.section	".note.GNU-stack","",@progbits
