#!/bin/bash

dd if=imggen of=header iseek=2300 ibs=1 obs=4096 count=4096
