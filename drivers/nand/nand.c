#include <stdio.h>
#include <reg.h>
#include <regstruct.h>
#include <nand.h>

static struct nand *nand;

static inline void nand_select_chip(void)
{
	nand->NFCONT &= ~(0x01 << 1);
}

static inline void nand_deselect_chip(void)
{
	nand->NFCONT |= (0x01 << 1);
}

static inline void nand_cmd(unsigned long cmd)
{
	nand->NFCMD = cmd;
}

static inline void nand_write_addr_reg(unsigned long addr)
{
	nand->NFADDR = addr & 0xff;
	nand->NFADDR = (addr >> 9) & 0xff;
	nand->NFADDR = (addr >> 17) & 0xff;
	nand->NFADDR = (addr >> 25) & 0xff;
}

static inline char nand_read_data_reg(void)
{
	return (nand->NFDATA & 0xff);
}

static inline void nand_wait_cmd_complete(void)
{
	while (!(nand->NFSTAT & 0x01)) ;
}

static void nand_reset(void)
{
	nand_select_chip();
	nand_cmd(0xff);
	nand_wait_cmd_complete();
	nand_deselect_chip();	
}

void nand_init(void)
{
	/*Our HCLK is 405/4=101.25Mhz, 
	 *CLE setup time = 0ns, CLE Hold time >= 10ns,
	 *ALE setup time = 0ns, ALE Hold time >= 10ns,
	 *WE Pulse Width >= 25ns,
	 *so TACLS=1, TWRPH0=3, TWRPH1=1	
	*/	
	nand->NFCONF = (0x01 << 12) | (0x03 << 8) | (0x01 << 4);
	/*Enable nand flash controller, initialise ECC, and deselect chip*/
	nand->NFCONT = (0x01 << 4 ) | (0x01 << 1) | (0x01 << 0);
	
	nand_reset();
}

/*
 *nand_read_data() is only used by reading data-field.
 *The cmd of reading oob-field is 50h.
 */
void nand_read_data(unsigned char *buf, unsigned long start_addr, int size)
{
	unsigned long i;
	int j;
	
	nand = get_nand_base();

	nand_select_chip();
	
	i = start_addr;
	while (i < (start_addr + size)){
		if (i & (0x01 << 8))
				nand_cmd(0x01);
		else
				nand_cmd(0x00);
		nand_write_addr_reg(i);
		nand_wait_cmd_complete();

		for(j = 0; (j < (NAND_SECTOR_SIZE - (i & NAND_SECTOR_MASK))) && (i < (start_addr + size)); j++, i++){
			*buf = nand_read_data_reg();
			buf++;
		}
	}

	nand_deselect_chip();
	
	return;
}
