OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)
SECTIONS
{
	. = 0x33f80000;

	. = ALIGN(4);
	.text :
	{
		cpu/start.o	(.text)
		*(.text)
	}

	. = ALIGN(4);
	.rodata :
	{
		*(.rodata)
	}

	. = ALIGN(4);
	.data :
	{
		*(.data)
	}
}
