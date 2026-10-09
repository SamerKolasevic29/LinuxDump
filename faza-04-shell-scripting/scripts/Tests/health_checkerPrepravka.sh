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

# PREPRAVKA 
# - sve ifove u [[]] 
# - greske idu na stderr
# - skripta vraca exit 1 ako je ijedan argument bio neispravan

exit_code=0

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
			if [[ -f "$1" ]]; then 
				if [[ -r "$1" ]]; then
					tail -n 5 "$1"
				else
					echo "Error: \"$1\" is not readable, premission denied" >&2
					exit_code=1
				fi
			else
			 	echo "Error: \"$1\" is not a file" >&2
				exit_code=1
			fi
			;;
	esac
        shift
done

# vracamo sa exit kodom
exit $exit_code

