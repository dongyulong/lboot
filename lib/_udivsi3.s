dividend	.req	r0
divisor		.req	r1
result		.req	r2
curbit		.req	r3
	.text
	.globl	 __udivsi3
__udivsi3:
	cmp	divisor, #0
	beq	Ldiv0
	mov	curbit, #1
	mov	result, #0
	cmp	dividend, divisor
	bcc	Lgot_result
Loop1:
	cmp	divisor, #0x10000000
	cmpcc	divisor, dividend
	movcc	divisor, divisor, lsl #4
	movcc	curbit, curbit, lsl #4
	bcc	Loop1
Lbignum:
	cmp	divisor, #0x80000000
	cmpcc	divisor, dividend
	movcc	divisor, divisor, lsl #1
	movcc	curbit, curbit, lsl #1
	bcc	Lbignum
Loop3:
	cmp	dividend, divisor
	subcs	dividend, dividend, divisor
	orrcs	result, result, curbit
	cmp	dividend, divisor, lsr #1
	subcs	dividend, dividend, divisor, lsr #1
	orrcs	result, result, curbit, lsr #1
	cmp	dividend, divisor, lsr #2
	subcs	dividend, dividend, divisor, lsr #2
	orrcs	result, result, curbit, lsr #2
	cmp	dividend, divisor, lsr #3
	subcs	dividend, dividend, divisor, lsr #3
	orrcs	result, result, curbit, lsr #3
	cmp	dividend, #0			@ Early termination?
	movnes	curbit, curbit, lsr #4		@ No, any more bits to do?
	movne	divisor, divisor, lsr #4
	bne	Loop3
Lgot_result:
	mov	r0, result
	mov	pc, lr
Ldiv0:
	str	lr, [sp, #-4]!
	bl	 __div0       (PLT)
	mov	r0, #0			@ about as wrong as it could be
	ldmia	sp!, {pc}
