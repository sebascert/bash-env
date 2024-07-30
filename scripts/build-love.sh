#!/bin/bash

# Dependencies: git, love

GAMEDATA="game.dat"

gamename=""
version=""
vInName=false

usage() {
    echo "Usage: $0 [-gamename value] [-v | --version value] [-vInName]"
    exit 1
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
        ;;
        -vInName)
            vInName=true
        ;;
        *)
            usage
        ;;
    esac
    shift
done

destBuild="$(pwd)/$gamename"
if [ $vInName ]; then
    destBuild+=$version
fi
destBuild+=".love"

if [ -f "$destBuild" ]; then
    rm "$destBuild"
fi

echo "$gamename\n$version\n$(love --version)" > $GAMEDATA

# zip files
{ git ls-files; echo $GAMEDATA } | zip $destBuild -@

rm $GAMEDATA
