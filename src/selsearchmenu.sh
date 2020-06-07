#!/bin/bash

# Search using various search engines
# Can search using primary selection

# file to save search history to
# keep it in /run to make it non persistant
hfile="$XDG_RUNTIME_DIR/selsearchhistory"

# if hfile file doesent exist make it
[ -f "$hfile" ] || touch "$hfile"

# get primary selection and search history from $hfile and pass into dmenu
selection=$(echo "$(xclip -o)" | tac - $hfile | awk 'NF' | dmenu -i -l 10 -p "Search Term: ") || exit 1


se[0]="Start Page"
se[1]="You Tube"
se[2]="Git Hub"
se[3]="Wikipedia"
se[4]="Arch Wiki"
se[5]="HTTP"
se[6]="Images"
se[7]="IMDB"
se[8]="Duck Duck Go"
se[9]="google"
se[10]="Amazon"
se[11]="Map"
se[12]="GMaps"
se[13]="Ebay"

# get choice of search engine using dmenu
#choice=$(printf "$ddg\\n$yt\\n$git\\n$wiki\\n$aw\\n$http\\n$imdb\\n$sp\\n$google\\n$az" | dmenu -i -p "Search \"$(echo "$selection" | trunk -c 30 -e)\": ") || exit 1
choice=$(printf "%s\n" "${se[@]}" | dmenu -i -p "Search \"$(echo "$selection" | trunk -c 30 -e)\": ") || exit 1


# get apropriate url for choice
if [ "$choice" = "${se[0]}" ]; then
    url="https://www.startpage.com/do/search?query=$selection"
elif [ "$choice" = "${se[1]}" ]; then
    url="https://www.youtube.com/results?search_query=$selection"
elif [ "$choice" = "${se[2]}" ]; then
    url="https://github.com/search?utf8=%E2%9C%93&q=$selection"
elif [ "$choice" = "${se[3]}" ]; then
    url="https://en.wikipedia.org/wiki/$selection"
elif [ "$choice" = "${se[4]}" ]; then
    url="https://wiki.archlinux.org/index.php?search=$selection"
elif [ "$choice" = "${se[5]}" ]; then
    url="$selection"
elif [ "$choice" = "${se[6]}" ]; then
    url="https://duckduckgo.com/?q=$selection&kae=d&kp=-2&kz=1&kav=1&kn=1&k1=-1&kaj=m&kam=osm&kay=b&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kau=-1&kba=-1&kw=n&kh=1&k5=2&t=h_&iax=images&ia=images"
elif [ "$choice" = "${se[7]}" ]; then
    url="https://www.imdb.com/find?ref_=nv_sr_fn&q=$selection&s=all"
elif [ "$choice" = "${se[8]}" ]; then
    url="https://duckduckgo.com/?q=$selection&kae=d&kp=-2&kz=1&kav=1&kn=1&k1=-1&kaj=m&kam=osm&kay=b&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kau=-1&kba=-1&kw=n&kh=1&k5=2&t=h_&ia=web"
elif [ "$choice" = "${se[9]}" ]; then
    url="https://www.google.com/search?q=$selection"
elif [ "$choice" = "${se[10]}" ]; then
    url="https://www.amazon.co.uk/s?k=$selection"
elif [ "$choice" = "${se[11]}" ]; then
    url="https://www.openstreetmap.org/search?&query=$selection"
elif [ "$choice" = "${se[12]}" ]; then
    url="https://www.google.com/maps/search/$selection"
elif [ "$choice" = "${se[13]}" ]; then
    url="https://www.ebay.co.uk/sch/i.html?_nkw=$selection"
fi

$BROWSER "$url"

# append searchterm to history file
echo "$selection" >> $hfile
