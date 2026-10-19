#!/usr/bin/env bash

# Zadatak - read_lab.sh
# -- radimo sa unosom sve tri hajde tako cemo 
# -- unosimo hostname i mora se pokalapati sa pravim
# -- port se mora vidjet da li je izmedju 1 i 65535
# -- env mora biti dev || test || prod

# SIMULACIJA DO WHILE-A ( negativna petlja )


while true; do
	read -rp "Unesite hostname: " new_hostname
	[[ $new_hostname == $HOSTNAME ]] || { sleep 1; echo "Uneseni i originaln se ne podudaraju"; continue; }
	read -rp "Unesite port: " new_port
	[[ $new_port =~ ^[0-9]+$ ]] &&  [[ $new_port -gt 1 && $new_port -le 65535 ]] || { sleep 1; echo "port nije u rasponu -65535"; continue; }
	read -rp "Unesite env(dev || test || prod): " new_env
	case $new_env in
		dev|test|prod)
			echo "Super sve je proslo uredu";
			printf "\nHostname:$new_hostname\nport:$new_port\nenv:$new_env\n"
			exit 0;
			;;
		*)
		echo "Pogresan env"
		continue
		;;
	esac
done;
