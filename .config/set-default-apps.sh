#!/bin/sh
# Set default applications via xdg-mime. Common defaults for everyone; the web
# browser differs per user. This script is the versioned source of truth —
# ~/.config/mimeapps.list itself is per-user/untracked and written by xdg-mime.

case "$USER" in
    yassine)   browser='brave-browser.desktop' ;;
    sandlayth) browser='librewolf.desktop' ;;
    *)         browser='librewolf.desktop' ;;
esac

# Web browser (also updates the http/https scheme handlers).
xdg-settings set default-web-browser "$browser" 2>/dev/null
for t in text/html application/xhtml+xml \
         x-scheme-handler/http x-scheme-handler/https \
         x-scheme-handler/about x-scheme-handler/unknown; do
    xdg-mime default "$browser" "$t"
done

# Common defaults (all users).
xdg-mime default org.mozilla.Thunderbird.desktop    x-scheme-handler/mailto
xdg-mime default org.pwmt.zathura-pdf-mupdf.desktop application/pdf
xdg-mime default feh.desktop                        image/jpeg image/png image/gif image/webp image/bmp
xdg-mime default signal.desktop                     x-scheme-handler/sgnl x-scheme-handler/signalcaptcha
xdg-mime default claude-code-url-handler.desktop    x-scheme-handler/claude-cli
