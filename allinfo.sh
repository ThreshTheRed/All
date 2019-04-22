#!/bin/bash
# List total info about your system

echo -e "1 - system info\n2 - hardware info\n3 - cpu info"
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
		



