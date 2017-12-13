#!/bin/bash


pac=$(checkupdates | wc -l) 
aur=$(pacaur -Quq | wc -l) 
[ "$pac" -eq 0 ] && pac=
[ "$aur" -eq 0 ] && aur=
echo "$pac $aur"
