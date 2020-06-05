#!/bin/sh

# Give a list of bookmarks to search and open them in current browser

choice="$( buku --np $@ -f 4 | sed '/^waiting for input$/d' | awk -F'\t' '{printf "%-4i %-55.50s %s \n",$1,$3,$4}' | dmenu -i -l 10 | cut -d' ' -f1 )"

# if nothing is chosen then exit
[ "$choice" != "" ] || exit

# buku -o $choice

$BROWSER --new-window "$(buku --np -p "$choice" -f1 | tail -n1 | cut -f2)" # Visit URL
