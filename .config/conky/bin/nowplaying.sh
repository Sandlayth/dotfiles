#!/bin/sh
# Now-playing via playerctl (MPRIS). Graceful when playerctl is absent or idle.
command -v playerctl >/dev/null 2>&1 || { printf '(install playerctl)\n'; exit 0; }
case "$(playerctl status 2>/dev/null)" in
    Playing|Paused) playerctl metadata --format '{{artist}}\n{{title}}' 2>/dev/null ;;
    *) printf 'nothing playing\n' ;;
esac
