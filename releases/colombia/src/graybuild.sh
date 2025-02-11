#!/usr/bin/env bash

set -e

. ./lib/userspace.sh
. ./lib/kernel.sh

# Install kernel headers
pushd ./build-env-with-nix/
	nix-shell --pure --command "pushd ./${KERNEL_VERSION} && make headers_install ARCH=i386 INSTALL_HDR_PATH=../gray486; popd"
popd

for U in ${USERSPACE[*]}; do
    pushd ./build-env-with-nix/
        nix-shell --pure --command "pushd ./${U}/ && ./graybuild.sh; popd"
    popd
done

# Build Linux kernel
pushd ./build-env-with-nix/
	nix-shell --pure --command "pushd ./${KERNEL_VERSION}/ && ./graybuild.sh; popd"
popd

rm -rf ./results
mkdir ./results
pushd "${KERNEL_VERSION}"
	cp ./arch/i386/boot/bzImage ../results/
popd
