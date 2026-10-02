#!/bin/sh
# Tailscale VPN detail + public IPv4 (cached 10 min).
if tailscale status >/dev/null 2>&1; then
    j=$(tailscale status --json 2>/dev/null)
    self=$(printf  '%s' "$j" | jq -r '.Self.TailscaleIPs[0] // "?"')
    tnet=$(printf  '%s' "$j" | jq -r '.CurrentTailnet.Name // "?"')
    online=$(printf '%s' "$j" | jq -r '[.Peer[]?|select(.Online)]|length')
    total=$(printf '%s' "$j" | jq -r '.Peer|length')
    exitn=$(printf '%s' "$j" | jq -r 'if (.ExitNodeStatus|type)=="object" then (.ExitNodeStatus.TailscaleIPs[0] // "on") else "none" end')
    printf 'up  ·  %s\n' "$tnet"
    printf 'self  %s\n' "$self"
    printf 'exit  %s\n' "$exitn"
    printf 'peers %s/%s up\n' "$online" "$total"
else
    printf 'down\n'
fi

cache="${XDG_CACHE_HOME:-$HOME/.cache}/conky-pubip"
now=$(date +%s)
mt=$(stat -c %Y "$cache" 2>/dev/null || echo 0)
if [ ! -s "$cache" ] || [ $(( now - mt )) -gt 600 ]; then
    pip=$(curl -4 -fsS --max-time 6 https://ifconfig.me 2>/dev/null || curl -4 -fsS --max-time 6 https://icanhazip.com 2>/dev/null)
    [ -n "$pip" ] && printf '%s' "$pip" > "$cache"
fi
printf 'wan   %s\n' "$(cat "$cache" 2>/dev/null)"
