#ifndef __UART_H
#define __UART_H

void uart_init(void);
int send_char(const int ch);
int receive_char(void);

#endif
