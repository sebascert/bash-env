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

luarVersion="3.11.1"

if [ "$#" -eq 1 ]; then
   luarVersion=$1
fi

luarDir="luarocks-${luarVersion}"
luarTar="${luarDir}.tar.gz"

curl -L -R -O "https://luarocks.org/releases/$luarTar"
tar zxpf $luarTar
cd $luarDir
./configure && make && sudo make install

cd ..
rm -rf $luarDir
rm $luarTar

