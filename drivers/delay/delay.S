.global lboot_delay
lboot_delay:
1:	nop
	subs r0, r0, #1
	bne	1b

	mov pc, lr
	

