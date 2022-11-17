#!/bin/bash

# This is the script to generate a simple wireguard config to access the server.
# Things 2do
# 1. Remodel creating .conf file, to not have it in one line.
# 2. Do the same for key generation and pass each value as a variable.

if (( $EUID != 0 ))
	then printf "This cript can only be run as root..\n"
	exit
else
	printf "Generating peer config. We need your input here:\n"
	printf "Provide name of config:\n"
	read conf_name \n
	printf "Provide IP address of a peer:\n"
	read ip_addr
	printf "Provide server's public key:\n"
	read srv_pub
	printf "Provide server's public IP:\n"
	touch $conf_name.conf
	wg genkey | tee private.key | wg pubkey | tee public.key >/dev/null 2>&1
	prvkey=$(cat private.key)
	printf "[Interface]\nAddress = $ip_addr\nPrivateKey = $prvkey\n[Peer]\nPublicKey = $srv_pub\nEndpoint = " > $conf_name.conf
fi
