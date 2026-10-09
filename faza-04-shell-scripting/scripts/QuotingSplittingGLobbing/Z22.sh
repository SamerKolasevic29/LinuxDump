#!/usr/bin/env bash

# Drugi dio zadatka
# - iskoristiti $* "$*" $@ i "$@"
# - testirati output
# Ocekujemo lude argumente kao sto su a "a b" ''

printf "Broj argumenata je: $#\n"

printf "Ispisani argumenti sa \$*: $*"
printf "\nIspisani arugmenti sa \"\$*\": %s" "$*"
printf "\nIspisani argumenti sa \$@: $@"
printf "\nIspisani argumenti sa \"\$@\": %s" "$@"

printf "\n ----- \n\n"

echo $*
printf "\n---\n"
echo "$*"
printf "\n---\n"
echo $@
printf "\n---\n"
echo "$@"

# Rezime:
# $* uzima sve argumente i samo ih razmakom dijeli (prazni strigovi se igorisu)
# "$*" uzima sve argumente i stavlja ih ujedan string (prazant string je space)
# $@ je isto kao i $* 
# "$@" cuva u bsahu kao zasebne citirane argumente "$1" "$2" "$3" ...
# ** POSTO SAM STAVIO GORE %s onda ce za svaki zvati odjedanput **
