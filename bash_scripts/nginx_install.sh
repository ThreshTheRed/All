#!/bin/bash

#
# This script will automatically install and do a basic set up of Nginx web server
#
# Plans:
# - write function for centos installation
# - write function for suse installation
# 

deb_base_inst () {
	apt update && apt install nginx -y
	echo "Checking if ufw is running."
	if ufw status | grep inactive
	then 
		echo "ufw is not running. You may need to configure it later for better safety."
	else
	
	# I allow the traffic at both 80 & 443 ports, but initially, 443 should be the only option for security
		ufw enable 80,443 proto tcp
	fi
	systemctl enable nginx && systemctl start nginx 	
}

centos_base_inst () {
	yum install epel-release && yum -y install nginx
	echo "Checking if ufw is running."
}

suse_base_inst () {
	zypper update && zypper install nginx
	echo "Checking if firewalld is running."
}

PS3='Pick your OS system: '
OS=("Ubuntu" "Debian" "CentOS" "SUSE" "Quit")
select picked_os in "${OS[@]}"; do
	case $picked_os in
		"Ubuntu")
			echo "You picked Ubuntu. Installation will start now."
			deb_base_inst
			;;
		"Debian")
			echo "You picked Debian. Installation will start now."
			deb_base_inst
			;;
		"Centos")
			echo "You picked CentOS. Installation will start now."
			centos_base_inst
			;;
		"SUSE")
			echo "You picked OpenSUSE. Installation will start now."
			suse_base_inst
			;;
		"Quit")
			echo "Stopping..."
			exit
			;;
		*) echo "Invalid option $REPLY";;
	esac
done




