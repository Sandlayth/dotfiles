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

previous_state=""

while true; do
    current_state=$(xrandr --query | grep " connected" | grep "+")  # Make sure there's a space before "connected"

    if [[ "$current_state" != "$previous_state" ]]; then
        sleep 1
        echo "[$USER] Monitor change detected on $DISPLAY. Restarting Polybar..."
        "$HOME/.config/polybar/launch.sh"
        previous_state="$current_state"
    fi

    sleep 2
done
