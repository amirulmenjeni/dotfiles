#!/bin/sh
# By default, xmms2 should be let to repeat the whole playlist.
# We just need to set toggle ON/OFF to playlist.repeat_one.
get_stat=$(xmms2 server config playlist.repeat_one)

case $get_stat in
    "playlist.repeat_one = 1") xmms2 server config playlist.repeat_one 0;;
    "playlist.repeat_one = 0") xmms2 server config playlist.repeat_one 1;;
esac
