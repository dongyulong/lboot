
MAKE 	= make -s
TOPDIR 	= $(shell pwd)
OUTDIR  = $(strip $(TOPDIR)/out)
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
STARTDIR	:= $(TOPDIR)/cpu

OUT_BIN	:= lboot.bin
OUT_ELF	:= lboot.elf

SUBDIRS := drivers/

SUBLIBS	:= $(addsuffix built-in.o,$(OUTDIR)/$(SUBDIRS))

.PHONY: $(OUT_BIN) $(OUT_ELF) $(SUBDIRS) $(SUBLIBS) $(STARTDIR)

#########################################################################

all:	$(OUT_BIN)
	@echo "Outputing lboot.bin..."
	@echo "Building Successfully."

$(OUT_BIN): $(OUT_ELF)
	@$(OBJCOPY) -O binary $< $@

$(OUT_ELF): $(STARTDIR) $(SUBDIRS)
	@$(LD) $(SUBLIBS) -o $@ -T$(LDSCRIPT)

$(STARTDIR):
	@$(MAKE) -C $@ start

$(SUBDIRS):
	@$(MAKE) -C $@ all

########################################################################
menuconfig:
	./tool/mconf Kconfig

########################################################################

.PHONY: clean
clean:
	@for i in $(SUBDIRS);do $(MAKE) -C $$i clean;done
	@$(MAKE) -C $(STARTDIR) clean_start
	@rm -f $(OUT_ELF) $(OUT_BIN)
	@echo " Remove"

