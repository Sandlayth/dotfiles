#!/usr/bin/env bash
# Now-playing (MPRIS) + current audio output sink, wrapped to the panel width
# so long titles continue on the next line instead of being clipped.
W=36
spk=$(printf '\U000f04c3')   # Nerd Font speaker glyph

sink_desc() {
    s=$(pactl get-default-sink 2>/dev/null) || return
    pactl list sinks 2>/dev/null | awk -v s="$s" '
        $1=="Name:"{cur=($2==s)}
        cur&&$1=="Description:"{$1="";sub(/^ /,"");print;exit}'
}

status=$(playerctl status 2>/dev/null)
if command -v playerctl >/dev/null 2>&1 && { [ "$status" = Playing ] || [ "$status" = Paused ]; }; then
    playerctl metadata --format '{{artist}} — {{title}}' 2>/dev/null \
        | sed 's/^ *— *//' | fold -s -w "$W"
else
    echo 'nothing playing'
fi

out=$(sink_desc)
[ -n "$out" ] && printf '%s %s\n' "$spk" "$out" | fold -s -w "$W"
