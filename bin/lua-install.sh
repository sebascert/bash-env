#!/bin/bash

# Dependencies: curl, tar, make

set -e

trap 'echo "Failed on: $BASH_COMMAND"; exit $?' ERR

usage() {
    echo "Usage: $0 [lua-version]"
}

if [ "$#" -gt 1 ]; then
    usage
    exit 1
fi

luaVersion="5.4.7"

if [ "$#" -eq 1 ]; then
   luaVersion=$1
fi

luaDir="lua-${luaVersion}"
luaTar="${luaDir}.tar.gz"
curl -L -R -O "https://www.lua.org/ftp/$luaTar"
tar zxf $luaTar
cd $luaDir
make all test

cd src
sudo cp lua /usr/bin
sudo cp luac /usr/bin
sudo cp lua "/usr/bin/lua$luaVersion"
sudo cp lua.h /usr/include

cd ../..
rm -rf $luaDir
rm $luaTar

