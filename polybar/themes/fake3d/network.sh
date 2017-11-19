#!/usr/bin/sh

###
# Defining colors.
###

source ~/.config/polybar/polycolor.sh


# Function determining the color depends on signal strength.
# Input: signal strength (int)
color_signal() {
    if [ "80" -le "$1" ];
    then
        echo $green
    elif [ "60" -le "$1" ];
    then
        echo $yellow
    elif [ "40" -le "$1" ];
    then
        echo $orange
    elif [ "20" -le "$1" ];
    then
        echo $dark_orange
    else
        echo $red
    fi
}

###
# No connection? Tell 'em!
###
if [ -z $(nmcli -t -f NAME con show -a) ];
then
    echo "${red}NO CONNECTION${cend}"
    exit
fi

###
# Obtaining connection information.
###

# Get the NAME of currently active connection.
con_name=$(nmcli -t -f NAME con show -a)

# Get BSSID of currently active connection.
con_bssid=$(nmcli con show $con_name | grep seen-bssid | awk '{print $2}')

# Get the SSID of the currently active connection.
con_ssid=$(nmcli dev wifi | grep ^\* | awk '{print $2}')
if [ -z $con_ssid ];
then
    con_ssid=$(nmcli -t -f SSID dev wifi list bssid $con_bssid)
fi

# Get the SIGNAL strength of the currently active connection.
con_signal=$(nmcli dev wifi | grep ^\* | awk '{print $7}')
if [ -z $con_signal ];
then
    con_signal=$(nmcli -t -f SIGNAL dev wifi list bssid $con_bssid)
fi

sig_col=$(color_signal $con_signal)
echo "$con_ssid ( ${sig_col}${con_signal}${cend}% )"
