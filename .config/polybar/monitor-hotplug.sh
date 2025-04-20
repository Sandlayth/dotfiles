#!/usr/bin/env bash

export DISPLAY=:0
export XAUTHORITY=/home/sandlayth/.Xauthority

previous_state=""

while true; do
    current_state=$(xrandr --query | grep "connected" | grep "+")

    if [[ "$current_state" != "$previous_state" ]]; then
        sleep 2  # Adjust polling interval if needed
        echo "Monitor change detected. Restarting Polybar..."
        /home/sandlayth/.config/polybar/launch.sh
        previous_state="$current_state"
    fi

    sleep 2  # Adjust polling interval if needed
done

