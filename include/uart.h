#ifndef __UART_H
#define __UART_H

/* UART reg struct*/
struct s3c2440_uart {
    u32   ULCON;
    u32   UCON;
    u32   UFCON;
    u32   UMCON;
    u32   UTRSTAT;
    u32   UERSTAT;
    u32   UFSTAT;
    u32   UMSTAT;
#ifdef __BIG_ENDIAN
    u32    res1[3];
    u32    UTXH;
    u32    res2[3];
    u32    URXH;
#else /* Little Endian */
    u32    UTXH;
    u32    res1[3];
    u32    URXH;
    u32    res2[3];
#endif
    u32   UBRDIV;
} __attribute__((__packed__));

void uart_init();

#endif
