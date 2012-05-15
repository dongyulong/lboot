/*
 *	TQ2440 LED CONTROL.
 *	Copyright (c) 2012-4-28 Dong Yulong dongyl0501@gmail.com
 *
 */

#include <config.h>

#ifdef S3C2440_UPLOOKING
#define GPBCON_ADDR	 0x56000040	/* PORT B CONTROL REGISTERS */
#define GPBDAT_ADDR  0x56000044	/* PORT B DATA REGISTERS */
#define GPBCON_VALUE 0x05000000
#define GPE12	(1 << 12)
#define GPE13	(1 << 13)
#define LED1	GPE12
#define LED2	GPE13
#define LEDS	(GPE12 | GPE13)
#else
#define GPBCON_ADDR	 0x56000010	/* PORT B CONTROL REGISTERS */
#define GPBDAT_ADDR  0x56000014	/* PORT B DATA REGISTERS */
#define GPBCON_VALUE 0x00015400
#define GPB5	(1 << 5)
#define GPB6	(1 << 6)
#define GPB7	(1 << 7)
#define GPB8	(1 << 8)
#define LED1	GPB5
#define LED2	GPB6
#define LED3	GPB7
#define LED4	GPB8
#define LEDS	(GPB5 | GPB6 | GPB7 | GPB8)
#endif

.global led_on
led_on:
	ldr	r2, =GPBCON_ADDR
	mov	r1, #GPBCON_VALUE
	str	r1, [r2]

	ldr r2, =GPBDAT_ADDR
	ldr r1, [r2]
1:
	bic r1, r1, #LEDS
	orr r1, r1, #LED1
	str	r1, [r2]

	mov r0, #0x1000000
	bl lboot_delay

	bic r1, r1, #LEDS
	orr r1, r1, #LED2
	str	r1, [r2]

	mov r0, #0x1000000
	bl lboot_delay

#ifndef S3C2440_UPLOOKING
	bic r1, r1, #LEDS
	orr r1, r1, #LED3
	str	r1, [r2]

	mov r0, #0x1000000
	bl lboot_delay

	bic r1, r1, #LEDS
	orr r1, r1, #LED4
	str	r1, [r2]

	mov r0, #0x1000000
	bl lboot_delay
#endif
	b 1b
