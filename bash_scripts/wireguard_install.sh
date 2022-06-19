#!/bin/bash

# Variables

ins_dir='/etc/wireguard_test'

if [ "$EUID" -ne 0 ]
	then printf "You have to run this command as a root.\n"
	exit
else
	printf "Installing wireguard server..."
	apt install wireguard
	mkdir -m 0700 $ins_dir/
	umask 077
	wg genkey | tee $ins_dir/priv.key
	wg pubkey < $ins_dir/priv.key > $inst_dir/pub.key
	touch $inst_dir/wg0_test.conf
	#printf
	#"[Interface]\n
	#Address = public_ip\n
	#ListenPort = 51194\n
	#Privatekey = value_from_private_key"
fi	


# 2do in future
# align it to check distro and act accordingly
# custom names
# QR code for a config?

