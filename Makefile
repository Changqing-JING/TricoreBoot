ASM_FLAGS += -g -c -Wall -nostdlib -nostdinc
CFLAGS += -g -Wall
QEMU_FLAGS = -nographic -M tricore_tsim161

OUTPATH=build

asm_demo.o: asm_demo.S
	$(TRICORE_GCC_PATH)/tricore-elf-gcc $(ASM_FLAGS) -o $(OUTPATH)/$@ $<

asm_demo.elf: asm_demo.o
	$(TRICORE_GCC_PATH)/tricore-elf-ld -T linker.ld -o $(OUTPATH)/$@ $(OUTPATH)/$<

debug_asm_demo: asm_demo.elf
	$(TRICORE_QEMU_PATH)/qemu-system-tricore $(QEMU_FLAGS) -S -s -kernel $(OUTPATH)/$<


c_demo.elf: c_demo.c
	$(TRICORE_GCC_PATH)/tricore-elf-gcc $(CFLAGS) -o $(OUTPATH)/$@ $<

debug_c_demo: c_demo.elf
	$(TRICORE_QEMU_PATH)/qemu-system-tricore $(QEMU_FLAGS) -S -s -kernel $(OUTPATH)/$<


