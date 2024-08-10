#!/bin/bash

# Dependencies: python3, virtualenv

venv="pyvenv"
requirements="requirements.txt"

if [ ! -d "$venv" ]; then
    virtualenv "$venv" > /dev/null
fi

. "$(pwd)/$venv/bin/activate"

if [ ! -f "$requirements" ]; then
    pip freeze > "$requirements"
fi

pip install -r "$requirements" > /dev/null

echo "virtual enviroment activated"
