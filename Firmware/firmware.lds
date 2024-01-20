MEMORY
{
    instructions (rx) : ORIGIN = 0x00000000, LENGTH = 8K
	data (rwx) : ORIGIN = 0x00000400, LENGTH = 8K
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