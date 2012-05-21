#include <config.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

static int _shell_prompt(char *);
static void _shell_default(char *, const u32, u32 *, u32 *, const u32);

int shell(void)
{
	u32 n, cur, tmp, pr_len;
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
				if(n <= pr_len || cur <= pr_len)
					continue;
				buffer[--n] = '\0';
				putchar(ch);
				putchar(0x20);
				putchar(ch);
				cur--;
				break;
			case 0x7f:	//delete
					tmp = cur;
					while(tmp < n - 1){
						buffer[tmp] = buffer[tmp + 1];
						putchar(buffer[tmp]);
						tmp++;
					}
					putchar(0x20);
					n--;
					while(tmp > cur)
						putchar('\b');
					break;
			case 0x1b:
				ch = getchar();
				switch(ch){
				case 0x5b:
					ch = getchar();
				//	printf("ch = %d\n", ch);
					switch(ch){
					case 0x41:	//up
						break;
					case 0x42:	//down
						break;
					case 0x43:	//right
						if(cur < n){
							putchar(buffer[cur]);
							cur++;
						}
						break;
					case 0x44:	//left
						printf("[left]");
						if(cur > pr_len){
							putchar('\b');
							cur--;
						}
						break;
					}
					break;
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

static void _shell_default(char *buffer, const u32 ch, u32 *cur, u32 *n, const u32 pr_len)
{
	u32 len;
	char p[2048];

	len = *n - *cur;
	strncpy(p, buffer + *cur, len);
	p[len] = '\0';

	buffer[*cur] = ch;
	*cur = *cur + 1;
	strncpy(buffer + *cur, p, len);
	*n = *n + 1;

	putchar(ch);
	console_puts(p);

}
