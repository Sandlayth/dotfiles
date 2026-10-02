#!/bin/sh
# Battery: charge % + status, health (full/design) + power draw, and an estimate
# of time remaining (to empty when discharging, to full when charging).
b=/sys/class/power_supply/BAT0
cap=$(cat "$b/capacity" 2>/dev/null)
st=$(cat "$b/status" 2>/dev/null)
ef=$(cat "$b/energy_full" 2>/dev/null)
efd=$(cat "$b/energy_full_design" 2>/dev/null)
en=$(cat "$b/energy_now" 2>/dev/null)
pw=$(cat "$b/power_now" 2>/dev/null)

health=""
[ -n "$ef" ] && [ -n "$efd" ] && [ "$efd" -gt 0 ] && health=$(( ef * 100 / efd ))
watts=""
[ -n "$pw" ] && watts=$(awk "BEGIN{printf \"%.1f\", $pw/1000000}")

est="—"
if [ -n "$pw" ] && [ "$pw" -gt 0 ] && [ -n "$en" ] && [ -n "$ef" ]; then
    case "$st" in
        Discharging) hrs=$(awk "BEGIN{print $en/$pw}");            tag="left" ;;
        Charging)    hrs=$(awk "BEGIN{print ($ef-$en)/$pw}");      tag="to full" ;;
        *)           hrs="" ;;
    esac
    if [ -n "$hrs" ]; then
        h=$(awk "BEGIN{printf \"%d\", $hrs}")
        m=$(awk "BEGIN{printf \"%d\", ($hrs-int($hrs))*60}")
        est="~${h}h ${m}m ${tag}"
    fi
fi

printf '%s%%   %s\n' "$cap" "$st"
printf 'health %s%%    %s W\n' "$health" "$watts"
printf '%s\n' "$est"
