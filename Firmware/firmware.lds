MEMORY
{
    ram (rwx) : ORIGIN = 0x00000000, LENGTH = 64K
}

SECTIONS
{
	.init : { *(.init) } > ram
    .text : { *(.text .text.startup) } > ram
    .data : { *(.data .bss) } > ram
    .riscv.attributes : { *(.riscv.attributes) } > ram
    .comment : { *(.comment) } > ram
    end = .;
}