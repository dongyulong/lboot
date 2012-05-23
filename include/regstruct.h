#ifndef __REG_STRUCT_H
#define __REG_STRUCT_H

#include <ctype.h>

/* UART reg struct*/
#define UART_BASE 0x50000000
struct uart {
	reg32   ULCON;
	reg32   UCON;
	reg32   UFCON;
	reg32   UMCON;
	reg32   UTRSTAT;
	reg32   UERSTAT;
	reg32   UFSTAT;
	reg32   UMSTAT;
	reg8    UTXH;
	reg8    UTXH_rest[3];
	reg8    URXH;
	reg8    URXH_rest[3];
	reg32   UBRDIV;
}; /*__attribute__((__packed__));*/
static inline struct uart *get_uart_base(u32 nr){
	return (struct uart *)(UART_BASE + 0x4000 * nr);
}


/* NAND FLASH (see manual chapter 6) */
#define NAND_BASE 0x4E000000
struct nand {
	reg32 	NFCONF;
	reg32 	NFCONT;
	reg32 	NFCMD;
	reg32 	NFADDR;
	reg32 	NFDATA;
	reg32	NFMECCD0;
	reg32	NFMECCD1;
	reg32	NFSECCD;
	reg32	NFSTAT;
	reg32	NFESTAT0;
	reg32	NFESTAT1;
	reg32	NFMECC0;
	reg32	NFMECC1;
	reg32	NFSECC;
	reg32	NFSBLK;
	reg32	NFEBLK;
};
static inline struct nand *get_nand_base(void){
	return (struct nand *)(NAND_BASE);
}

#endif
