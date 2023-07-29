#!/usr/bin/env bash

podman run --rm -ti -v "${PWD}/..":/build localhost/gray486linux:latest
