
OBJS 	:= $(notdir $(obj-y))
SUBDIRS := $(subst ./,,$(dir $(obj-y)))
#SUBLIBS	:= $(addsuffix built-in.o,$(SUBDIRS))
OBJDIR  := $(OUTDIR)/$(patsubst $(TOPDIR)/%,%,$(shell pwd))
OUTOBJS += $(if $(OBJS), $(addprefix $(OBJDIR)/, $(OBJS)),)
#########################################################################

.PHONY: all
ifeq ($(obj-y),)

all:
	OBJDIR  := $(OUTDIR)/$(patsubst $(TOPDIR)/%,%,$(shell pwd))
	@cd $(OBJDIR)
	@rm -f built-in.o
	@$(AR) rcs built-in.o
	@cd -
else

all: $(SUBDIRS) $(OBJS)
	@echo $(SUBDIRS) ######### $(OBJS) ###### $(OUTOBJS)
	$(LD) -r -o $(OBJDIR)/built-in.o $(OBJDIR)/$(OBJS) $(OBJDIR)/$(SUBLIBS)

endif

.PHONY: $(SUBDIRS)
$(SUBDIRS):
	@$(MAKE) -C $@ all	

#########################################################################
	
CPPFLAGS := -I$(TOPDIR)/include -nostdinc -fno-builtin -ffreestanding -pipe

CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -fno-stack-protector \
	-march=armv4 -mabi=apcs-gnu -mno-thumb-interwork -Os

CURDIR := $(subst $(TOPDIR),,$(shell pwd))

%.o:	%.S
	@mkdir -p $(strip $(OBJDIR))
	@$(CC) $(CFLAGS) -c -o $(OBJDIR)/$@ $<
	@echo " CC		.$(CURDIR)/$@ -o $(OBJDIR)/$@"

%.o:	%.s
	@mkdir -p $(strip $(OBJDIR))
	@$(CC) $(CFLAGS) -c -o $(OBJDIR)/$@ $<
	@echo " CC		.$(CURDIR)/$@ -o $(OBJDIR)/$@"

%.o:	%.c
	@mkdir -p $(strip $(OBJDIR))
	@$(CC) $(CFLAGS) -c -o $(OBJDIR)/$@ $<
	@echo " CC		.$(CURDIR)/$@ -o $(OBJDIR)/$@"

#########################################################################

.PHONY: clean
clean:
	@rm -fr $(OUTDIR)
