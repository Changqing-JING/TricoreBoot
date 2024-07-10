# Build Tricore gcc from source on Ubuntu 22

1. clone package 940

```shell
git clone https://github.com/Schleifner/package_940.git
git switch fix/build_ubuntu22
```

2. Adapt the path in stall
   replace path_to_package_940 with the path to package_940
   replace install_dir with the path you want to install

3. Build binutils and gcc step by step

```shell
./do_all
```

Doc:
https://wiki.osdev.org/GCC_Cross-Compiler
