# ENVIRONMENT

set -o vi

# enable bash completion in interactive shells
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        source /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        source /etc/bash_completion
    fi
fi

# HISTORY

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# UI

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# C AND CPP

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Enable core dump
ulimit -c unlimited
echo "./core.%e.%p" | sudo tee /proc/sys/kernel/core_pattern > /dev/null

. "$HOME/.local/bin/env"

# Start ssh client if not running
if [ -z "$SSH_AGENT_PID" ]; then
    eval "$(ssh-agent -s)" > /dev/null
fi

# Alias definitions.
if [ -f "$HOME/.bash_aliases" ]; then
    source "$HOME/.bash_aliases"
fi

if [ -f "$HOME/.bash_exports" ]; then
    source "$HOME/.bash_exports"
fi

# Load ssh keys
SSH_KEYS="$HOME/.ssh/keys"
mkdir -p "$SSH_KEYS"

# Check if directory contains any files before looping
if [ -n "$(ls -A "$SSH_KEYS" 2>/dev/null)" ]; then
    for key in "$SSH_KEYS"/*; do
        if [ -f "$key" ]; then
            ssh_add_stderr=$(ssh-add "$key" 2>&1)
            if [ $? -ne 0 ]; then
                echo "$ssh_add_stderr"
            fi
        fi
    done
fi

# load user functions
user_funcs_dir="$HOME/functions"
mkdir -p "$user_funcs_dir"

for func in "$user_funcs_dir"/*; do
    if [ -f "$func" ]; then
        source "$func"
    fi
done

# load source on start
source_on_start="$HOME/source-on-start"
mkdir -p "$source_on_start"

for sfile in "$source_on_start"/*; do
    if [ -f "$sfile" ]; then
        source "$sfile"
    fi
done
