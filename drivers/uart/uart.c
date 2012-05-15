#include <config.h>
#include <reg.h>
#include <uart.h>


static void send_char(char ch);
static char receive_char();

struct s3c2440_uart uart;

void uart_init()
{
	GPHCON |= 0xa0;  /*GPH2 is set to TXD0, GPH3 is set to RXD0*/
	GPHUP = 0x0c;	/*GPH2 and GPH3 are set to pull up*/

	ULCON0 = 0x03; /* 8-bits data*/
	UCON0 = 0x05;  /*polling mode*/
	UFCON0 = 0x00; /*do not use FIFO function*/
	UMCON0 = 0x00; /*do not use UART MODEM*/
	/*
	*PCLK=405M/8=50625KHZ=UART clock
	*UBRDIVn = (int) (UART clock / (buad rate * 16 ) ) - 1
	*UBRDIVn=(int)(50625KHZ/(115200*16))-1=(int)27.4658203125-1=26
	*tUPCLK=(26+1)*16*1Frame/50625KHZ=432*1Frame/50625KHZ
	*tUEXACT=1Frame/115200
	*UART error=(tUPCLK-tUEXACT)/tUEXACT*100%
	*	=(tUPCLK/tUEXACT -1)*100%
	*	=432/(115200*50625K)*100%
	*	=432/(5832000M)*100%
	*	=0.0074%/M < 1.87%
	*
	*/
	UBRDIV0 = 26;  /*baud rate is 115200*/

}

void prinf(char *str)
{
	while (*str) {
			send_char(str);
			str++;
	}
}

void putchar(char ch)
{
	send_char(&ch);
}

char getchar()
{
	return receive_char();
}

static void send_char(char *pch)
{
	while ( !((UTRSTAT0 >> 1) & 0x1)) ;
	UTXH0 = *pch;
}

static char receive_char()
{
	unsigned long ch;

	while ( !(UTRSTAT0 & 0x1)) ;
	ch = URXH0;

	return (char)ch; 
}
