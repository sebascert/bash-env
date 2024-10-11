#!/bin/bash

# Dependencies: python3, virtualenv

status=""
venv="pyvenv"
requirements="requirements.txt"

current_dir="$(pwd)"

while [[ "$current_dir" != "/" && ! -d "$current_dir/$venv" ]]; do
    current_dir="$(dirname "$current_dir")"
done

if [[ -d "$current_dir/$venv" ]]; then
    status="reactivating $current_dir/$venv"
else
    virtualenv "$venv" > /dev/null
    current_dir="$(pwd)"
    status="$venv created"
fi

. "$current_dir/$venv/bin/activate"

# py_version=$("$venv/bin/python" --version | sed -n -E 's/.* ([0-9]+\.[0-9]+).*/\1/p')
# PYTHON_VENV_PATH="$current_dir/$venv/lib/python$py_version/site-packages"
# export PYTHONPATH="$PYTHON_VENV_PATH"

echo $status
