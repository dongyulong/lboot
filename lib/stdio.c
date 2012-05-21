#include <stdio.h>
#include <stdarg.h>

int console_puts(const char *s)
{
	int count = 0;

	if(!s)
		return 0;

	while(*s != '\0'){
		putchar(*s);
		s++;
		count++;
	}

	return count;
}


int puts(const char *s)
{
	int count;

	count = console_puts(s);
	putchar('\n');

	return count;
}

char* gets(char *s)
{
	char c;
	int n = 0;

	do{
		c = receive_char();
		s[n++] = c;
	}while( c != '\n'); 

	s[n] = '\0';

	return s;
}

int putchar(int ch)
{
	return send_char(ch);
}

int getchar(void)
{
	return receive_char();
}


extern int vsprintf(char *buf, const char *fmt, va_list args);
#define CONFIG_SYS_BUFFER_SIZE 4096
int printf(const char *format, ...)
{
	unsigned long count;
	va_list args;
	char printbuffer[CONFIG_SYS_BUFFER_SIZE];
	char *s = printbuffer;

	va_start(args, format);

	count = vsprintf(printbuffer, format, args);

	va_end(args);

	while(*s)
		send_char(*s++);

	return count;
}

