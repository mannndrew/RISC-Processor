MEMORY
{
    instructions (rx) : ORIGIN = 0x00000000, LENGTH = 1K
	data (rwx) : ORIGIN = 0x00000100, LENGTH = 1K
}

SECTIONS
{
	.init : { *(.init) } > instructions
    .text : { *(.text .text.startup) } > instructions
    .data : { *(.data .bss) } > data
    .riscv.attributes : { *(.riscv.attributes) } > instructions
    .comment : { *(.comment) } > instructions
    end = .;
}