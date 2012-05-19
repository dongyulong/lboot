#include <stdio.h>

int lboot_main(void)
{
	char s[1000];
	char *p;

	uart_init();

	while(1){
//		puts("lboot...\n");
		p = gets(s);
			
		puts(p);

	}
	printf("uart is initialized completely!!\n");

	return 0;
}
