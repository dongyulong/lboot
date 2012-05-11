
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

all: $(SUBDIRS) $(OUTOBJS)
	$(LD) -r -o $(OBJDIR)/built-in.o  $(OUTOBJS) $(OUTSUBLIBS)
endif

.PHONY: $(SUBDIRS)
$(SUBDIRS):
	@$(MAKE) -C $@ all	

#	$(shell [ -d $(OBJDIR)/$@ ] || mkdir -p $@)
#########################################################################
	
CPPFLAGS := -I$(TOPDIR)/include -nostdinc -fno-builtin -ffreestanding -pipe

CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -fno-stack-protector \
	-march=armv4 -mabi=apcs-gnu -mno-thumb-interwork -Os

CURDIR := $(subst $(TOPDIR)/,,$(shell pwd))

$(OBJDIR)/%.o:	%.S
	@mkdir -p $(OBJDIR)
	$(CC) $(CFLAGS) -c -o $@ $<
	@echo " CC $(CURDIR)/$< -o $@"

$(OBJDIR)/%.o:	%.s
	@mkdir -p $(OBJDIR)
	$(CC) $(CFLAGS) -c -o $@ $<
	@echo " CC  $(CURDIR)/$< -o $@"

$(OBJDIR)/%.o:	%.c
	@mkdir -p $(OBJDIR)
	$(CC) $(CFLAGS) -c -o $@ $<
	@echo " CC  $(CURDIR)/$< -o $@"

#########################################################################

.PHONY: clean
clean:
	@rm -fr *.o
