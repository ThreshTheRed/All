#!/bin/bash

sctl_status=`systemctl status $1 | grep -o 'running'`
result=$(echo $sctl_status)
if [[ "$result" = "running" ]];then
	echo "Dziala"
else
	echo "Nie dziala"
fi
