#!/bin/bash
# Check if given service is running or not

[ $# -eq 0 ] && { echo "Usage: $0 service_name"; exit 1; }

sctl_status=`systemctl status $1 | grep -o 'running'`
result=$(echo $sctl_status)
if [[ "$result" = "running" ]];then
	echo "It works!"
else
	echo "It doesn't work..."
fi
