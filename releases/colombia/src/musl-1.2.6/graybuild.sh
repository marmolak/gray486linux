#!/usr/bin/env bash

set -e

CFLAGS="$CFLAGS -I$(realpath "${PWD}/../gray486/include")"
./configure --target=i386 --prefix=$(realpath "${PWD}/../gray486/")
make -j"$GR_CPUS"
make install
