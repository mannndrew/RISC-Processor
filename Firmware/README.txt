riscv32-unknown-elf-gcc -mno-relax -march=rv32im -Os -ffreestanding -nostdlib -o firmware.elf firmware.S firmware.c -static -Wl,-T,firmware.lds,-Map,firmware.map,--strip-debug -lgcc && riscv32-unknown-elf-objcopy -O binary firmware.elf firmware.bin && python3 ../../firmware/makehex.py firmware.bin 4096 > firmware.hex
riscv32-unknown-elf-gcc -march=rv32im -Os -ffreestanding -nostdlib -o <ProgramName.elf> <ProgramName.S> <ProgramName.c> --std=gnu99 -Wl,-Bstatic,-T,<LinkerName.lds>,-Map,firmware.map,--strip-debug -lgcc && riscv32-unknown-elf-objcopy -O binary firmware.elf firmware.bin && python3 ../../firmware/makehex.py firmware.bin 4096 > firmware.hex

-  riscv32-unknown-elf-gcc:      Toolchain Compiler

-  mno-relax              :      Disable Optimization for Instruction Encoding

-  march=rv32im           :      Specify Architecture is RV32I

-  Os                     :      Optimize for Size

-  ffreestanding          :      Optimize for Freestanding Enviroment

-  nostdlib               :      Don't include Standard Libraries

-  o                      :      Provide output File Name

-- std=gnu99              :      Use GNU C Language Standard

-  Wl                     :      Specify Linker Options
       -  Bstatic                :      Static Linking
       -  T                      :      Provide Linker File
       -  Map                    :      Generate Memory Map
       -- strip-debug            :      Remove Debug Information

- lgcc                    :      Link the GCC Runtime Library

