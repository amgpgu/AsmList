#!/bin/bash
nasm -f elf32 -l list.lst list.asm
#ld -m elf_i386 -o list list.o
gcc -m32 -o list list.o
chmod +x list
