#!/usr/bin/env bash

# Automatically detect the correct DISPLAY and XAUTHORITY
for sock in /tmp/.X11-unix/X*; do
    [ -S "$sock" ] || continue
    owner=$(stat -c '%U' "$sock")
    [ "$owner" = "$USER" ] || continue

    display_num=$(basename "$sock" | cut -c2-)
    export DISPLAY=":$display_num"
    export XAUTHORITY="/home/$USER/.Xauthority"
    break
done

if [ -z "$DISPLAY" ] || [ ! -f "$XAUTHORITY" ]; then
    echo "Could not detect valid DISPLAY or XAUTHORITY for user $USER"
    exit 1
fi

feh --bg-fill "$(find -L /home/$USER/.config/wallpaper/images | shuf | head -n 1)"
