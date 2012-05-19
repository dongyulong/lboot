#include <stdio.h>

int puts(const char *s)
{
	int n = 0;

	if(!s)
		return NULL;

	while(*s){
		send_char(*s);
		n++;
	}

	return n;
}

char* gets(char *s)
{
	int c;
	int n = 0;
	while((c = receive_char()) != '\n'){
		if(c == -1){
			*s = 0;
			return NULL; 
		}   
		s[n++] = c;
	}   
	s[n] = '\0';
	return s;

	/*
	char *p = str;

	if(!p)
		return NULL;
	
	while
	*p = receive_char();
	p++;

	
	return str;
	*/
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

