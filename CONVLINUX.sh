#!/bin/bash
clear

OIFS="$IFS"
IFS=$'\n'

FFMPEG="ffmpeg"
AVTHP="./bin/avthp"

FPS=25
BORDER=8
WIDTH=320
HEIGHT=240
DURATION=30
QUALITY=80
NOAUDIO="--noaudio"
#SKIP="--frameskip"

mkdir THP

if [[ -d $1 ]]; then
	#for file in `find "$1" -type f -name "*.db"`
    for file in `find "$1" -type f -name "*"`
	do
	    THPFILE="${file##*/}"
	    THPFILE="${THPFILE%.*}.thp"
		echo "$file -> $OUTFILE"

        $FFMPEG -y -i "$file" -filter:v "fps=fps=$FPS, drawbox= w=iw : h=ih : t=$BORDER : color=black" -q:v 0 -c:a copy "THP/tempz.mp4"
        $AVTHP -s ${WIDTH}x${HEIGHT} -t $DURATION -q $QUALITY $NOAUDIO $SKIP "THP/tempz.mp4" "THP/$THPFILE"
        rm "THP/tempz.mp4"
	done
elif [[ -f $1 ]]; then
    THPFILE="${1##*/}"
    THPFILE="${THPFILE%.*}.thp"
    echo "$file -> $OUTFILE"

    $FFMPEG -y -i "$1" -filter:v "fps=fps=$FPS, drawbox= w=iw : h=ih : t=$BORDER : color=black" -q:v 0 -c:a copy "THP/tempz.mp4"
    $AVTHP -s ${WIDTH}x${HEIGHT} -t $DURATION -q $QUALITY $NOAUDIO $SKIP "THP/tempz.mp4" "THP/$THPFILE"
    rm "THP/tempz.mp4"
else
	echo "$1 not a file or folder!"
	exit 1
fi
