#include <stdio.h>

extern void shell(void);


int lboot_main(void)
{
	uart_init();

	putchar('\n');

	shell();

	return 0;
}
