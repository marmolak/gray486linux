
How to build gray486 linux
==========================

Tested build environment:
Fedora 35 with Nix installed.

**10.** [Install Nix](https://nixos.org/manual/nix/stable/installation/installing-binary.html#multi-user-installation)
----------------------------------------------------------------------------------------

**20.** Get num of cpus
-----------------------

Nix-shell scripts take handle of it.

If you don't want to use `nix-shell`, just type:

`export GR_CPUS=$(nproc --all)`

**30.** Enter Nix build environment
-----------------------------------

1. Change directory to `src/build-env-with-nix`.

2. Run `nix-shell`. Ideally in screen/tmux if you are connected remotely. This will take some time. gcc needs to be rebuild with CET disabled.

**40.** Install kernel headers
------------------------------

In kernel directory:

`make headers_install ARCH=i386 INSTALL_HDR_PATH=../gray486`

**50.** Compile musl
--------------------

`CFLAGS="$CFLAGS -I$(realpath "${PWD}/../gray486/include")" ./configure --target=i386 --prefix=$(realpath "${PWD}/../gray486/")`

`make -j"$GR_CPUS"`

`make install`


**60.** Compile busybox
-----------------------

(optional) `make menuconfig`

`make -j"$GR_CPUS"`

`make install`

**51.** (optional) Build dropbear SSH client (+~266 K)
------------------------------------------------------

`CC="$(realpath $PWD/../gray486/bin/musl-gcc)"  ./configure --enable-static --enable-bundled-libtom --disable-syslog  --disable-harden --disable-zlib --disable-shadow --disable-utmp --disable-utmpx --disable-wtmpx --disable-loginfunc --prefix="$(realpath $PWD/../gray486/_install/)"`

`make -j"$GR_CPUS"`

`strip dbclient`

`cp dbclient ../gray486/_install/bin`


**70.** Update `.config` in kernel directory
--------------------------------------------

There is mapping hidden in `.config` and you need to change it
to UID of user under you compile a kernel.

`CONFIG_INITRAMFS_ROOT_UID=1001`

`CONFIG_INITRAMFS_ROOT_GID=1001`

Then you can do some other changes with:

`make menuconfig`

**80.** Compile kernel
----------------------

`make -j"$GR_CPUS"`

**90.** Leave nix-shell
-----------------------

`exit`


**100.** (optional - you need qemu installed) Test your build
------------------------------------------------------------

Test build with `test-build.sh` script inside kernel directory.

**110.** Cleanup build
---------------------

`git clean -f -d -X`

`git reset --hard master`
