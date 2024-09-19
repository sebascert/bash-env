# ENVIROMENT

# enable bash completion in interactive shells
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Start ssh client if not running
if [ -z "$SSH_AGENT_PID" ]; then
    eval "$(ssh-agent -s)" > /dev/null
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Load ssh keys
SSH_KEYS="$HOME/.ssh/keys"
mkdir -p "$SSH_KEYS"

for key in "$SSH_KEYS"/*; do
    ssh_add_stderr=$(ssh-add "$key" 2>&1 > /dev/null)
    if [ $? -ne 0 ]; then
        echo "$ssh_add_stderr"
    fi
done

# load user functions
user_funcs_dir="$HOME/functions"
mkdir -p "$user_funcs_dir"

for func in "$user_funcs_dir"/*; do
    if [ -f "$func" ]; then
        . "$func"
    fi
done

# load app setups
usr_app_setup="$HOME/app-setup"
mkdir -p "$usr_app_setup"

for setup in "$usr_app_setup"/*; do
    if [ -f "$setup" ]; then
        . "$setup"
    fi
done

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

