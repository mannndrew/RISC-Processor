# Makefile for RISC-V Compilation

# Compiler and Flags
PROGRAM_NAME = firmware
TOOLCHAIN = riscv64-unknown-elf-
CFLAGS = -march=rv32i -mabi=ilp32 -ffreestanding -Os -nostdlib --std=gnu99
LDFLAGS = -Wl,-Bstatic,-T,$(PROGRAM_NAME).lds,-Map,firmware.map,--strip-debug -lgcc

# Source files
SRCS = $(PROGRAM_NAME).S $(PROGRAM_NAME).c

# ELF file
ELF = $(PROGRAM_NAME).elf

# BIN file
BIN = $(PROGRAM_NAME).bin

# MIF file
MIF = $(PROGRAM_NAME).mif

# MAP file
MAP = $(PROGRAM_NAME).map

# Build
all: $(ELF) $(BIN) $(MIF)

$(ELF): $(SRCS)
	$(TOOLCHAIN)gcc $(CFLAGS) -o $(ELF) $(SRCS) $(LDFLAGS)

$(BIN): $(ELF)
	$(TOOLCHAIN)objcopy -O binary $(ELF) $(BIN)
	
$(MIF): $(BIN)
	python3 makehex.py $(BIN)

# Clean
clean:
	rm -f $(ELF) $(BIN) $(MAP)
