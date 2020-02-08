#!/bin/sh

# UNICODEMENU
# Simon H Moore
# 
# Gives a list of Unicode characters from a file using dmenu
# and puts the character in primary and clipboard selection
# 
# Requires dmenu to work.

# location of file containing Unicode characters
uc_file=$1

# get chosen Unicode characters from dmenu
# lines beginning with `#` will be ignored
chosen=$(grep -v "#" "$uc_file" | dmenu -i -l 20) || exit

# get Unicode character from chosen
uc=$(echo "$chosen" | awk '{print $1}')

# put Unicode character in both primary and clipboard selection
echo "$uc" | xclip -r -f | xclip -sel clip

# notify user of event
notify-send "$uc copied to primary and clipboard selection"
