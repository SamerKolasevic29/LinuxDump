#!/usr/bin/env bash

# Zadatak je
# -- da ispise broj argumenata i svaki u []
# -- da je zovem sa argumentima a "b c" ''
# -- druga skripta da se testiraju $* "$*" $@ i "$@"

printf "Broj argumenata skripte je: %s\n" "$#"
while [ $# -gt 0 ]; do echo "[$1]"; shift; done

# uredu, shiftanjem smo ih sve ispisali rucno 
# sve je tretirao kako treba
