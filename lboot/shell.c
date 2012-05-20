#include <config.h>
#include <stdio.h>

static void promption(void);

int shell(void)
{
	int n;
	char ch;
	static char buffer[CFG_SHELL_BUFFER_SIZE];

	while(1){
		n = 0;
		promption();
		while((ch = getchar()) != '\r'){
			putchar(ch);
			buffer[n++] = ch;
		}
		if(ch == '\r')
			putchar('\n');

		buffer[n] = '\0';
		puts(buffer);
	}

	return 0;
}

static void promption(void)
{
	printf("["CFG_USER"@"CFG_HOST_NAME"] ");
}


