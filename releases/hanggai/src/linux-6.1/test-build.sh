#!/bin/bash

#DEBUG="-s -S"
MEM="14m"

qemu-system-i386 -M microvm $DEBUG -cpu 486 -m "${MEM}" --kernel arch/x86/boot/bzImage -nographic -append "console=ttyS0" -serial mon:stdio
