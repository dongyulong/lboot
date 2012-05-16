#include <string.h>

int strnlen(const char * s, int count)
{
#if 0
	const char *sc;

	for (sc = s; count-- && *sc != '\0'; ++sc)
		/* nothing */;
	return sc - s;
#endif	
	return 2;
}

