#!/usr/bin/env bash
# Active wifi: a strength glyph (by signal %), the signal %, and the SSID.
line=$(nmcli -t -f IN-USE,SIGNAL,SSID,RATE dev wifi 2>/dev/null | grep '^\*' | head -1)
if [ -z "$line" ]; then
    printf '%s offline\n' "$(printf '\U000f092f')"
    exit 0
fi
sig=$(printf  '%s' "$line" | cut -d: -f2)
ssid=$(printf '%s' "$line" | cut -d: -f3)

if   [ "$sig" -ge 75 ]; then g=$(printf '\U000f0928')   # strength 4
elif [ "$sig" -ge 50 ]; then g=$(printf '\U000f0925')   # strength 3
elif [ "$sig" -ge 25 ]; then g=$(printf '\U000f0922')   # strength 2
elif [ "$sig" -ge 1  ]; then g=$(printf '\U000f091f')   # strength 1
else                        g=$(printf '\U000f092f'); fi # none

printf '%s  %s%%  %s\n' "$g" "$sig" "$ssid"
