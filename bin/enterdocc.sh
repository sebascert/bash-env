#!/usr/bin/env bash

set -e

nwin() {
    tmux new-window -n "$new_docc"
    tmux split-window -h
    tmux resize-pane -R 16
    tmux send-keys -t "$new_docc".0 "$1" C-m
}

if [ $# -ne 1 ]; then
    echo "missing doc name"
    exit 1
fi

new_docc="$1"

docc_dir="$HOME/docc"
mkdir -p "$docc_dir"

if [ -d "$docc_dir/$new_docc" ]; then
    cd "$docc_dir/$new_docc"
    nwin "git status"
    exit 0
fi

cd "$docc_dir"

git clone git@github.com:sebascert/docc.git "$new_docc"

cd "$new_docc" || {
    echo "git clone failed"
    exit 2
}

nwin "nvim src/body.md"
