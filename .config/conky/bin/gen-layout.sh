#!/bin/sh
# Distribute the panels to fill the screen height: first panel flush to the top
# (just under polybar), last panel flush to the bottom, equal gaps between.
# Reads the real screen height and each panel's rendered height, then writes
# each panel's gap_y offset. Re-run whenever panels are added/removed/resized.
DIR="$HOME/.config/conky/conky-panels"
LIST="$HOME/.config/conky/panels.list"
TOP=46            # just below polybar; matches ref_pos_y in common.lua
BOTTOM_MARGIN=6
SCREEN_H=$(xdotool getdisplaygeometry | awk '{print $2}')
AVAIL=$(( SCREEN_H - TOP - BOTTOM_MARGIN ))

panels=$(grep -vE '^[[:space:]]*#|^[[:space:]]*$' "$LIST")
n=$(printf '%s\n' "$panels" | wc -l)

# Measure heights (one panel at a time).
pkill -x conky 2>/dev/null; sleep 0.4
heights=""; total_h=0
for p in $panels; do
    ( cd "$DIR" && CONKY_SIDE=left conky -c "./$p-panel.lua" >/dev/null 2>&1 & )
    sleep 1.3
    wid=$(xdotool search --class conky 2>/dev/null | head -1)
    h=$(xdotool getwindowgeometry "$wid" 2>/dev/null | awk '/Geometry/{split($2,a,"x"); print a[2]}')
    h=${h:-100}
    heights="$heights $h"; total_h=$(( total_h + h ))
    pkill -x conky 2>/dev/null; sleep 0.3
done

# Equal gaps that make the stack span exactly TOP..(SCREEN_H-BOTTOM_MARGIN).
gap=0; rem=0
if [ "$n" -gt 1 ]; then
    gap=$(( (AVAIL - total_h) / (n - 1) ))
    rem=$(( (AVAIL - total_h) - gap * (n - 1) ))   # leftover px from integer division
    [ "$gap" -lt 0 ] && { gap=0; rem=0; }
fi

# Write offsets; spread the remainder 1px at a time across the first gaps so the
# last panel lands exactly at the bottom.
off=0; i=0
set -- $heights
for p in $panels; do
    h=$1; shift
    sed -i -E "s/gap_y=ref_pos_y(\+[0-9]+)?/gap_y=ref_pos_y+$off/" "$DIR/$p-panel.lua"
    printf '  %-11s h=%-4s -> +%s\n' "$p" "$h" "$off"
    g=$gap; [ "$i" -lt "$rem" ] && g=$(( gap + 1 ))
    off=$(( off + h + g ))
    i=$(( i + 1 ))
done
printf 'panels=%s total_h=%s avail=%s gap=%s (+%s px spread)\n' "$n" "$total_h" "$AVAIL" "$gap" "$rem"
