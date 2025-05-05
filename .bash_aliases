# ~/.bash_aliases
#

alias date="date +%d-%m-%Y"
alias diff='colordiff'
alias df="df -h"
alias du="du -xhcd 1"
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias firefox="librewolf"
alias gitroot='cd $(git rev-parse --show-toplevel)'
alias grep='grep --color=auto'
alias k='kubectl'
alias leafpad='l3afpad'
alias ll="ls --color=always --group-directories-first -Xhlp"
alias la="ll -d .*"
alias scrot='scrot --quality 100 -o -s ~/capture.png'
alias screenshot="\scrot --quality 100 -o -s ~/capture.png && cat ~/capture.png | xclip -t image/png -selection clipboard"
alias screentext="\scrot --quality 100 -o -s /tmp/ocr.png && tesseract /tmp/ocr.png /tmp/ocr && xclip -selection clipboard /tmp/ocr.txt"
alias vi="vim"
alias wget="wget -c"
alias wechat="curl -sL https://raw.githubusercontent.com/huan/docker-wechat/master/dochat.sh | bash"
alias youtube-audio="yt-dlp -ix --audio-quality 0 --audio-format mp3"


