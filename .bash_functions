# ~/.bash_functions
#

flowchart() {
    dot -Tpng $1 > $(echo $1 | sed -e 's/...$//').png
}

paste() { 
    a=$(cat)
    curl -X POST -s -d "$a" http://paste.sandlayth.me/documents | \
    awk -F '"' '{print "http://paste.sandlayth.me/"$4}'
}

latin2utf() {
    find . -type f -exec iconv -f iso-8859-1 -t utf-8 "{}" -o ./"{}" \;
}

selectedsize() {
    NOM=$(date +%s).png 
    \scrot -s $NOM 
    file $NOM
    rm $NOM
}

sprunge(){ 
    if [[ -z "$1" || -r "$1" ]]; then
        curl -F "sprunge=<${1:--}" http://sprunge.us
    else
        printf '$ %s\n\n%s' "$*" "$("$@")" | sprunge
    fi
}

