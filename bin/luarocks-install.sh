#!/bin/bash

# Dependencies: curl, tar, make

set -e

trap 'echo "Failed on: $BASH_COMMAND"; exit $?' ERR

usage() {
    echo "Usage: $0 [luarocks-version]"
}

if [ "$#" -gt 1 ]; then
    usage
    exit 1
fi

luar_version="3.11.1"

if [ "$#" -eq 1 ]; then
    luar_version=$1
fi

luar_dir="luarocks-${luar_version}"
luar_tar="${luar_dir}.tar.gz"

curl -L -R -O "https://luarocks.org/releases/$luar_tar"
tar zxpf "$luar_tar"
cd "$luar_dir"
./configure && make && sudo make install

cd ..
rm -rf "$luar_dir"
rm "$luar_tar"
