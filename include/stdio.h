#ifndef __STDIO_H
#define __STDIO_H

#include <uart.h>

#define NULL 0

int printf(const char *format, ...);
char *gets(char *s);
int puts(const char *s);
int putchar(int ch);
int getchar(void);

/*void scanf();*/

#endif
