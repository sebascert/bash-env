#!/bin/bash

# Dependencies: python3, virtualenv

deactivate 2> /dev/null
if [ $? -ne 0 ]; then
    echo "no python virtual enviroment"
    return
fi

echo "virtual enviroment deactivated"
