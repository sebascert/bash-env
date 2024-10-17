#!/bin/bash

# Dependencies: python3, virtualenv

if ! deactivate 2> /dev/null; then
    echo "no python virtual environment"
    return
fi

echo "virtual environment deactivated"
