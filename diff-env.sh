#!/bin/bash

# dependencies: rsync

function evalDiffExitCode() {
    if [ "$1" -eq 1 ]; then
        echo "differ: $file"
    elif [ "$1" -eq 2 ]; then
        echo "missing: $file"
    fi
}

function diffEnv() {
    origin=$(eval "echo $1")
    dest=$(eval "echo ${environments["$1"]}")

    find "$origin"/ -type f | while read -r file; do
        file="${file#"$origin/"}"
        diff "$origin/$file" "$dest/$file" > /dev/null 2>&1

        evalDiffExitCode $? | xargs -I {} echo "ENV '$origin' {}"
    done
}

usage() {
    echo "Usage: $0 [--all ^env1 ^env2 ...|env1 env2 ...]"
    echo
    echo "when the --all flag is provided, envs passed are ignored"
    echo -e "\nOptions:\n"
    echo -e "-h, --help \t display usage and exit"
    echo -e "-a, --all \t install all environments"
}

all=false

unset selected_envs
declare -A selected_envs

# parse command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -a|--all)
            all=true
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            if [[ -v selected_envs["$1"] ]]; then
                usage
                echo "repeated environments"
                return 1
            fi

            # ensure all paths don't have / for rsync to work
            env="${1%/}"

            selected_envs["$env"]=1
            ;;
    esac
    shift
done

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

declare -A environments
source "./get-environments.sh"

if [ $? -eq 1 ]; then
    return 1
fi

if [ $all = true ]; then
    for env in "${!environments[@]}"; do
        if [[ -v selected_envs["$env"] ]]; then
            unset 'selected_envs["$env"]'
        else
            selected_envs["$env"]=1
        fi
    done
fi

for env in "${!selected_envs[@]}"; do
    diffEnv "$env"
    if [ $? -eq 1 ]; then
        return 1
    fi
done

exit 0
