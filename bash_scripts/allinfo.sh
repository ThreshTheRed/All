#!/bin/bash
# List total info about your system

PS3='What do you wanna know?' 

options=("1" "2" "3" "Quit")
select opt in "${options[@]}"
do
	case $opt in
		"1")
			echo "`uname -a`"
			;;

		"2")
			echo "`lshw -short`"
			;;

		"3"):
			echo "`lscpu`"
			;;

		"Quit")
			break
			;;
	
		*) echo "invalid option $REPLY";;
	esac
done
		



