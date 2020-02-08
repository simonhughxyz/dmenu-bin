#!/bin/sh

# PDFMENU
# Simon H Moore
# 
# Gives a dmenu list of all files in the pdfs directory
# and opens them using zathura.
# Requires dmenu and zathura to work.

# location of directory containing pdfs
pdf_dir="$HOME/pdfs"

# get choice of pdf
choice=$(ls $pdf_dir | dmenu -i -l 10) || exit

# open pdf using zathura
zathura "$pdf_dir/$choice"
