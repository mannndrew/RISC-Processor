# Makefile for RISC-V Compilation

# Compiler and Flags
PROGRAM_NAME = firmware
TOOLCHAIN = /opt/riscv32i/bin/riscv32-unknown-elf-
CFLAGS = -march=rv32im -Os -ffreestanding -nostdlib --std=gnu99
LDFLAGS = -Wl,-Bstatic,-T,$(PROGRAM_NAME).lds,-Map,firmware.map,--strip-debug -lgcc

# Source files
SRCS = $(PROGRAM_NAME).S $(PROGRAM_NAME).c

# ELF file
ELF = $(PROGRAM_NAME).elf

# BIN file
BIN = $(PROGRAM_NAME).bin

# MIF file
MIF = $(PROGRAM_NAME).mif

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
	rm -f $(ELF) $(BIN)
