#include <config.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

static int _shell_prompt(char *);
static void _shell_backspace(char *, u32 *, u32 *, const u32);
static void _shell_delete(char *, u32 *, u32 *, const u32);
static void _shell_direction_control(char *, u32 *, u32 *, const u32);
static void _shell_default(char *, const u32, u32 *, u32 *, const u32);

int shell(void)
{
	u32 n, cur, pr_len;
	char ch;
	static char buffer[CFG_SHELL_BUFFER_SIZE];

	pr_len = _shell_prompt(buffer);

	buffer[pr_len] = '\0';

	while(1){
		n = pr_len;
		cur = n;
		buffer[n] = '\0';
		printf(CFG_PROMPTION);

		while(1){
			ch = getchar();

			switch(ch){
				case '\n':
					continue;
				case '\r':
					putchar('\n');
					goto OK;
				case '\b':	//backspace
					if(cur <= pr_len + 1)
						continue;
					_shell_backspace(buffer, &cur, &n, pr_len);
					break;
				case 0x7f:	//delete
					if(cur >= n)
						continue;
					_shell_delete(buffer, &cur, &n, pr_len);
					break;
				case 0x1b:
					ch = getchar();
					switch(ch){
						case 0x5b:
							_shell_direction_control(buffer, &cur, &n, pr_len);
							break;
						default:
							;
					}
					break;
				default:
					_shell_default(buffer, ch, &cur, &n, pr_len);
			}
		}
OK:
		buffer[n] = '\0';
		puts(buffer + pr_len);

	}

	return 0;
}

static int _shell_prompt(char *buf)
{
	strcpy(buf, CFG_PROMPTION);

	return strlen(CFG_PROMPTION);
}

static void _shell_direction_control(char *buffer, u32 *cur, u32 *n, const u32 pr_len)
{
	u32 ch;

	ch = getchar();
	switch(ch){
		case 0x41:	//up
			break;
		case 0x42:	//down
			break;
		case 0x43:	//right
			if(*cur < *n){
				putchar(buffer[*cur]);
				*cur = *cur + 1;
			}
			break;
		case 0x44:	//left
			if(*cur > pr_len){
				putchar('\b');
				*cur = *cur - 1;
			}
			break;
		default:
			;
	}
}
static void _shell_delete(char *buffer, u32 *cur, u32 *n, const u32 pr_len)
{
	u32 tmp = *cur;
	//buffer
	while(tmp < *n){
		buffer[tmp] = buffer[tmp + 1];
		tmp++;
	}
	*n = *n - 1;
	buffer[*n] = '\0';
	//cursor
	tmp = *cur;
	while(tmp < *n)
		putchar(buffer[tmp++]);
	putchar(0x20);
	while(tmp >= *cur)
		putchar('\b');
}
static void _shell_backspace(char *buffer, u32 *cur, u32 *n, const u32 pr_len)
{
	u32 tmp = *cur;
	//buffer
	while(tmp < *n){
		buffer[tmp - 1] = buffer[tmp];
		tmp++;
	}
	*cur = *cur - 1;
	*n = *n - 1;
	buffer[*n] = '\0';
	// cursor.
	putchar('\b');
	tmp = *cur;
	while(tmp < *n)
		putchar(buffer[tmp++]);
	putchar(0x20);
	while(tmp-- >= *cur)
		putchar('\b');
}
static void _shell_default(char *buffer, const u32 ch, u32 *cur, u32 *n, const u32 pr_len)
{
	u32 len;
	char p[2048];
	//buffer
	len = *n - *cur;
	strncpy(p, buffer + *cur, len);
	p[len] = '\0';

	buffer[*cur] = ch;
	*cur = *cur + 1;
	strncpy(buffer + *cur, p, len);
	*n = *n + 1;
	//cursor
	putchar(ch);
	console_puts(p);

	while(len-- > 0)
		putchar('\b');

}
