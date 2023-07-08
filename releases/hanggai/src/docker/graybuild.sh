#/usr/bin/env bash

podman build --no-cache -t gray486linux:latest -v $PWD/..:/build ./
