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
vInName=false

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
            vInName=true
        ;;
        *)
            usage
    	    exit 1
        ;;
    esac
    shift
done

destBuild="$(pwd)/$gamename"
if [ $vInName = true ]; then
	destBuild+="_${version}_love_$LOVE_VERSION"
fi
destBuild+=".love"

if [ -f "$destBuild" ]; then
    rm "$destBuild"
fi

echo "$gamename \n version: $version \n Love version: $LOVE_VERSION" > $GAMEDATA

# zip files
{ git ls-files; echo $GAMEDATA; } | zip $destBuild -@ > /dev/null

rm $GAMEDATA
