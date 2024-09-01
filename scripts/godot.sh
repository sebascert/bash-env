#! /bin/bash

godot4.3 --editor > /dev/null 2>&1 & disown
echo "Started godot as separate process"

