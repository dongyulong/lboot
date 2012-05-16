
#ifndef __STDIO_H
#define __STDIO_H

#include <config.h>

extern void (*lboot_print) (const char *str);
extern void (*lboot_putchar)(char *ch);
extern char (*lboot_getchar)(void);

void printf(const char *fmt, ...);
/*void scanf();*/
void putchar(char ch);
char getchar(void);

#endif
