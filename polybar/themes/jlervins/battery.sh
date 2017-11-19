#!/usr/bin/sh

###
# Obtain data.
###

output=""

# State: either charging (C), discharging (D), or full (F).
state=$(acpi | awk '{print $3}' | cut -c -1)

# Get battery life percentage.
if [ "$state" != "F" ];
then
    life=$(acpi | awk '{print $4}' | cut -c -2)
else
    life=$(acpi | awk '{print $4}' | cut -c -3)
fi

# Get time remaining.
if [ "$state" != "F" ];
then
    remaining=$(acpi | grep -Eo "[0-9]+:[0-9]+:[0-9]+")
else
    remaining="FULL"
fi


###
# Define colors.
##
source ~/.config/polybar/polycolor.sh

function color_life {
    if [ "$1" -ge "80" ];
    then
        echo $green
    elif [ "$1" -ge "60" ];
    then
        echo $yellow
    elif [ "$1" -ge "40" ];
    then
        echo $orange
    elif [ "$1" -ge "20" ];
    then
        echo $dark_orange
    else
        echo $red
    fi
}

uend="%{u-}"
function underline_indicator {
    if [ "$1" -le "20" ];
    then
        echo "%{u#ff3600 +u}"
    elif [ "$1" -le "10" ];
    then
        echo "%{u#ff1b00 +u}"
    fi
}

function icon {
    # Uses Wuncon Siji for battery icon,
    # from 0x00e242 to 0x00e24b.

    if [ "$state" == "C" ];
    then
        echo 
        return
    fi

    if [ "$1" -ge "90" ];
    then
        echo         
    elif [ "$1" -ge "80" ];
    then
        echo 
    elif [ "$1" -ge "70" ];
    then
        echo 
    elif [ "$1" -ge "60" ];
    then
        echo 
    elif [ "$1" -ge "50" ];
    then
        echo 
    elif [ "$1" -ge "40" ];
    then
        echo 
    elif [ "$1" -ge "30" ];
    then
        echo 
    elif [ "$1" -ge "20" ];
    then
        echo 
    elif [ "$1" -ge "10" ];
    then
        echo 
    else
        echo 
    fi
}

###
# Output.
###

output="$(color_life $life)$(icon $life)$cend  $life% ( $remaining  )"

if [ "$state" == "D" ];
then
    output="$(underline_indicator $life) $output $uend"
fi

echo $output
