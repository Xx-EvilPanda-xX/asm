#!/bin/sh
nasm tri.s -felf64
ld tri.o -o triangle