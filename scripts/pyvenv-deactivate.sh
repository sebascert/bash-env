#!/bin/bash

# Dependencies: python3, virtualenv

# requirements="requirements.txt"

deactivate 2> /dev/null
if [ $? -ne 0 ]; then
    echo "no python virtual enviroment"
    return
fi

# pip freeze > $requirements

echo "virtual enviroment deactivated"
