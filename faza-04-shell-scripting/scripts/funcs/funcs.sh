#!/usr/bin/ev bash

# FUNKCIJE - kao i svaki boziji jezik, ima lokalne promjenjive, ulazne, vraca vrijednost

# void neka funkcija
die() { printf "ERROR: %s\n" "$*" >&2; exit 1; }

# ova isto tako get-a iz meminfo u procu

get_mem() {
	local -n _t=$1 _a=$2
	local k v junk
	while read -r k v junk; do
		case $k in
			MemTotal:)      _t=$v ;;
			MemAvailable:)  _a=$v ;;
		esac
	done < /proc/meminfo	
}

get_mem total avail; echo "$total $avail"
