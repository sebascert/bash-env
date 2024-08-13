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
    status="$venv created"
fi

. "$current_dir/$venv/bin/activate"

# if [ ! -f "$requirements" ]; then
#     pip freeze > "$requirements"
# fi

# pip install -r "$requirements" > /dev/null

echo $status
