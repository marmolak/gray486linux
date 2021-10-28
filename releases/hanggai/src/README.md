
How to build gray486 linux
==========================

Tested build environment:
Fedora 34 (optionally with Nix)


**10.** Prepare in `gray486/bin`
--------------------------------

`lrwxrwxrwx. 1 rhack rhack 16 Oct  3 14:46 musl-ar -> /usr/bin/i386-ar`

`lrwxrwxrwx. 1 rhack rhack 14 Oct  3 14:52 musl-strip -> /usr/bin/strip`

`/usr/bin/i386-ar` is just link to `/usr/bin/ar` :/

**OR**

**11.** Prepare in `gray486/bin` (Nix way)
------------------------------------------

1. [Install Nix](https://nixos.org/manual/nix/stable/#sect-multi-user-installation)

2. Change directory to `src/build-env-with-nix`.

3. Run `nix-shell --pure` ideally in screen/tmux if you are remotely connected. This will take some time. gcc needs to be rebuild with CET disabled.

**19.** Get num of cpus
-----------------------

`export GR_CPUS=$(nproc --all)`

**20.** Install kernel headers
------------------------------

In kernel directory:

`make headers_install ARCH=i386 INSTALL_HDR_PATH=../gray486`

**30.** Compile musl
--------------------

`LDEMULATION="elf_i386" CC="gcc" CFLAGS="-m32 -march=i386 -mtune=i486 -fcf-protection=none -fno-stack-protector -Wa,-mtune=generic32 -fomit-frame-pointer -fno-pic -mno-mmx -mno-sse" ./configure --target=i386 --prefix=../gray486/`

`LDEMULATION="elf_i386" CC="gcc" CFLAGS="-m32 -march=i386 -mtune=i486 -fcf-protection=none -fno-stack-protector -Wa,-mtune=generic32 -fomit-frame-pointer -fno-pic -mno-mmx -mno-sse" make -j"$GR_CPUS"`

`LDEMULATION="elf_i386" CC="gcc" CFLAGS="-m32 -march=i386 -mtune=i486 -fcf-protection=none -fno-stack-protector -Wa,-mtune=generic32 -fomit-frame-pointer -fno-pic -mno-mmx -mno-sse" make install`

**40.** Compile busybox
-----------------------

`LDEMULATION="elf_i386" CFLAGS="-m32 -march=i386 -mtune=i486" make -j"$GR_CPUS"`

`LDEMULATION="elf_i386" CFLAGS="-m32 -march=i386 -mtune=i486" make install`

**41.** Update `.config` in kernel directory
--------------------------------------------

There is mapping hidden in `.config` and you need to change it
to UID of user under you compile a kernel.

`CONFIG_INITRAMFS_ROOT_UID=1001`

`CONFIG_INITRAMFS_ROOT_GID=1001`

Then you can do some other changes with:

`make menuconfig`

**50.** Compile kernel
----------------------

`make -j"$GR_CPUS"`

**60.** (optional - you need qemu installed) Test your build
------------------------------------------------------------

Test build with `test-build.sh` script inside kernel directory.

**70.** Cleanup build
---------------------

`git clean -f -d -X`
