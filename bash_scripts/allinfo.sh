#!/bin/bash
# List total info about your system

echo "Just enter the number"
PS3='What do you wanna know? ' 
options=("System info" "Hardware info" "CPU info" "Disk usage" "Quit")
select opt in "${options[@]}"
do
	case $opt in
		"System info")
			echo "`uname -a`"
			;;

		"Hardware info")
			echo "`lshw -short`"
			;;

		"CPU info"):
			echo "`lscpu`"
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

		



