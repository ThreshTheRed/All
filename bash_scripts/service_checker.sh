#!/bin/bash

check=`systemctl status lsyncd | awk -F" " '/Active:/{print $2,$3}'`

if [[ $check == "active (running)" ]]
then
        echo "1"
else
        echo "0"
fi

# Plan to replace service name with variable passed upon calling script
