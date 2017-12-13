#!/bin/bash

# Label and colors.
label=
on_fg="%{F#74ddcb}"
off_fg="%{F#cec0c0}"
end_fg="%{F-}"

# Directory where .ovpn files are placed.
ovpndir="$HOME/.config/openvpn"

# Default .ovpn to use.
default="$ovpndir/'Hungary (Earth) TCP-1194.super9.ovpn'"

if [ ! -z `pidof openvpn` ]; then
    echo "${on_fg}$label${end_fg} on"
else
    echo "${off_fg}$label${end_fg} off"
fi
