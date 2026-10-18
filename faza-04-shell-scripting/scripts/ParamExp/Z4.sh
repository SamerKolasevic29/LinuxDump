#!/usr/bin/env bash

# Zadatak 4. koji ne znam ali sad cemo vidjet 
# KEY=VALUE kao $1
# -- pravimo fakticki parser za env varijable
# -- cilj je da se izvuku KEY i VALUE (s tim da VALUE moze imati vise = simbola onda idemo sa prefiksom vadimo)
# -- KEY mora da postuje pravila regexa tog i tog (to ide sa [[]])


key=${1%%=*}
vall=${1#*=}

[[ ! $key =~ ^[A-Z_][A-Z0-9_]*$ ]] && { echo "Following key is not correct. "; exit 1;  }

echo "Key is correct!"
echo "KEY: $key"
echo "VALUE: $vall"
