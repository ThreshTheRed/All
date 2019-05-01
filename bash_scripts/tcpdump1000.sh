#!/bin/bash

# Simple script to check TCP/IP packet running to or from host. It's stdout it printed into new file with particular date. 

DATE=`date '+%Y%m%d'`
tcpdump -c 1000 >> /tmp/tcpdumpfiles/"$DATE".txt

