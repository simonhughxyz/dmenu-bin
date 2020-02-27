#!/bin/sh

# MANMENU
# Simon Hugh Moore
#
# Use dmenu to open man pages
# As shown in video:
# https://www.youtube.com/watch?v=C2HXfyYG5WE 

man $(apropos --long "$1" | dmenu -i -l 10 | awk '{print $2, $1}' | tr -d '()')
