#!/bin/sh


# Store recordings in dir
dir="$HOME/rec/"

# get current time and date to save to filename
now="$(date '+%Y-%m-%d_%H:%M:%S')"

res=1920x1080
fps=60

# file to store recording processor ID so that you can kill it later
recpid_file="$XDG_RUNTIME_DIR/recordingpid"

killrecording(){
    recpid="$(cat "$recpid_file")"
    # kill with SIGTERM, allowing finishing touches.
    kill -15 "$recpid"
    rm -f "$recpid_file"
    sleep 3
    # even after SIGTERM, ffmpeg may still run, so SIGKILL it.
    kill -9 "$recpid"
    sleep 1 # no idea why but wont exit without sleep
    refbar
    exit
}

asktoend() { \
    response=$(printf "No\\nYes" | dmenu -i -p "Recording still active. End recording?")
	[ "$response" = "Yes" ] && killrecording
    sleep 1 # no idea why but wont exit without sleep
    exit
}

askrecording() { \
    choice=$(printf "screencast\\nwindow\\nvideo\\naudio\\nscreencast(cpu)\\nvideo(cpu)" | dmenu -i -p "Select recording style:")
	case "$choice" in
		screencast) screencast;;
        window) window;;
		audio) audio;;
		video) video;;
        "screencast(cpu)") cpucast;;
        "video(cpu)") cpuvideo;;
	esac
    exit
}

screencast(){
    refbar
    ffmpeg -y \
    -vaapi_device /dev/dri/renderD128 \
    -f x11grab \
    -video_size $res \
    -framerate $fps \
    -i $DISPLAY \
    -f alsa -i default \
    -vf 'hwupload,scale_vaapi=format=nv12' \
    -c:v h264_vaapi \
    -qp 24 \
    -c:a aac \
    -f mp4 "$dir/${now}_cast_rec.mp4" &
    echo $! > $recpid_file
}

window(){
    refbar
    xid=$(xprop -root _NET_ACTIVE_WINDOW | awk '{print $5}')

    gst-launch-1.0 -q ximagesrc xid="$xid" use-damage=0 \
    ! video/x-raw,framerate=60/1 \
    ! queue ! videoconvert \
    ! vaapisink ! vaapih265enc rate-control=cbr \
    ! h265parse ! mkv. \
    autoaudiosrc ! queue ! audioconvert ! mkv. \
    matroskamux name=mkv ! filesink location="$dir/${now}_rec.mkv" &
    echo $! > $recpid_file
}

cpucast(){
    refbar
    ffmpeg -y \
    -f x11grab \
    -video_size $res \
    -framerate 30 \
    -i $DISPLAY \
    -f alsa -i default \
    -c:v libx264 \
    -preset ultrafast \
    -c:a aac \
    -f matroska "$dir/${now}_cast_rec.mkv" &
    echo $! > $recpid_file
}

video(){
    refbar
    ffmpeg -y \
    -vaapi_device /dev/dri/renderD128 \
    -f x11grab \
    -video_size $res \
    -framerate $fps \
    -i $DISPLAY \
    -vf 'hwupload,scale_vaapi=format=nv12' \
    -c:v h264_vaapi \
    -qp 24 \
    -f matroska "$dir/${now}_video_rec.mkv" &
    echo $! > $recpid_file
}

cpuvideo() {
    refbar
    ffmpeg \
	-f x11grab \
    -video_size $res \
    -framerate $fps \
    -i $DISPLAY \
    -c:v libx264 \
    -f matroska "$dir/${now}_video_rec.mkv" &
    echo $! > $recpid_file
}

audio() { \
    refbar
	ffmpeg -y \
	-f alsa -i default \
	-c:a aac \
	"$dir/${now}_audio_rec.aac" &
	echo $! > $recpid_file
}

list() {
    ls -r "$dir"
}

listmenu() {
    choice="$(list | dmenu -i -l 10)"

    # if nothing is chosen then exit
    [ "$choice" != "" ] || exit

    notify-send "Playing in mpv..." "$choice"
    mpv "$dir/$choice" || notify-send "Failed to play..." "$choice"
}

case "$1" in
	screencast)  screencast;;
	audio)       audio;;
	video)       video;;
	kill)        killrecording;;
    list)        list;;
    listmenu)    listmenu;;
	*)           ([ -f "$recpid_file" ] && asktoend && exit) || askrecording;;
esac
