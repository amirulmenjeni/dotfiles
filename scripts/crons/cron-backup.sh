#!/bin/bash

# Script usage: sync selected local directories and files
# to cloud ('b' here refers to cloud at box.com). With cron,
# run this script for concurrent backup as frequent as necessary
# (see https://wiki.archlinux.org/index.php/Cron).
#
# This script requires rclone.

function bkp() {

    srv=$1 # The name of the remote servers in rclone (run `rclone config`
           # to manage and view the remotes).
    loc=$2 # Directory path of local directory to be synced with the cloud.
    rem=$3 # Directory path of remote directory to follow the sync from
           # the local directory.

    rclone mkdir $srv:$rem && rclone sync $loc $srv:$rem
}

bkp b ~/Documents/ubd /ubd
bkp b ~/Documents/studies /studies
bkp b ~/Documents/career /career
bkp b ~/Documents/books /books
