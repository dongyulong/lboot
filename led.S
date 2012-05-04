/*
 *	TQ2440 LED CONTROL.
 *	Copyright (c) 2012-4-28 Dong Yulong dongyl0501@gmail.com
 *
 */
#include "reg.h"

.global led_on
led_on:
	ldr	r0, =GPBCON
	mov	r1, #0x15400
	str	r1, [r0]

	ldr	r0, =GPBDAT
	mov	r1, #0x0
	str	r1, [r0]
