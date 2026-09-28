#!/usr/bin/env bash

# Health ckecher - sada cemo vidjet kako radi


while [ $# -gt 0 ]; do
	case "$1" in
		disk)
			df -h /;
			;;
		ram)
			free -h;
			;;
		user)
			echo -e "Current user:\033[36m $USER";
			echo -e "\033[0mHome directory:\033[36m $HOME\033[0m";
			;;
		*)
			if [ -f "$1" ]; then
				if [ -r "$1" ]; then
					tail -n 5 "$1";
				else 
					echo "Error: \"$1\" is not readable, premission denied";
				fi
			else
				echo "Error: \"$1\" is not a file";
			fi
	esac
	shift
done
