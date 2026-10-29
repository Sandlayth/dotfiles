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

# There may be several MPRIS players (e.g. two browsers); `playerctl` with no
# -p reports the *first* one, which is often Stopped. Pick the one that is
# actually Playing (else the first Paused one).
pick_player() {
    playerctl -l 2>/dev/null | while IFS= read -r p; do
        [ "$(playerctl -p "$p" status 2>/dev/null)" = "$1" ] && { printf '%s\n' "$p"; break; }
    done
}
player=$(pick_player Playing); [ -z "$player" ] && player=$(pick_player Paused)

if command -v playerctl >/dev/null 2>&1 && [ -n "$player" ]; then
    title=$(playerctl -p "$player" metadata --format '{{artist}} — {{title}}' 2>/dev/null \
            | sed 's/^ *— *//' | rtl | fold -s -w "$W" | head -3)
else
    title='nothing playing'
fi
# Always exactly 3 lines (pad with blanks) so the section height never changes.
printf '%s\n' "$title" | awk 'NR<=3 {print} END {for (i=NR+1; i<=3; i++) print ""}'

# Output sink on a single line (fixed footprint).
out=$(sink_desc)
[ -n "$out" ] && printf '%s %s\n' "$spk" "$out" | rtl | fold -s -w "$W" | head -1
