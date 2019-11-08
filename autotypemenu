#!/bin/sh

# AUTOTYPEMENU
# Simon Hugh Moore
#
# Autotype input to selected window
# Can autotype from clipboard

# file to save autotype history to
# keep it in /run to make it non persistent
hfile="$XDG_RUNTIME_DIR/autotypehistory"

# if hfile file doesn't exist make it
[ -f "$hfile" ] || touch "$hfile"

# get clipboard selection and search history from $hfile and pass into dmenu
selection=$(echo "$(xclip -o -sel clip)" | tac - $hfile | awk 'NF' | dmenu -i -l 10 -p "Text to Autotype: ") || exit 1

# autotype selection
xdotool type --clearmodifiers "$selection"

# append autotype to history file
echo "$selection" >> $hfile
