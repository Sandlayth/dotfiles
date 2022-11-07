# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

if [[ -t 0 && $(tty) =~ /dev/tty ]] &&
    command -v startx &&
    ! pgrep -u $USER startx &> /dev/null
then
    echo "Aucune session X11 détectée. Voulez-vous en lancer une ? [O|n]"
    read -n 1 start_x
    if [[ $start_x == "n" ]];then
        echo "X11 ne sera pas lancé."
    else
        startx
    fi
fi
