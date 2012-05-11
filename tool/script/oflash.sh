#!/bin/bash

if [ "T"$1 = "T" ]; then
	sudo ./tool/oflash/oflash 1 2 0 0 0 out/lboot.bin
else
	sudo ./tool/oflash/oflash 1 2 0 0 0 $1/lboot.bin
fi


