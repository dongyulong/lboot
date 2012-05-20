#include <stdio.h>

int lboot_main(void)
{
	char ch;

	uart_init();

	while(1){
		ch = getchar();
		if(ch == '\r')
			putchar('\n');
		putchar(ch);
		printf("lboot ... \n");
	}

	return 0;
}
