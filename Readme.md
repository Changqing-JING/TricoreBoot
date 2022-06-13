## Install tricore toolchain on Ubuntu
For ubuntu 22.04 users, a GCC-9 is recommended to use for better compatibility when build gdb and qemu
```shell
sudo apt install gcc-9 g++-9
```

### Install tricore gcc
```shell
sudo apt install 7zip
git clone https://github.com/volumit/tricore_gcc940_linux_bins.git
cd tricore_gcc940_linux_bins
7z x tricore_940_linux.zip.001
chmod -R 777 tricore_940_linux
echo "export TRICORE_GCC_PATH=$(pwd)/tricore_940_linux/bin" >> ~/.profile
```

### Install tricore qemu
```shell
git clone https://github.com/volumit/qemu.git
cd qemu
git submodule update --init --progress
mkdir build
cd build
CC=gcc-9 CFLAGS=-Wno-error ../configure
make -j $(nproc)
echo "export TRICORE_QEMU_PATH=$(pwd)/build" >> ~/.profile
```

### Install gdb
```shell
git clone https://github.com/volumit/gdb-tricore.git
cd gdb-tricore
CC=gcc-9 ./configure --target=tricore-unknown-elf x86_64-pc-linux-gnu --host=x86_64-pc-linux-gnu
make -j $(nproc)
echo "export TRICORE_GDB_PATH=$(pwd)/gdb" >> ~/.profile
```

### refresh environment varialbes
reboot
or
```shell
. ~/.profile
```

## Run first tricore program on qemu
### Run ASM code
#### Build a ASM program which can be run by qemu
```shell
make asm_demo.elf
```
#### Run ASM demo in qemu with remote gdb server
```shell
make debug_asm_demo
```
#### Debug in vscode
1. config the launch.json according to example_launch.json
2. launch and debug in vscode

#### Run C demo
```shell
make c_demo.elf
```
#### Run C demo in qemu with remote gdb server
```shell
make debug_c_demo
```


