#!/bin/sh

# Extract mp3 audio from a given youtube video,
# name the file, and set the id3v2 tags of the mp3's
# title and artist.
#
# Requires: youtube-dl, id3v2

if [[ $# != 3 ]]; then
    echo "Usage:"
    echo "    youmus.sh URL TITLE ARTIST"
    exit
fi

url=$1
title=$2
artist=$3

filename="${artist} - ${title}.mp3"

youtube-dl -x --audio-format mp3 $url -o ".temp.%(ext)s"
id3v2 -t "$title" -a "$artist" ".temp.mp3"
mv ".temp.mp3" "$artist - $title.mp3"
