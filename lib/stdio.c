#include <stdio.h>

int puts(const char *s)
{
	int n = 0;

	if(!s)
		return -1;

	while(*s){
		send_char(*s);
		s++;
		n++;
	}

	send_char('\n');
	return n;
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

int printf(const char *format, ...)
{
//	while (*str) {
//			send_char(str);
//			str++;
//	}
	return 0;
}

