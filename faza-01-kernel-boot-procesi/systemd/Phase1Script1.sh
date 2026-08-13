#!/bin/bash

# Opis skripte; glavni cilj skripte je da poziva komande kao sto su hostname, date i uptime 
# 				-- da se pokrene preko systemd servisa (/etc/systemd/system/Phase1Script1.sh)
# 				--i da stdout napise u /data/logs/boot.log fajl


# 1. napravimo od putanje varijablu
path="/data/logs/boot.log"

# 2. osiguramo da direktorij postoji
mkdir -p "$(dirname "$path")"

# 3. da ne bi pisali nesto tipa
#
# date >> "$path" && echo "" >> "$path"
# hostname >> "$path" && echo "" >> "$path"
# uptime >> "$path" && echo "" >> "$path"

# mozemo sve grupisati u jednu liniju kao {}


{
	date
	echo ""
	hostname 
	echo ""
	uptime
	echo ""
	echo "-------------------------------------------"
	echo ""
} >> "$path"

