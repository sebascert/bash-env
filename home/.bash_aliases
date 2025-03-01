# remap

alias cls='clear'
alias gerp='grep'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias mv='mv -i'

alias vim='nvim'

alias bt='bluetoothctl'

alias py='python3'

alias cprofile='py -m cProfile'
alias line_profiler='py -m line_profiler'
alias memory_profiler='py -m memory_profiler'

alias blender-disown='blender & disown'

# utilities

alias source-bash='source ~/.bashrc'

alias apt-update='sudo apt update && sudo apt upgrade -y'

alias dotfiles='ls -d .??*'
# alias dotfiles='la | grep -E "^\." | column'

alias gh-ssh='gh repo view --json sshUrl -q .sshUrl'

alias rm-cores='rm core.* vgcore.*'

alias http-server='python3 -m http.server -b 127.0.0.1'

alias tree-gitignore="tree -a -I '.git' --gitignore --dirsfirst"
alias tree-ignore="tree -a -I '.git|pyvenv|node_modules|__pycache__' --dirsfirst"

alias cp-clip='xclip -selection clipboard'
alias pt-clip='xclip -selection clipboard -o'

alias vol-get='amixer get Master | tail -n2'
alias vol-set='amixer set Master'

alias music-st='spotifycli --status'
alias music-pl='spotifycli --play'
alias music-ps='spotifycli --pause'
alias music-nx='spotifycli --next'
alias music-pr='spotifycli --prev'

# my utilities

alias pyvenv-activate='source pyvenv-activate.sh'
alias pyvenv-deactivate='source pyvenv-deactivate.sh'

alias ow='open-window'
