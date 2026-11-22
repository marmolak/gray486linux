#!/usr/bin/env bash

set -x

export GR_CPUS=$(nproc --all)

make -j"${GR_CPUS}"
