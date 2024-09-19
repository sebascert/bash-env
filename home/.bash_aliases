alias cls='clear'
alias gerp='grep'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias mv='mv -i'

alias apt-update='sudo apt update && sudo apt upgrade'

# alias dotfiles='la | grep -E "^\." | column'
alias dotfiles='ls -d .??*'

alias rm-cores='rm core.* vgcore.*'

alias http-server='python3 -m http.server -b 127.0.0.1'

alias py='python3'

alias cp-clip='xclip -selection clipboard'
alias pt-clip='xclip -selection clipboard -o'

alias vim-bashrc='vim $(locate .bashrc | head -n1)'
alias vim-alias='vim $(locate .bash_aliases | head -n1)'

# source scripts
alias pyvenv-activate='source pyvenv-activate.sh'
alias pyvenv-deactivate='source pyvenv-deactivate.sh'

