#!/bin/bash
# Insert IP Address into iptables to drop input packets 

ip=$1

[ $# -eq 0 ] && { echo "Usage: $0 ip_address"; exit 1; }

`iptables -I INPUT -s $ip -j DROP`
echo "`iptables -L`"

