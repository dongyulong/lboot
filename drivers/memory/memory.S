	.text
	.align 2
.globl memory_init
memory_init:

	mov r4, lr

/* Because the code is running at stepstone flash,
 * which address is 0x00000000, while the start 
 * address of the lboot.bin binary code is 0x33f80000, 
 * so we should minus the 0x33f80000.
 * The whole addresses of the code will use are physical
 * address.
 */

	ldr     r0, =REGDATA
	ldr	r1, =0x33f80000
	sub	r0, r0, r1
#define MEMCTL_BASE 0x48000000
	ldr	r1, =MEMCTL_BASE
	add     r2, r0, #13*4
0:
	ldr     r3, [r0], #4
	str     r3, [r1], #4
	cmp     r2, r0
	bne     0b

	mov lr, r4
	mov	pc, lr

/*
 * The configure value of the memory control registers.
 */

REGDATA:
	.word   0x2211d110	@BWSCON		/* Bank6/7 not using UB/LB; WAIT disable; 
									 * data bus width is 32-bit.
									 */
	.word   0x00000700	@BACKCON0	/* Bank0~5 control registers are all using 
									 * default value
									 */
	.word   0x00000700	@BACKCON1
	.word   0x00000700	@BACKCON2
	.word   0x00000700	@BACKCON3
	.word   0x00000700	@BACKCON4
	.word   0x00000700	@BACKCON5
	.word   0x00018005	@BACKCON6	/* Bank6~7 are all SDRAM, clume address lines are 9.
									 */
	.word   0x00018005	@BACKCON7
	.word   0x00ac04f5	@REFRESH   /* SDRAM Refresh Enable;
									* SDRAM Refresh Mode --> CBR/Auto Refresh
									* SDRAM refresh count value.
									* 
									* Refresh period = (2^11-refresh_count+1)/HCLK
									* If refresh period is 7.8 us and HCLK is 100MHz,
									* the refresh count is as follows:
									* Refresh count = 2^11 + 1 - 100x7.8 = 1269
									*
									*/
	.word   0x000000b1	@BANKSIZE  /* Enable burst operation;
									* SDRAM power down mode enable;
									* SCLK is active only during the access;
									* BANK6/7 memory map is 64M.
									*
									* In the Power-Down mode, the on-chip oscillator 
									* and the Flash memory are stopped in order to 
									* minimize power consumption.
									* 
									* A data transmission mode in which data is sent faster 
									* than normal. There are a number of techniques for 
									* implementing burst modes. In a data bus, for example, 
									* a burst mode is usually implemented by allowing a 
									* device to seize control of the bus and not permitting
									* other devices to interrupt. In RAM, burst modes are
									* implemented by automatically fetching the next memory
									* contents before they are requested. This is essentially
									* the same technique used by disk caches.
									* The one characteristic that all burst modes have in 
									* common is that they are temporary and unsustainable. 
									* They allow faster data transfer rates than normal, 
									* but only for a limited period of time and only under 
									* special conditions.
									*/
	.word   0x00000030	@MRSRB6	   /*  SDRAM MODE REGISTER SET REGISTER (MRSR) */
	.word	0x00000030	@MRSRB7

