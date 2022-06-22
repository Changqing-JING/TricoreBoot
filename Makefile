ASM_FLAGS += -g -c -Wall -nostdlib -nostdinc
CFLAGS += -g -Wall -mcpu=tc39xx
LINK_FLAGS += -Wl,-T link_c.ld
QEMU_FLAGS = -display none -M tricore_tsim162 -semihosting

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

OUTPATH=build

asm_demo.o: asm_demo.S
	$(TRICORE_GCC_PATH)/tricore-elf-gcc $(ASM_FLAGS) -o $(OUTPATH)/$@ $<

asm_demo.elf: asm_demo.o
	$(TRICORE_GCC_PATH)/tricore-elf-ld -T linker_asm.ld -o $(OUTPATH)/$@ $(OUTPATH)/$<

asm_dump: asm_demo.elf
	$(TRICORE_GCC_PATH)/tricore-elf-objdump -D $(OUTPATH)/$<

debug_asm_demo: asm_demo.elf
	$(TRICORE_QEMU_PATH)/qemu-system-tricore $(QEMU_FLAGS) -S -s -kernel $(OUTPATH)/$<


c_demo.o: c_demo.c
	$(TRICORE_GCC_PATH)/tricore-elf-gcc -c $(CFLAGS) -T link_c.ld -o $(OUTPATH)/$@ $<

c_demo.elf: c_demo.o
	$(TRICORE_GCC_PATH)/tricore-elf-gcc -mcpu=tc39xx ${LINK_FLAGS} -o $(OUTPATH)/$@ $(OUTPATH)/$<

debug_c_demo: c_demo.elf
	$(TRICORE_QEMU_PATH)/qemu-system-tricore $(QEMU_FLAGS) -S -s -kernel $(OUTPATH)/$<

run_c_demo: c_demo.elf
	$(TRICORE_QEMU_PATH)/qemu-system-tricore $(QEMU_FLAGS) -kernel $(OUTPATH)/$<

show_c_demo_section: c_demo.elf
	$(TRICORE_GCC_PATH)/tricore-elf-readelf --sections ./build/$<


cpp_demo.elf: cpp_demo.cpp
	$(TRICORE_GCC_PATH)/tricore-elf-g++ -std=gnu++17 $(CFLAGS) ${LINK_FLAGS} -o $(OUTPATH)/$@ $(ROOT_DIR)/$<

run_cpp_demo: cpp_demo.elf
	$(TRICORE_QEMU_PATH)/qemu-system-tricore $(QEMU_FLAGS) -kernel $(OUTPATH)/$<

debug_cpp_demo: cpp_demo.elf
	$(TRICORE_QEMU_PATH)/qemu-system-tricore $(QEMU_FLAGS) -S -s -kernel $(OUTPATH)/$<

show_cpp_demo_section:
	$(TRICORE_GCC_PATH)/tricore-elf-readelf --sections ./build/cpp_demo

test_read_file.elf: test_read_file.c
	$(TRICORE_GCC_PATH)/tricore-elf-gcc -g -Wall -o $(OUTPATH)/$@ $(ROOT_DIR)/$<

run_test_read_file: test_read_file.elf
	$(TRICORE_QEMU_PATH)/qemu-system-tricore -display none -M tricore_tsim161 -semihosting -kernel $(OUTPATH)/$<

debug_test_read_file: test_read_file.elf
	$(TRICORE_QEMU_PATH)/qemu-system-tricore -display none -M tricore_tsim161 -semihosting -S -s -kernel $(OUTPATH)/$<


