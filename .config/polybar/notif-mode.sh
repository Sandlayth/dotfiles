#!/usr/bin/env bash
# dunst notification mode button for polybar.
# Cycle: ALL (visible + sound) -> SILENT (visible, no sound) -> DND (none).
# No args: print the current-mode icon (coloured) for the bar.
bell=$(printf  '')   # all     (bell)
mute=$(printf  '')   # silent  (volume-off)
slash=$(printf '')   # dnd     (bell-slash)

mode() {
    [ "$(dunstctl is-paused 2>/dev/null)" = true ] && { echo dnd; return; }
    s=$(dunstctl rules 2>/dev/null | awk '/^\[play_sound\]/{f=1} f&&/enabled/{print $3; exit}')
    [ "$s" = true ] && echo all || echo silent
}

set_mode() {
    case "$1" in
        all)    dunstctl set-paused false; dunstctl rule play_sound enable ;;
        silent) dunstctl set-paused false; dunstctl rule play_sound disable ;;
        dnd)    dunstctl set-paused true ;;
    esac
}

case "$1" in
    toggle)
        case "$(mode)" in
            all)    set_mode silent ;;
            silent) set_mode dnd ;;
            *)      set_mode all ;;
        esac
        ;;
    *)
        case "$(mode)" in
            all)    echo "%{F#9ece6a}${bell}%{F-}" ;;
            silent) echo "%{F#e6b450}${mute}%{F-}" ;;
            dnd)    echo "%{F#f2777a}${slash}%{F-}" ;;
        esac
        ;;
esac
