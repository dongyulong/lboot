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
 *	b .								;reserved : 0x00000014
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
	b	.
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
_extern_irq:
	.word __extern_irq
_fast_irq:
	.word __fast_irq

_reset:





__undefined_instruction:
	b .
__software_interrupt:
	b .
__prefetch_instruction_abort:
	b .
__prefetch_data_abort:
	b .
__extern_irq:
	b .
__fast_irq:
	b .
