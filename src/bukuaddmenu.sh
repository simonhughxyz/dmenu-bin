#!/bin/sh

# Add bookmark to buku with tags

URL=$(xclip -sel clip)

tags=$(echo "FOR $URL" | dmenu -i -p "TAGS: ")

# if nothing is chosen then exit
[ "$tags" != "" ] || exit

# if no tags are chosen then exit
[ "$tags" != "FOR $URL" ] || exit

bukuadd $URL $tags
