#!/bin/sh

stat=$(xmms2 current);
stat=${stat%%:*}
if [ $stat = "Stopped" ]; then 
    xmms2 play; 
else 
    xmms2 stop; 
fi
