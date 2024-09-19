#!/bin/bash

# dependencies: diff

function evalDiffEcode() {
    case $? in
        1)
            echo "differ: $file"
        ;;
        2)
            echo "missing: $file"
        ;;
        *) ;;
    esac
}

function unmappedDiff() {
    origin=$1
    dest=$2
    find "$origin" -type f | while read -r file; do
        file="${file#"$origin/"}"
        diff "$origin/$file" "$dest/$file" > /dev/null 2>&1
        evalDiffEcode
    done
}

function mappedDiff() {
    mappings="mapped-files.txt"
    map_dir="mapped"
    separator='='

    while IFS="" read -r line || [ -n "$line" ]; do
        if [ -z "$line" ]; then
            continue
        fi

        file="${line%%$separator*}"
        eval dest="${line#*$separator}"

        if [ ! -f "$map_dir/$file" ]; then
            echo "attempting to map unexistant file: $file" >&2
            return 1
        fi

        diff "$map_dir/$file" "$dest" > /dev/null 2>&1
        evalDiffEcode
    done < "$mappings"
}

function usage() {
    echo "Usage: $0 [-h|--home] [-b|--bin] [-m|--mapped]"
    echo "--home, --bin and --mapped are exclusive"
}

home=0
bin=0
mapped=0

# parse command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--home)
            home=1
        ;;
        -b|--bin)
            bin=1
        ;;
        -m|--mapped)
            mapped=1
        ;;
        --help)
            usage
            exit 0
        ;;
        *)
            usage
            exit 1
        ;;
    esac
    shift
done

# check if none or more than one where selected
count=$((home + bin + mapped))
if [ $count -ne 1 ]; then
    echo "nothing to do"
    exit 0
fi

cd $(dirname ${BASH_SOURCE})

if [ $home -eq 1 ]; then
    unmappedDiff home $HOME
fi

if [ $bin -eq 1 ]; then
    unmappedDiff bin /usr/local/bin
fi

if [ $mapped -eq 1 ]; then
    mappedDiff
fi
