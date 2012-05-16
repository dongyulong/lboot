#include <stdio.h>
#include <uart.h>

char (*lboot_getchar)(void);


char getchar(void)
{
	/*
	return lboot_getchar();
	*/
	return uart_receive_char();
}

