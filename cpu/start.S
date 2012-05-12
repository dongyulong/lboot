/*
 *	ARM S3C2440 BOOT.
 *	Copyright (c) 2012-4-27 Li Xiubo superlibj@gmail.com
 *
 */

/*
 *	b _reset						;reset exception : 0x00000000
 *	b _undefined_instruction		;undefined instruction : 0x00000004
 *	b _software_interrupt			;software interrupt : 0x00000008
 *	b _prefetch_instruction_abort   ;prefetch instruction exception abort : 0x0000000C
 *	b _prefetch_data_abort			;prefetch data exception abort : 0x00000010
 *	b _unused						;reserved : 0x00000014
 *	b _extern_irq					;external interrupt : 0x00000018
 *	b _fast_irq						;fast interrupt : 0x0000001C
 */



	.text
.global _start
_start:
	b	_reset
	ldr pc, _undefined_instruction
	ldr pc, _software_interrupt
	ldr pc, _prefetch_instruction_abort
	ldr pc, _prefetch_data_abort
	ldr pc, _unused
	ldr pc, _extern_irq
	ldr pc, _fast_irq

_undefined_instruction:
	.word __undefined_instruction
_software_interrupt:
	.word __software_interrupt
_prefetch_instruction_abort:
	.word __prefetch_instruction_abort
_prefetch_data_abort:
	.word __prefetch_data_abort
_unused:
	.word __unused
_extern_irq:
	.word __extern_irq
_fast_irq:
	.word __fast_irq

	.balignl 16,0xdeadbeef

/*
 *************************************************************************
 *
 * Begin Boot Code
 *
 *************************************************************************
 */

_reset:
/*
 * User (usr): The normal ARM program execution state
 * FIQ (fiq): Designed to support a data transfer or channel process
 * IRQ (irq): Used for general-purpose interrupt handling
 * Supervisor (svc): Protected mode for the operating system
 * Abort mode (abt): Entered after a data or instruction prefetch abort
 * System (sys): A privileged user mode for the operating system
 * Undefined (und): Entered when an undefined instruction is executed
 *
 *	CPSR bit map
 *	31   30   29   28   27   26   25   24  …  8   7   6   5   4   3   2   1   0
 *	N    Z    C    V    .    .    .    .   …  .   I   F   T   M4  M3  M2  M1  M0
 *	
 *	M[4: 0]			ARM CPU's running mode		The registers can be accessed
 *	0b10000			User mode					PC，CPSR,R0-R14
 *	0b10001			FIQ mode					PC，CPSR, SPSR_fiq，R14_fiq-R8_fiq, R7～R0
 *	0b10010			IRQ mode					PC，CPSR, SPSR_irq，R14_irq,R13_irq,R12～R0
 *	0b10011			Supervisor mode				PC，CPSR, SPSR_svc，R14_svc,R13_svc,,R12～R0,
 *	0b10111			Abort mode					PC，CPSR, SPSR_abt，R14_abt,R13_abt, R12～R0,
 *	0b11011			Undefined mode				PC，CPSR, SPSR_und，R14_und,R13_und, R12～R0,
 *	0b11111			System mode					PC，CPSR（ARM v4 and later）, R14～R0
 *
 *	I	Meaning disable external(hardware) interrupt(bit I=1)
 *	F	Meaning disable fast interrupt(bit F=1)
 *	T	Meaning running int Thumb (bit T=1) state or in Arm(bit T=0) state
 *	N	Negative/Less Than
 *	Z	Zero
 *	C	Carry/Borrow/Extend
 *	V	Overflow
 */

	mrs	r0,cpsr		/* Read cpsr value to r0 */
	bic	r0,r0,#0x1f /* Clear M0~M4 */
	orr	r0,r0,#0xd3	/* 0b110 10011 */
	msr cpsr, r0	/* In supervisor mode, disabling IRQ and FIQ, running at arm state */

#define WATCH_DOG_CON 0x53000000	/* Watchdog timer control register */
	ldr r0, =WATCH_DOG_CON	/* Disables watchdog */
	mov r1, #0x0
	str r1, [r0]

#define INTMSK		  0x4A000008	/* Interupt-Controller base addresses */
	mov	r1, #0xffffffff	/* mask all IRQs by setting all bits in the INTMSK */
	ldr	r0, =INTMSK
	str	r1, [r0]

	bl clock_init
	bl memory_init

	bl led_on /* light led refer Documents/led.txt */







__undefined_instruction:
	b .
__software_interrupt:
	b .
__prefetch_instruction_abort:
	b .
__prefetch_data_abort:
	b .
__unused:
	b .
__extern_irq:
	b .
__fast_irq:
	b .
