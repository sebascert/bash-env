#!/bin/bash

# Dependencies: git, love

GAMEDATA="game.dat"

if [ -f $GAMEDATA ]; then
    echo "$GAMEDATA is in use, remove it"
    exit 1
fi

LOVE_VERSION=$(love --version | sed 's/[^0-9.]//g')

gamename="build"
version="1.0"
version_in_name=false

usage() {
    echo "Usage: $0 [-gamename value] [-v | --version value] [-vInName]"
}

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -gamename)
            gamename=$2
            shift
            ;;
        -v|--version)
            version=$2
            shift
            ;;
        -vInName)
            version_in_name=true
            ;;
        *)
            usage
            exit 1
            ;;
    esac
    shift
done

dest_build="$(pwd)/$gamename"
if [ $version_in_name = true ]; then
    dest_build+="_${version}_love_$LOVE_VERSION"
fi
dest_build+=".love"

if [ -f "$dest_build" ]; then
    rm "$dest_build"
fi

echo -e "$gamename \n version: $version \n Love version: $LOVE_VERSION" > $GAMEDATA

# zip files
{ git ls-files; echo $GAMEDATA; } | zip  "$dest_build" -@ > /dev/null

rm $GAMEDATA
