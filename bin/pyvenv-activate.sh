#!/bin/bash

# Dependencies: python3, virtualenv

status=""
# if no venv is found then default to first one
venv_dir=("pyvenv" ".venv" "venv")

current_dir="$(pwd)"
venv_path=""

while [[ "$current_dir" != "/" ]]; do
    for dir in "${venv_dir[@]}"; do
        if [[ -d "$current_dir/$dir" ]]; then
            venv_path="$current_dir/$dir"
            break
        fi
    done

    if [[ "$venv_path" != "" ]]; then
        break
    fi

    current_dir="$(dirname "$current_dir")"
done

if [[ "$venv_path" != "" ]]; then
    status="reactivating $venv_path"
else
    current_dir="$(pwd)"
    venv_path="$current_dir/${venv_dir[0]}"
    virtualenv "$venv_path" > /dev/null
    status="$venv_path created"
fi

source "$venv_path/bin/activate"

# py_version=$("$venv/bin/python" --version | sed -n -E 's/.* ([0-9]+\.[0-9]+).*/\1/p')
# PYTHON_VENV_PATH="$current_dir/$venv/lib/python$py_version/site-packages"
# export PYTHONPATH="$PYTHON_VENV_PATH"

echo "$status"
