#
#	Lboot Makefile
#


ARCH	?= arm
CROSS_COMPILE	?= arm-linux-
CC = $(CROSS_COMPILE)gcc
AS = $(CROSS_COMPILE)as
LD = $(CROSS_COMPILE)ld

FINAL_BIN = lboot.bin
LBOOT_LDS = lboot.lds

SOURCE = start.S

OUT_BIN = start.o

all: $(FINAL_BIN)
	@echo  "Outputing $(FINAL_BIN) ..."

$(FINAL_BIN): $(OUT_BIN)
	@$(LD)	$^ -o $@ -T$(LBOOT_LDS)

$(OUT_BIN):
	@$(CC)  -o $@ -c $(SOURCE)


.PHONY: clean
clean:
	@rm -f *.out $(FINAL_BIN) $(OUT_BIN)
	
