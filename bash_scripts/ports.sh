#!/bin/bash
# Port check

service="$1"

[ $# -eq 0 ] && { echo "Usage: $0 service_name"; exit 1; }

echo 'Tool for checking a ports number' 
echo "You're checking: $service"

nmap=`nmap localhost | grep -w $service`

if [[ -z "$nmap" ]];then 
	echo "Service is not running"
else
	echo "$nmap"
fi

