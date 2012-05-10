
OBJS 	:= $(notdir $(obj-y))
SUBDIRS := $(subst ./,,$(dir $(obj-y)))
SUBLIBS	:= $(addsuffix built-in.o,$(SUBDIRS))
OBJDIR  := $(OUTDIR)/$(patsubst $(TOPDIR)/%,%,$(shell pwd))
OUTOBJS := $(if $(OBJS), $(addprefix $(OBJDIR)/,$(OBJS)),$(OBJS))
OUTSUBLIBS := $(if $(SUBLIBS), $(addprefix $(OBJDIR)/,$(SUBLIBS)),$(SUBLIBS))
#########################################################################

.PHONY: all
ifeq ($(obj-y),)

all:
	@rm -f built-in.o
	@$(AR) rcs built-in.o

else

all: $(SUBDIRS) $(OBJS)
	$(LD) -r -o $(OBJDIR)/built-in.o  $(OUTOBJS) $(OUTSUBLIBS)
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
	@echo " CC	.$(CURDIR)/$@ -o $(OBJDIR)/$@"

%.o:	%.s
	@mkdir -p $(strip $(OBJDIR))
	@$(CC) $(CFLAGS) -c -o $(OBJDIR)/$@ $<
	@echo " CC	.$(CURDIR)/$@ -o $(OBJDIR)/$@"

%.o:	%.c
	@mkdir -p $(strip $(OBJDIR))
	@$(CC) $(CFLAGS) -c -o $(OBJDIR)/$@ $<
	@echo " CC	.$(CURDIR)/$@ -o $(OBJDIR)/$@"

#########################################################################

.PHONY: clean
clean:
	@rm -fr *.o
