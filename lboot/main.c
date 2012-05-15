#include <stdio.h>
#include <uart.h>

int main(void)
{
	uart_init();
	printf("uart is initialized completely!!\n");

	return 0;
}
