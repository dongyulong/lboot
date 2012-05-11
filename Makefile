
MAKE 	= make -s
TOPDIR 	= $(shell pwd)
#OUTDIR  = $(TOPDIR)
OUTDIR  = $(strip $(TOPDIR)/out)

ifdef O
ifeq ("$(origin O)", "command line")
OUTDIR := $(O)
saved-outdir := $(OUTDIR)
$(shell [ -d $(OUTDIR) ] || mkdir -p $(OUTDIR))
OUTDIR := $(shell cd $(OUTDIR) && pwd)
$(if $(OUTDIR),,$(error output directory "$(saved-outdir)" does not exist))
endif
endif

OUTOBJS =
#TOPDIR = $(CURDIR)

export	MAKE TOPDIR OUTDIR OUTOBJS

CROSS_COMPILE 	?= arm-linux-

AS	= $(CROSS_COMPILE)as
LD	= $(CROSS_COMPILE)ld
CC	= $(CROSS_COMPILE)gcc
CPP	= $(CC) -E
AR	= $(CROSS_COMPILE)ar
NM	= $(CROSS_COMPILE)nm
LDR	= $(CROSS_COMPILE)ldr
STRIP	= $(CROSS_COMPILE)strip
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP = $(CROSS_COMPILE)objdump

export AS LD CC CPP AR NM LDR STRIP OBJCOPY OBJDUMP

#########################################################################

LDSCRIPT	:= $(TOPDIR)/lboot.lds

LBOOT_BIN	:= $(OUTDIR)/lboot.bin
LBOOT_ELF	:= $(OUTDIR)/lboot.elf

SRC := cpu/
SRC += drivers/

SRCLIBS	:= $(addsuffix built-in.o,$(addprefix $(OUTDIR)/,$(SRC)))

.PHONY: $(LBOOT_BIN) $(LBOOT_ELF) $(SRC)

#########################################################################

all:	$(LBOOT_BIN)
	@echo "Outputing lboot.bin..."
	@echo "Building Successfully."

$(LBOOT_BIN): $(LBOOT_ELF)
	@$(OBJCOPY) -O binary $< $@

$(LBOOT_ELF): $(SRC)
	@$(shell cd $(OUTDIR) && $(LD) $(SRCLIBS) -o $@ -T$(LDSCRIPT))

$(SRC):
	@$(MAKE) -C $@ all

########################################################################
menuconfig:
	./tool/mconf Kconfig

########################################################################

.PHONY: clean
clean:
#	@$(shell for i in $(SUBDIRS);do $(MAKE) -C $$i clean;done)
#	@$(MAKE) -C $(STARTDIR) clean_start
#	@rm -f $(LBOOT_ELF) $(LBOOT_BIN)
	@rm -rf out/
	@echo "Cleaning..."
