#!/bin/bash

pac=$(pacman -Quq | wc -l)
aur=$(pacaur -Quq | wc -l)

check=$((pac + aur))
if [[ "$check" != "0" ]]
then
    echo "$pac %{F#15c928}%{F-} $aur"
fi
