#!/bin/sh
# Mirror the panel dashboard on BOTH columns. Panel order from panels.list.
# (Spacing is precomputed by bin/gen-layout.sh — run that after changing panels.)
LIST="$HOME/.config/conky/panels.list"
panels=$(grep -vE '^[[:space:]]*#|^[[:space:]]*$' "$LIST")
pkill -x conky 2>/dev/null; sleep 0.4
for side in left right; do
    for p in $panels; do
        ( cd "$HOME/.config/conky/conky-panels" && CONKY_SIDE="$side" conky -c "./$p-panel.lua" ) >/dev/null 2>&1 &
    done
done
# i3 ignores override windows, so lowering them once keeps them in the background.
sleep 2
for wid in $(xdotool search --class conky 2>/dev/null); do xdotool windowlower "$wid"; done
