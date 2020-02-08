#!/bin/sh

# HTMLTOPDFMENU
# Simon H Moore
#
# Takes a URL through dmenu and downloads a html page as a pdf.
# Can get the URL through clipboard.
# Requires htmltopdf, dmenu and xclip.

dir="$PDFS" # directory to store pdf in

url=$(xclip -sel clip) # get URL through xclip

title=$(gethtmltitle "$url" | tr '[:upper:]' '[:lower:]' \
    | sed 's/&/ and /g;
            s/+/ plus /g;
            s/=/ equals /g;
            s/[[:punct:]]/ /g;
            s/[[:space:]]*-[[:space:]]*/-/g;
            s/[[:space:]][[:space:]]*/_/g;
            r/[^[:alnum:]_-]/g' \
    | dmenu -i -l 10 -p "for: ") || exit 1

# convert html to pdf and save in $dir.
htmltopdf "$url" "$dir/${title}.pdf"
