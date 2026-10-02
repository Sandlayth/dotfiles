#!/bin/sh
# Real bandwidth usage via vnstat (persistent). Shows today + this month totals.
# Until the daemon has recorded a sample, --oneline returns a plain sentence
# (no ';'), so we detect that and show a short placeholder instead of overflowing.
IFACE="${1:-wlp0s20f3}"
line=$(vnstat -i "$IFACE" --oneline 2>/dev/null)
case "$line" in
    *';'*)
        tday=$(printf '%s' "$line" | cut -d';' -f6)
        tmon=$(printf '%s' "$line" | cut -d';' -f11)
        printf 'today  %s\n' "$tday"
        printf 'month  %s\n' "$tmon"
        ;;
    *)
        printf 'collecting…\n'
        ;;
esac
