#!/bin/bash

# QUITMENU
# Simon H Moore
# 
# Gives a list of options to:
# hibernate, sleep, exit (logout), shutdown or reboot.

# List of choices to pass to dmenu
choices="hibernate\nsleep\nexit\nshutdown\nreboot"

# get choice form dmenu
choice=$(echo -e "$choices" | dmenu -sb "#ad1616" -p "Quit Menu: ")

case "$choice" in 
    hibernate) sudo ZZZ;;
    sleep) sudo zzz;;
    exit) killall xinit;;
    shutdown) sudo shutdown -h now & ;;
    reboot) sudo reboot & ;;
esac
