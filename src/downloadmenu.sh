#!/bin/bash


# List all files in Downloads folder

# get choice of downloads files
choice=$(find $DOWNLOADS -type f | awk -F'/' '{print $NF}' | dmenu -i -l 10)

# if nothing is chosen then exit
[ "$choice" != "" ] || exit

xdg-open "$DOWNLOADS/$choice"
