#!/bin/bash

# Simple script to check TCP/IP packet running to or from host. Its stdout it printed into new file with particular date. 
# Automatize it with cron 

DATE=`date '+%Y%m%d'`
tcpdump -c 1000 >> /tmp/tcpdumpfiles/"$DATE".txt

