/*
 *	TQ2440 LED CONTROL.
 *	Copyright (c) 2012-4-28 Dong Yulong dongyl0501@gmail.com
 *
 */

#define GPBCON	0x56000010	/* PORT B CONTROL REGISTERS */
#define GPBDAT  0x56000014	/* PORT B DATA REGISTERS */

.global led_on
led_on:
	ldr	r0, =GPBCON
	mov	r1, #0x15400
	str	r1, [r0]

1:
	ldr	r0, =GPBDAT
	mov	r1, #0x0
	str	r1, [r0]

	mov r0, #0x100000
	bl lboot_delay

	ldr	r0, =GPBDAT
	ldr	r1, =0x3ff
	str	r1, [r0]

	mov r0, #0x100000
	bl lboot_delay

	b 1b
