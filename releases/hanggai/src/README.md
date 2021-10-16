
How to build gray486 linux
==========================

Tested build environment:
Fedora 34


**10.** Prepare in `gray486/bin`
--------------------------------

`lrwxrwxrwx. 1 rhack rhack 16 Oct  3 14:46 musl-ar -> /usr/bin/i386-ar`

`lrwxrwxrwx. 1 rhack rhack 14 Oct  3 14:52 musl-strip -> /usr/bin/strip`

`/usr/bin/i386-ar` is just link to `/usr/bin/ar` :/

**11.** Get num of cpus
-----------------------

`export GR_CPUS=$(nproc --all)`

**20.** Install kernel headers
------------------------------

In kernel directory:

`make menuconfig`

`make headers_install ARCH=i386 INSTALL_HDR_PATH=../gray486`

**30.** Compile musl
--------------------

`LDEMULATION="elf_i386" CC="gcc" CFLAGS="-m32 -march=i386 -mtune=i486 -fcf-protection=none  -fno-stack-protector  -Wa,-mtune=generic32 -fomit-frame-pointer -fno-pic -mno-mmx -mno-sse" ./configure --target=i386 --prefix=../gray486/`

`LDEMULATION="elf_i386" CC="gcc" CFLAGS="-m32 -march=i386 -mtune=i486 -fcf-protection=none  -fno-stack-protector  -Wa,-mtune=generic32 -fomit-frame-pointer -fno-pic -mno-mmx -mno-sse" make -j"$GR_CPUS"`

`LDEMULATION="elf_i386" CC="gcc" CFLAGS="-m32 -march=i386 -mtune=i486 -fcf-protection=none  -fno-stack-protector  -Wa,-mtune=generic32 -fomit-frame-pointer -fno-pic -mno-mmx -mno-sse" make install`

**40.** Compile busybox
-----------------------

`LDEMULATION="elf_i386" CFLAGS="-m32 -march=i386 -mtune=i486" make -j"$GR_CPUS"`

`LDEMULATION="elf_i386" CFLAGS="-m32 -march=i386 -mtune=i486" make install`

**50.** Compile kernel
----------------------

`make -j"$GR_CPUS"`

**60.** (optional - you need qemu installed) Test build
-------------------------------------------------------

Test build with `test-build.sh` script inside kernel directory.

**70.** Cleanup build
---------------------

`git clean -f -d -X`
