	.arch armv8-a
	.text
	.global ack
	.type	ack, %function
ack:
	stp	x29, x30, [sp, -96]!
	mov	x29, sp
	str	x0, [sp, 16]
	str	x1, [sp, 24]
	mov	x0, 0
	movk	x0, 0, lsl 16
	movk	x0, 0, lsl 32
	movk	x0, 0, lsl 48
	str	x0, [sp, 32]
	mov	x0, 1
	movk	x0, 0, lsl 16
	movk	x0, 0, lsl 32
	movk	x0, 0, lsl 48
	str	x0, [sp, 40]
	ldr	x0, [sp, 16]
	ldr	x1, [sp, 32]
	cmp	x0, x1
	cset	x0, eq
	str	x0, [sp, 48]
	ldr	x0, [sp, 48]
	cbz	x0, .LFack6
	b	.LFack4
.LFack4:
	ldr	x0, [sp, 24]
	ldr	x1, [sp, 40]
	add	x0, x0, x1
	str	x0, [sp, 56]
	ldr	x0, [sp, 56]
	b	.Lack.ret
.LFack6:
	ldr	x0, [sp, 24]
	ldr	x1, [sp, 32]
	cmp	x0, x1
	cset	x0, eq
	str	x0, [sp, 64]
	ldr	x0, [sp, 64]
	cbz	x0, .LFackc
	b	.LFack8
.LFack8:
	ldr	x0, [sp, 16]
	ldr	x1, [sp, 40]
	sub	x0, x0, x1
	str	x0, [sp, 72]
	ldr	x1, [sp, 40]
	ldr	x0, [sp, 72]
	bl	ack
	str	x0, [sp, 56]
	ldr	x0, [sp, 56]
	b	.Lack.ret
.LFackc:
	ldr	x0, [sp, 16]
	ldr	x1, [sp, 40]
	sub	x0, x0, x1
	str	x0, [sp, 72]
	ldr	x0, [sp, 24]
	ldr	x1, [sp, 40]
	sub	x0, x0, x1
	str	x0, [sp, 80]
	ldr	x1, [sp, 80]
	ldr	x0, [sp, 16]
	bl	ack
	str	x0, [sp, 88]
	ldr	x1, [sp, 88]
	ldr	x0, [sp, 72]
	bl	ack
	str	x0, [sp, 96]
	ldr	x0, [sp, 96]
	b	.Lack.ret
.LFack13:
.Lack.ret:
	ldp	x29, x30, [sp], 96
	ret
	.global main
	.type	main, %function
main:
	stp	x29, x30, [sp, -48]!
	mov	x29, sp
	str	x19, [sp, 32]
	mov	x19, x1
	ldr	x0, [x19, 8]
	bl	int_of_string
	str	x0, [sp, 16]
	ldr	x0, [x19, 16]
	bl	int_of_string
	str	x0, [sp, 24]
	ldr	x1, [sp, 24]
	ldr	x0, [sp, 16]
	bl	ack
	str	x0, [sp, 32]
	ldr	x0, [sp, 32]
	bl	priint
	mov	w0, 10
	bl	putchar
.LFmain3:
.Lmain.ret:
	ldr	x19, [sp, 32]
	mov	w0, 0
	ldp	x29, x30, [sp], 48
	ret
