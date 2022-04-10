#!/bin/sh
nasm fib.s -felf64
gcc -static fib.o -o fib