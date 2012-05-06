/*
 *	TQ2440 LED CONTROL.
 *	Copyright (c) 2012-4-28 Dong Yulong dongyl0501@gmail.com
 *
 */

.global led_on
led_on:
#define GPBCON	0x56000010	/* PORT B CONTROL REGISTERS */
	ldr	r0, =GPBCON
	mov	r1, #0x15400
	str	r1, [r0]

#define GPBDAT  0x56000014	/* PORT B DATA REGISTERS */
	ldr	r0, =GPBDAT
	mov	r1, #0x0
	str	r1, [r0]
