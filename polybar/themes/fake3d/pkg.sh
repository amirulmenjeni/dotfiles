#!/bin/bash


pac=$(checkupdates | wc -l) 
aur=$(pacaur -Quq | wc -l) 
echo "$pac $aur"
