#!/bin/sh
nasm ipower.s -felf64
gcc -static ipower.o -o ipower