#!/bin/sh
# polybar keyboard-layout module: print the current layout, or toggle it
# between US (QWERTY) and FR (AZERTY) on click.
case "$1" in
    toggle)
        case "$(setxkbmap -query | awk '/^layout:/{print $2}')" in
            fr*) setxkbmap us ;;
            *)   setxkbmap fr ;;
        esac
        ;;
    *)
        setxkbmap -query | awk '/^layout:/{print toupper($2)}'
        ;;
esac
