#ifndef __REG_STRUCT_H
#define __REG_STRUCT_H

#include <ctype.h>

/* UART reg struct*/
struct uart {
    u32   ULCON;
    u32   UCON;
    u32   UFCON;
    u32   UMCON;
    u32   UTRSTAT;
    u32   UERSTAT;
    u32   UFSTAT;
    u32   UMSTAT;
    u8    UTXH;
    u8    UTXH_rest[3];
    u8    URXH;
    u8    URXH_rest[3];
    u32   UBRDIV;
}; /*__attribute__((__packed__));*/

#define UART_BASE 0x50000000
static inline struct uart *get_uart_base(u32 nr){
	return (struct uart *)(UART_BASE + 0x4000 * nr);
}


#endif
