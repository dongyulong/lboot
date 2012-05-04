#
#	Lboot Makefile
#


ARCH	?= arm
CROSS_COMPILE	?= arm-linux-
CC = $(CROSS_COMPILE)gcc
AS = $(CROSS_COMPILE)as
LD = $(CROSS_COMPILE)ld
OBJCOPY = $(CROSS_COMPILE)objcopy

LBOOT_BIN = lboot.bin
LBOOT_ELF = lboot.elf
LBOOT_LDS = lboot.lds

SOURCE = start.S led.S
HEADER = reg.h

OBJS = start.o led.o

all: $(LBOOT_BIN)
	$(shell cp $^ oflash)
	@echo  "Outputing $(LBOOT_BIN) ..."
	@echo  "Please use ./tool/script/oflash.sh to flash image"

$(LBOOT_BIN): $(LBOOT_ELF)
	@$(OBJCOPY) -I elf32-littlearm -O binary $^ $@

$(LBOOT_ELF): $(OBJS)
	@$(LD)	$^ -o $@ -T$(LBOOT_LDS)

$(OBJS):
	@$(CC) -c $(SOURCE) $(HEADER)


.PHONY: clean
clean:
	@rm -f *.out $(LBOOT_BIN) $(LBOOT_ELF) $(OBJS) oflash/lboot.bin
	
