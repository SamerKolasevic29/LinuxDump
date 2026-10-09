#!/usr/bin/env bash

# Zadatak, argumenti proslijedjeni sa skriptom se preslusavaju ulazi te se ispisuje
# - int
# - float
# - string 
# - empty

#ako cemo vec preko bash prepoznavanja onda:
shopt -s extglob

while [[ "$#" -gt 0 ]] do
	case "$1" in
	"")
			printf " empty string! \n"
			;;
	?([-+])+([0-9]))
			printf "$1 is Integer\n"
			;;
	?([-+])*([0-9]).+([0-9]))
			printf "$1 is Float\n"
			;;
	*)
			printf "$1 is String\n"
			;;
	esac
	shift
done
			
