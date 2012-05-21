#include <stdio.h>
#include <string.h>


char *strcpy(char *dest, const char *src)
{
	char *p = dest;

	while((*dest++ = *src++) != '\0');

	return p;
}

char *strncpy(char *dest, const char *src, u32 len)
{
	char *p = dest;

	while(len-- && ((*dest++ = *src++) != '\0'));

	return p;
}

u32 strlen(const char *s)
{
	u32 len = 0;

	while(*s++ != '\0')
		len++;

	return len;
}




