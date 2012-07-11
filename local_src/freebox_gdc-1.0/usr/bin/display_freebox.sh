#!/bin/bash
LOG_PATH=/var/www/GnOmeDataCenter/log
LOG_OUT=/var/www/GnOmeDataCenter/out
DATE=`date "+%s"`
DATE_LOG=`date "+%y%m%d"`
FILEOUT="freebox_ping_h.png"
FILEOUTH="freebox_histo.png"
FILELOG=$LOG_PATH/$DATE_LOG"_ping.log"

export GDFONTPATH=/usr/share/font/

function genere_freebox_cmd()
{
cat <<EOF
set xlabel "Date des plantages"
set format x "%d/%m %H:%M"
set autoscale
set ytics 1
set grid
set xdata time
set timefmt "%y%m%d_%H%M"
set xtics rotate by -60
plot "freebox.dat$DATE"  using 1:2 with boxes title 'plantage free'
set term png
set output "$LOG_OUT/$FILEOUT"
replot
EOF
}

function genere_freebox_histo_cmd()
{
cat <<EOF
set xlabel "Date des plantages"
set format x "%d/%m/%y"
set autoscale
set ytics 1
set grid
set xdata time
set timefmt "%y%m%d"
set yrange [0:*]
set xtics rotate by -60
plot "freebox.histo.dat$DATE"  using 1:2 with impulses linewidth 5 title 'plantage free par jour'
set term png
set output "$LOG_OUT/$FILEOUTH"
replot
EOF
}

cp /var/log/ping.log $FILELOG
cat $FILELOG | awk '{ print $1"_"$2}' -F_ | awk -F: '{ print $1" 1"}' > freebox.dat$DATE


dateold=""
nbline=1
cat  $FILELOG | while read line
do
	date=`echo $line| awk -F_ '{print $1}'`
	if [ "$dateold" = "$date" ]
	then
		nbline=`expr $nbline + 1`
	else
		if [ -n "$dateold" ]
		then
			echo $dateold" "$nbline >> freebox.histo.dat$DATE
		fi
		nbline=1
		dateold="$date"
	fi
done

genere_freebox_histo_cmd > freebox.histo.cmd$DATE
genere_freebox_cmd > freebox.cmd$DATE

gnuplot < freebox.histo.cmd$DATE
gnuplot < freebox.cmd$DATE

rm freebox.histo.cmd$DATE
rm freebox.histo.dat$DATE
rm freebox.cmd$DATE
rm freebox.dat$DATE




