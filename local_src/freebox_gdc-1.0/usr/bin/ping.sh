#!/bin/bash
DATE=`date "+%y%m%d_%H%M"`
if ! ping -c 1 www.google.fr >/dev/null
then 
	
	echo "$DATE:cx ko" >> /var/log/ping.log
fi
	

