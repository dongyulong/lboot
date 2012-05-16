#ifndef __LBOOT_CONFIG_
#define __LBOOT_CONFIG_

#define S3C2440_UPLOOKING

/* Memory initialize
 *
 * There 64M sdram, witch starting at 0x30000000,
 * ending at 0x34000000;
 *
 * Kernel's start address is 0x30008000;
 *
 * Ramdisk's start address is 0x308000000;
 *
 * Bootloader's start address is 0x33f80000;
 */



#define CFG_ENV_SIZE			0xc000  /* Total Size of Environment Sector */
#define CFG_MALLOC_LEN			(CFG_ENV_SIZE + 128*1024) 
#define CFG_GBL_DATA_SIZE		128 /* size in bytes reserved for initial data */
#define CONFIG_STACKSIZE_IRQ    (4*1024)    /* IRQ stack */
#define CONFIG_STACKSIZE_FIQ    (4*1024)    /* FIQ stack */

#define LBOOT_BASE				0x33f80000	/* lboot start address */
#define TEXT_BASE				0x33d80000  /* */
#define LINUX_KERNEL			0x30008000	/* linux kernel start address */
#define RAMDISK					0x30800000	/* file system start address */

/*
*print buffer definition
*/
#define CFG_PB_SIZE 256

#endif /* __LBOOT_CONFIG_ */
