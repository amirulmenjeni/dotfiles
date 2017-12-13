#!/usr/bin/env bash

function run {
    if ! pgrep $1;
    then
        $@&
    fi
}

run sh ~/scripts/utils/blur-bg.sh ./themes/dremora-modded/wall.png\
                                  ./themes/dremora-modded/wall-blurred.png

run compton --config ~/.config/compton/compton.conf
