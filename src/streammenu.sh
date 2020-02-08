#!/bin/sh

# Get list of mpv friendly urls for streaming from buku

# get primary selection and history from $hfile and pass into dmenu

choice="$(buku --np -t stream,mpv -f 4 | sed '/^waiting for input$/d' | awk -F'\t' '{printf "%-4i %-55.50s %s \n",$1,$3,$4}' | dmenu -i -l 10)"

id="$(echo "$choice" | awk '{print $1}')"

ytp $(buku -p "$id" -f 1 | awk '{print $2}')
