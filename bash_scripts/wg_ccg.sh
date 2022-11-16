#!/bin/bash

# This is the script to generate a simple wireguard config to access the server.

prvkey=$(cat private.key)

if (( $EUID != 0 ))
	then printf "This cript can only be run as root..\n"
	exit
else
	printf "Generating peer config.\n"
	printf "Provide name of config:\n"
	read conf_name \n
	touch $conf_name.conf
	wg genkey | tee private.key | wg pubkey | tee public.key >/dev/null 2>&1
	printf "[Interface]\nAddress = 10.0.0.3/24\nPrivateKey = $prvkey" > $conf_name.conf
fi
