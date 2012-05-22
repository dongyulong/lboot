
#ifndef __NAND_H
#define __NAND_H

#define NAND_SECTOR_SIZE (512)
#define NAND_PAGE_MASK ((512 + 16) -1)

void nand_init(void);
void nand_read_data(unsigned char *buf, unsigned long start_addr, int size);

#endif /*__NAND_H*/
