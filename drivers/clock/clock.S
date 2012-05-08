
#define	CLKDIVN		0x4C000014 /* CLOCK DIVIDER CONTROL (CLKDIVN) REGISTER */
#define MPLLCON		0x4C000004 /* MPLL CONTROL REGISTER */
#define UPLLCON		0x4C000008 /* UPLL CONTROL REGISTER */

#define mMDIV_405 	0x7f 
#define mPDIV_405	0x02 
#define mSDIV_405	0x01 

#define uMDIV_48 	0x38 
#define uPDIV_48	0x02 
#define uSDIV_48	0x02 


.global clock_init
clock_init:
	
	mov r3, lr

	/*
	* HDIVN = 0b01; PDIVN = 0b1; FCLK:HCLK:PCLK = 1:2:4
	* HDIVN = 0b10; PDIVN = 0b1;
	* if clock->CAMDIVN[9] == 0, FCLK:HCLK:PCLK = 1:4:8
	* if clock->CAMDIVN[9] == 1, FCLK:HCLK:PCLK = 1:8:16
	*
	* CLKDIVN should be set carefully not to exceed the 
	* limit of HCLK and PCLK.
	* If HDIVN is not 0, the CPU bus mode has to be changed 
	* from the fast bus mode to the asynchronous bus mode
	* using following instructions(S3C2440 does not support 
	* synchronous bus mode).
	*
	* MMU_SetAsyncBusMode
	*		mrc p15,0,r0,c1,c0,0
	*		orr r0,r0,#R1_nF:OR:R1_iA
	*		mcr p15,0,r0,c1,c0,0
	*
	* If HDIVN is not 0 and the CPU bus mode is the fast 
	* bus mode, the CPU will operate by the HCLK.
	* This feature can be used to change the CPU frequency 
	* as a half or more without affecting the HCLK and PCLK.
	*/

	ldr	r0, =CLKDIVN
	mov	r1, #0x5	
	str	r1, [r0]

	mrc	p15, 0, r1, c1, c0, 0
	orr	r1, r1, #0xc0000000
	mcr	p15, 0, r1, c1, c0, 0

	/* NOTE:
	* When you set MPLL & UPLL values, you have to set the UPLL
	* value first and then the MPLL value. (Needs intervals
	* approximately 7 NOP)
	*/

	/* For USB clock, must be 48M 
	*
	* Upll = (m * Fin) / (p * 2S)
	* m = (MDIV + 8), p = (PDIV + 2), s = SDIV
	*
	* m = uMDIV_48 + 8 = 0x38 + 8 = 64;
	* p = uPDIV_48 + 2 = 0x02 + 2  = 4;
	* s = uSDIV_48 = 2;
	* Fin = 12M;
	*
	* UCLK = (64 * 12) / (4 * (2 ^ 2)) = (64 * 12) / 16 = 48M;
	*/
	ldr r0, =UPLLCON
	ldr	r1, =(uMDIV_48 << 12) | (uPDIV_48 << 4) | uSDIV_48
	str r1, [r0]

	mov r0,#0x20
	bl lboot_delay

	/*
	* Mpll = (2 * m * Fin) / (p * 2S)
	* m = (MDIV + 8), p = (PDIV + 2), s = SDIV
	*
	* FCLK = (2 * m * Fin) / (p * (2 ^ s));	
	* m = mMDIV_405 + 8 = 0x7f + 8 = 135;
	* p = mPDIV_405 + 2 = 0x02 + 2  = 4;
	* s = mSDIV_405 = 1;
	* Fin = 12M;
	*
	* FCLK = (2 * 135 * 12) / (4 * (2 ^ 1)) = 3240 / 8 = 405M;
	*/
	ldr	r0, =MPLLCON
	ldr	r1, =(mMDIV_405 << 12) | (mPDIV_405 << 4) | mSDIV_405
	str	r1, [r0]

	mov lr, r3
	mov	pc, lr


