#!/bin/bash

# variables

distro_nr="18.04"
distro_name="Ubuntu"
distro_info='/etc/os-release'

if [ "$EUID" -ne 0 ]
	then printf "You have to run this command as a root.\n"
	exit
else	
	if grep -qs $distro_name $distro_info; then
		os="Ubuntu"
		os_ver="18.04"
		if grep -qs $distro_nr $distro_info | grep $distro_nr; then
			printf "Both conditions are fulfilled\n"
		else
			printf "Distro is good, but version is not\n"
		fi
	else
		printf "Bad distro\n"
	fi
fi
