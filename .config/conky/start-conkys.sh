#!/bin/sh
# One translucent dashboard (conky-panels/dashboard.lua), mirrored on both
# columns -- a single conky window per side, so there are no seams between
# sections. CONKY_SIDE picks the column (and the per-side WM_CLASS used by
# aspect-gap to show/hide the correct one).
pkill -x conky 2>/dev/null; sleep 0.4
for side in left right; do
    ( cd "$HOME/.config/conky/conky-panels" && CONKY_SIDE="$side" conky -c ./dashboard.lua ) >/dev/null 2>&1 &
done

# i3 ignores override windows, so lowering them once keeps them in the background.
sleep 2
for wid in $(xdotool search --class conky 2>/dev/null); do xdotool windowlower "$wid"; done

# Only the dashboard in the empty column should show: re-apply the current aspect
# layout (default 'left') so a manual restart doesn't leave both sides visible.
state="${XDG_RUNTIME_DIR:-/tmp}/i3-aspect-gap"
"$HOME/.config/i3/aspect-gap" "$(cat "$state" 2>/dev/null || echo left)" >/dev/null 2>&1
