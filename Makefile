#
#	Lboot Makefile
#


ARCH	?= arm
CROSS_COMPILE	?= arm-linux-

CC = $(CROSS_COMPILE)gcc
AS = $(CROSS_COMPILE)as
LD = $(CROSS_COMPILE)ld

all:
	@$(CC)	start.S -o start


.PHONY: clean
clean:
	@rm *.out
	
