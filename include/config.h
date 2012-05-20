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
#define CFG_STACKSIZE_IRQ    (4*1024)    /* IRQ stack */
#define CFG_STACKSIZE_FIQ    (4*1024)    /* FIQ stack */
#define LBOOT_BASE				0x33f80000	/* lboot start address */
#define TEXT_BASE				0x33d80000  /* */
#define LINUX_KERNEL			0x30008000	/* linux kernel start address */
#define RAMDISK					0x30800000	/* file system start address */

/* Lboot shell */
#define CFG_HOST_NAME "S3C2440A"
#define CFG_USER "lboot"
#define CFG_SHELL_BUFFER_SIZE 4096

/* Uart config*/
#define CFG_UART_NR 0 /* The serial port you are using, there 3 
					   * serial ports in s3c2440, but only two 
					   * ports are avaliable, port 0 and port 1.
					   */



#endif /* __LBOOT_CONFIG_ */
