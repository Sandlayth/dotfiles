# ~/.bash_aliases
#

alias date="date +%d-%m-%Y"
alias diff='colordiff'
alias df="df -h"
alias du="du -xhcd 1"
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias gitroot='cd $(git rev-parse --show-toplevel)'
alias grep='grep --color=auto'
alias ll="ls --color=always --group-directories-first -Xhlp"
alias la="ll -d .*"
alias scrot='scrot --quality 100 -o -s ~/capture.png'
alias screenshot="\scrot --quality 100 -o -s ~/capture.png && cat capture.png | xclip -t image/png -selection clipboard"
alias vi="vim"
alias wget="wget -c"
alias youtube-audio="youtube-dl -ix --audio-quality 0 --audio-format mp3"


