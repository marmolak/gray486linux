#!/usr/bin/env bash

set -e

CC="$(realpath $PWD/../gray486/bin/musl-gcc)"

autoconf
autoheader

./configure --enable-static --enable-bundled-libtom --disable-syslog --disable-harden --disable-zlib --disable-shadow --disable-utmp --disable-utmpx --disable-wtmpx --disable-loginfunc --prefix="$(realpath $PWD/../gray486/_install/)"

echo "#define DROPBEAR_SVR_PASSWORD_AUTH 0" > localoptions.h

make -j"$GR_CPUS"

strip dbclient

mv dbclient ../gray486/_install/bin
