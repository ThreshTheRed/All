#!/bin/bash
# List total info about your system

echo "Just enter the number"
PS3='What do you wanna know? ' 
options=("system info" "hardware info" "cpu info" "disk usage" "Quit")
select opt in "${options[@]}"
do
	case $opt in
		"system info")
			echo "`uname -a`"
			;;

		"hardware info")
			echo "`lshw -short`"
			;;

		"cpu info"):
			echo "`lscpu`"
			;;
		
		"disk usage"):
			echo "`df -H`"
			;;

		"Quit")
			break
			;;
	
		*) echo "invalid option $REPLY";;
	esac
done
		



