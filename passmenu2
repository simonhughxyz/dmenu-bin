#!/bin/sh

# PASSMENU2
# Simon Hugh Moore
#
# Passmenu script which gives you a choice between retrieving pass, login or OTP 
# Requires pass-otp to get the OTP

pass_dir="$HOME/.password-store"
lastpass="$XDG_RUNTIME_DIR/lastpass" # store last pass accessed (pun intended)

# type out using xdotool
write(){
    xdotool type --clearmodifiers "$1"
}

# gets pass from password-store
get_pass(){
    pass show "$password" | head -n1
}

# gets login from password-store, login must have a prefix of `login: `
get_login(){
    pass show "$password" | grep "login: " | cut -d' ' -f 2
}

# Exploits a common design pattern in login fields to
# auto login by following the pattern of:
# type login --> press tab key --> type pass --> press return
auto_login(){
    write $(get_login)
    sleep 0.1
    xdotool key Tab
    sleep 0.1
    write $(get_pass)
    sleep 0.1
    xdotool key Return
}

# got to password-store directory and get a list of files.
cd $pass_dir
password_files="$(find * -type f)"

# get pass file using dmenu
password=$(printf '%s\n' "$(cat $lastpass)" "${password_files}" | sed 's|.gpg||g' | dmenu -i) || exit

# choose what to get from pass file using dmenu
choice=$(printf '*\nURL\nOTP\nPass\nLogin' | dmenu -i) || exit

# store the chosen pass file name in lastpass file
echo "$password" > "$lastpass"

case "$choice" in
    "*") auto_login;;                                   # Writes both login and pass
    Pass) write $(get_pass);;                           # autotype pass
    Login) write $(get_login);;                         # autotype login
    OTP) write $(pass otp show "$password");;           # autotype OTP
    URL) $BROWSER --new-tab "$(pass url "$password")";; # Visit URL
esac
