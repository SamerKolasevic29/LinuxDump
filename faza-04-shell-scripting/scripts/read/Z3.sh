#!/usr/bin/env bash

# Zadatak - da sa read i case izvadim memtotal i memavaiable iz /proc/meminfo


while read -r type memoriess _; do
	case $type in
		"MemTotal:")
			printf "\nUkupno memorije: \033[31m%s\033[0m\n" $memoriess
			;;
		"MemAvailable:")
			printf "Dostupne memorije: \033[31m%s\033[0m\n" $memoriess
		        ;;
		*)
			continue
			;;
	esac
done < /proc/meminfo	
