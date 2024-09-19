#!/bin/bash

# Dependencies: rsync

function homeInstall() {
    rsync -avh -r --no-perms home/ ~
    source $HOME/bashrc
}

function binInstall() {
    sudo rsync -avh -r --no-perms bin/ /usr/local/bin
}

function mappedInstall() {
    mappings="mapped-files.txt"
    map_dir="mapped"
    separator='='

    declare -A mapped_files

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

        mkdir -p "$(dirname "$dest")"
        cp "$map_dir/$file" "$dest"
        mapped_files["$file"]=1
    done < "$mappings"

    if [ check_unmapped = false ]; then
        return 0
    fi

    find "$map_dir" -type f | while read -r file; do
        file="${file#"$map_dir/"}"
        if [ -z ${mapped_files["$file"]} ]; then
            echo "unmapped $file"
        fi
    done
}

usage() {
    echo "Usage: $0 [-h|--home] [-b|--bin] [-m|--mapped] [-f|--force] [--ignore-unmapped]"
}

home=false
bin=false
mapped=false

force=false
check_unmapped=true

# parse command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--home)
            home=true
        ;;
        -b|--bin)
            bin=true
        ;;
        -m|--mapped)
            mapped=true
        ;;
        -f|--force)
            force=true
        ;;
        --ignore-unmapped)
            check_unmapped=false
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

if [[ $home = false && $bin = false && $mapped = false ]]; then
    echo "nothing to do"
    exit 0
fi

if [ $force = false ]; then
    echo "This may overwrite existing files in your system"
    echo "For viewing which files will be overriden use diff-env"
    read -p "Are you sure? (y/n) " -n 1
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

cd "$(dirname "${BASH_SOURCE}")"

if [ $home = true ]; then
    homeInstall
    echo "Installed home env"
fi

if [ $bin = true ]; then
    binInstall
    echo "Installed binaries"
fi

if [ $mapped = true ]; then
    mappedInstall
    echo "Installed mapped env"
fi
