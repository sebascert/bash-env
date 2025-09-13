#!/usr/bin/env bash

set -e

if [ $# -ne 1 ]; then
    echo "missing doc name"
    exit 1
fi

new_docc="$1"

docc_dir="$HOME/docc"

if [ -d "$docc_dir/$new_docc" ]; then
    echo "existing doc"
    exit 1
fi

mkdir -p "$docc_dir"
cd "$docc_dir"

git clone git@github.com:sebascert/docc.git "$new_docc"

cd "$new_docc" || {
    echo "git clone failed"
    exit 2
}

on_new_win="nvim src/body.md"
tmux new-window -n "$new_docc" "$on_new_win" \; split-window -h \; resize-pane -R 16 || {
    echo "new tmux window failed"
    exit 3
}
