#!/bin/bash

qemu-system-i386 -cpu 486 -m 24 --kernel arch/x86/boot/bzImage -nographic -append "consol=tty0" -serial mon:stdio
