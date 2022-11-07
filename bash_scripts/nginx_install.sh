#!/bin/bash

#
# This script will automatically install and do a basic set up of Nginx web server
#
# Plans:
# - write function for centos installation
# - write function for suse installation
# - test test 

if (( $EUID != 0 ))
	then echo "This cript can only be run as root."
	exit
fi

deb_base_inst () {
	if apt list --installed | grep nginx >> /dev/null
		then echo "Nginx is installed already. Skipping..."
		exit
	else
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
	fi	
}

alma_base_inst () {
	if yum list --installed | grep nginx >> /dev/null
		echo "Nignx is installed already, skipping..."
		exit
	else
		yum install epel-release && yum -y install nginx
		echo "Checking if ufw is running."
		systemctl status firewalld | grep inactive
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
			exit
			;;
		"Debian")
			echo "You picked Debian. Installation will start now."
			deb_base_inst
			exit
			;;
		"Alma")
			echo "You picked CentOS. Installation will start now."
			centos_base_inst
			exit
			;;
		"SUSE")
			echo "You picked OpenSUSE. Installation will start now."
			suse_base_inst
			exit
			;;
		"Quit")
			echo "Stopping..."
			exit
			;;
		*) echo "Invalid option $REPLY";;
	esac
done





