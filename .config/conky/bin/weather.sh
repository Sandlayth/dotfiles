#!/usr/bin/env bash
# Weather via wttr.in j1 JSON (auto-location by public IP), cached 30 min.
# Emits a Nerd Font condition glyph + temp, hi/lo, wind, humidity, sun times.
cache="${XDG_CACHE_HOME:-$HOME/.cache}/conky-weather"
ttl=1800
now=$(date +%s)
mt=$(stat -c %Y "$cache" 2>/dev/null || echo 0)
if [ ! -s "$cache" ] || [ $(( now - mt )) -gt "$ttl" ]; then
    j=$(curl -fsS --max-time 10 'https://wttr.in/?format=j1' 2>/dev/null)
    if [ -n "$j" ]; then
        temp=$(jq -r '.current_condition[0].temp_C' <<<"$j")
        feel=$(jq -r '.current_condition[0].FeelsLikeC' <<<"$j")
        desc=$(jq -r '.current_condition[0].weatherDesc[0].value' <<<"$j")
        hum=$(jq  -r '.current_condition[0].humidity' <<<"$j")
        wspd=$(jq -r '.current_condition[0].windspeedKmph' <<<"$j")
        wdir=$(jq -r '.current_condition[0].winddir16Point' <<<"$j")
        hi=$(jq -r '.weather[0].maxtempC' <<<"$j")
        lo=$(jq -r '.weather[0].mintempC' <<<"$j")
        sr=$(jq -r '.weather[0].astronomy[0].sunrise' <<<"$j")
        ss=$(jq -r '.weather[0].astronomy[0].sunset'  <<<"$j")

        sun=$(printf '\U000f0599'); moon=$(printf '\U000f0594')
        hour=$(date +%H)
        case "$desc" in
            *[Ss]unny*|*[Cc]lear*) if [ "$hour" -ge 6 ] && [ "$hour" -lt 19 ]; then ic=$sun; else ic=$moon; fi ;;
            *[Pp]artly*)                         ic=$(printf '\U000f0595') ;;
            *[Cc]loud*|*[Oo]vercast*)            ic=$(printf '\U000f0590') ;;
            *[Rr]ain*|*[Dd]rizzle*|*[Ss]hower*)  ic=$(printf '\U000f0597') ;;
            *[Ss]now*|*[Ss]leet*|*[Bb]lizzard*)  ic=$(printf '\U000f0598') ;;
            *[Tt]hunder*|*[Ss]torm*)             ic=$(printf '\U000f0593') ;;
            *[Ff]og*|*[Mm]ist*|*[Hh]aze*)        ic=$(printf '\U000f0591') ;;
            *)                                   ic=$sun ;;
        esac

        {   printf '%s  %s°C   %s\n' "$ic" "$temp" "$desc"
            printf 'feels %s°    H %s°  L %s°\n' "$feel" "$hi" "$lo"
            printf '%s %s km/h    %s%% hum\n' "$wdir" "$wspd" "$hum"
            printf '%s %s   %s %s\n' "$sun" "$sr" "$moon" "$ss"
        } > "$cache"
    fi
fi
cat "$cache" 2>/dev/null
