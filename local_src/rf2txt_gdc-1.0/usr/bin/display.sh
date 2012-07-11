#!/bin/bash
NB_DAY=$1
ADDRESS=$2
NUM_CPT=$3
COLOR=$4
LOG_PATH=/var/www/GnOmeDataCenter/log_brut
LOG_OUT=/var/www/GnOmeDataCenter/out
DATE=`date "+%s"`
FILEOUT=$ADDRESS"_"$NB_DAY"_"$NUM_CPT"_data.txt.png"
export GDFONTPATH=/usr/share/font/
if [ "$NB_DAY" = "1" ]
then
	XFORMAT="%H:%M"
else
        XFORMAT="%d/%m"
fi

function genere_single_cmd()
{
cat <<EOF
set term png
set output "$LOG_OUT/$FILEOUT"
set format x "$XFORMAT"
set autoscale
set ytics 1
set grid
set key off
set xdata time
set xtics rotate by -60
set timefmt "%Y-%m-%d:%H:%M:%S"
plot "single.dat$DATE"  using 1:2 with filledcurves below x1 lt rgb '$COLOR' lw 2
EOF
}
function genere_minmax_cmd()
{
cat <<EOF
set format x "$XFORMAT"
set autoscale
set ytics 1
set grid
set key off
set xdata time
set xtics rotate by -60
set timefmt "%Y-%m-%d"
plot "minmax.dat$DATE"  using 1:3 with filledcurves above x1 lt rgb '$COLOR' lw 2
replot "minmax.dat$DATE"  using 1:2 with filledcurves below x1 lt rgb 'white' lw 2
set term png
set output "$LOG_OUT/minmax_$FILEOUT"
replot
EOF
}
function split_file()
{
	for i in `ls $LOG_PATH | grep "^201" | tail -n $NB_DAY` 
	do
		FILENAME=$i
		cat $LOG_PATH/$FILENAME | grep "^$ADDRESS;"| awk -F";" '{print $2":"$3" "$NUM_CPT}' NUM_CPT=$NUM_CPT>> single.dat$DATE
		min=$(cat $LOG_PATH/$FILENAME | grep "^$ADDRESS;" |cut -d';' -f$NUM_CPT| sort -n | head -1)
		max=$(cat $LOG_PATH/$FILENAME | grep "^$ADDRESS;" |cut -d';' -f$NUM_CPT| sort -n -r | head -1)
		INDEX_DATE=`echo $FILENAME | cut -f1 -d '_'`
		echo $INDEX_DATE $min $max >> minmax.dat$DATE
	done

}

genere_single_cmd > single.cmd$DATE
genere_minmax_cmd > minmax.cmd$DATE

split_file
gnuplot < single.cmd$DATE
gnuplot < minmax.cmd$DATE
rm single.cmd$DATE
rm minmax.cmd$DATE
rm single.dat$DATE
rm minmax.dat$DATE


