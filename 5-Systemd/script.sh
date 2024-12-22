#!/bin/bash
set -euo pipefail

if [ ! -d "~/papka" ]; then
	mkdir ~/papka
fi
cd ~/papka

date >> 1

cat /proc/version >> 2

hostname >> 3

ls -a ~ >> 4
