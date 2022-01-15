#!/bin/bash

echo "It's better to run this script with sudo - some of the options may not work correctly without elevated permission"
echo "Enter the number"
PS3='What do you wanna know about this hardware? '
options=("System info" "Hardware info" "CPU Name" "Disk model" "Disk usage" "Quit")
select opt in "${options[@]}"
do
        case $opt in
                "System info")
                        echo "$(grep -i 'version=' /etc/*-release | cut -d = -f2-)"
                        ;;

                "Hardware info")
                        echo "`lshw -short`"
                        ;;

                "CPU Name"):
                        echo "$(grep 'model name' /proc/cpuinfo -m 1 | cut -d" " -f3-)"
                        ;;

                "Disk model"):
                        echo "$(fdisk -l | grep 'model' | cut -d " " -f4-)"
                        ;;

                "Disk usage"):
                        echo "`df -H`"
                        ;;

                "Quit")
                        break
                        ;;

                *)
                echo "Invalid option $REPLY";;
        esac
done
