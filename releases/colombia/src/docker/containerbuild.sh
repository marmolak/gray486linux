#/usr/bin/env bash

podman build -t gray486linux:latest -v $PWD/..:/build ./
