[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
systemctl --user import-environment DISPLAY
systemctl --user start polybar-monitor.service
exec i3
