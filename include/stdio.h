#ifndef __STDIO_H
#define __STDIO_H

#include <uart.h>

#define NULL 0

int printf(const char *format, ...);
char *gets(char *str);
int puts(const char *str);
int putchar(int ch);
int getchar(void);

/*void scanf();*/

#endif
