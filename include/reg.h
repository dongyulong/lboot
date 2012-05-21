
#ifndef __REG_H
#define __REG_H


#define GPHCON 		(*(volatile unsigned long *)0x56000070)
#define GPHUP 		(*(volatile unsigned long *)0x56000078)


#if 0
/************** UART 0**************/
#define ULCON0		(*(volatile unsigned long *)0x50000000)
#define UCON0		(*(volatile unsigned long *)0x50000004)
#define UFCON0		(*(volatile unsigned long *)0x50000008)
#define UMCON0		(*(volatile unsigned long *)0x5000000c)
#define UTRSTAT0	(*(volatile unsigned long *)0x50000010)
#define UTXH0 		(*(volatile unsigned long *)0x50000020)
#define URXH0		(*(volatile unsigned long *)0x50000024)
#define UBRDIV0		(*(volatile unsigned long *)0x50000028)
#endif

/************* nand ****************/
#define NFCONF		(*(volatile unsigned long *)0x4e000000)
#define NFCONT		(*(volatile unsigned long *)0x4e000004)
#define NFCMD		(*(volatile unsigned long *)0x4e000008)
#define NFADDR		(*(volatile unsigned long *)0x4e00000c)
#define NFDATA		(*(volatile unsigned long *)0x4e000010)
#define NFSTAT		(*(volatile unsigned long *)0x4e000020)


#endif	/* __REG_H */
