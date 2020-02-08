#!/bin/sh

# Give a list of bookmarks to search and open them in current browser

choice="$(buku --np $@ -f 4 | sed '/^waiting for input$/d' | awk -F'\t' '{printf "%-4i %-55.50s %s \n",$1,$3,$4}' | dmenu -i -l 10)"

# if nothing is chosen then exit
[ "$choice" != "" ] || exit

buku -o $choice
