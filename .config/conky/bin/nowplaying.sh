#!/usr/bin/env bash
# Now-playing (MPRIS) + current audio output sink, wrapped to the panel width.
# conky has no BiDi/shaping, so RTL text (e.g. Arabic) is pre-ordered and
# shaped with fribidi when available (otherwise passed through unchanged).
W=36
spk=$(printf '\U000f04c3')   # Nerd Font speaker glyph

rtl() { if command -v fribidi >/dev/null 2>&1; then fribidi --nobreak --nopad; else cat; fi; }

sink_desc() {
    s=$(pactl get-default-sink 2>/dev/null) || return
    pactl list sinks 2>/dev/null | awk -v s="$s" '
        $1=="Name:"{cur=($2==s)}
        cur&&$1=="Description:"{$1="";sub(/^ /,"");print;exit}'
}

status=$(playerctl status 2>/dev/null)
if command -v playerctl >/dev/null 2>&1 && { [ "$status" = Playing ] || [ "$status" = Paused ]; }; then
    playerctl metadata --format '{{artist}} — {{title}}' 2>/dev/null \
        | sed 's/^ *— *//' | rtl | fold -s -w "$W"
else
    echo 'nothing playing'
fi

out=$(sink_desc)
[ -n "$out" ] && printf '%s %s\n' "$spk" "$out" | rtl | fold -s -w "$W"
