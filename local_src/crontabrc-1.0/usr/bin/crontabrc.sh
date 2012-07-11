#!/bin/bash
PERIODE=$1

case "$PERIODE" in
    "MIN" )
        DIR=/etc/crontabrc/rc10m ;;
    "HOUR" )
        DIR=/etc/crontabrc/rch ;;
    "DAY" )
        DIR=/etc/crontabrc/rcj ;;
esac

for file in `ls $DIR` ; do
	$DIR/$file
done
