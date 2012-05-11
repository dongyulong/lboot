
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
STARTDIR	:= $(TOPDIR)/cpu

OUT_BIN	:= $(TOPDIR)/lboot.bin
OUT_ELF	:= $(TOPDIR)/lboot.elf

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
	@$(shell cd $(OUTDIR) && $(LD) $(SUBLIBS) -o $@ -T$(LDSCRIPT))

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
	@$(shell for i in $(SUBDIRS);do $(MAKE) -C $$i clean;done)
	@$(MAKE) -C $(STARTDIR) clean_start
	@rm -f $(OUT_ELF) $(OUT_BIN)
	@echo " Remove"
