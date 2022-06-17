#!/bin/bash

if [ "$EUID" -ne 0 ]
	then printf "You have to run this command as a root\n"
	exit
else
	printf "Installing wireguard"
	apt install wireguard
	mkdir -m 0700 /etc/wireguard_test/
	#umask 077; wg genkey | tee privatekey | wg pubkey > publickey
fi	
<<<<<<< HEAD


# 2do in future
# align it to check distro and act accordingly
# custom names
# QR code for a config?
=======
>>>>>>> c5b41b12fc30dc53e6df46cd5c9d19ebe2d8d80a
