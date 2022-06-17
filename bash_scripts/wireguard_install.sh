#!/bin/bash

if [ "$EUID" -ne 0 ]
	then printf "You have to run this command as a root\n"
	exit
else
	printf "Installing wireguard"
	apt install wireguard
	mkdir -m 0700 /etc/wireguard_test/
	umask 077
	cd /etc/wiregaurd_test/	
	#wg genkey | tee privatekey | wg pubkey > publickey
fi	


# 2do in future
# align it to check distro and act accordingly
# custom names
# QR code for a config?

