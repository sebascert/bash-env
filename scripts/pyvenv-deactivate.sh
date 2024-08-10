#!/bin/bash

# Dependencies: python3, virtualenv

venv="pyvenv"
requirements="requirements.txt"

if [ ! -d $venv ]; then
    echo "no virtual enviroment"
    exit 1
fi

pip freeze > $requirements
deactivate

echo "virtual enviroment deactivated"
