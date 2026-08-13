#!/usr/bin/env bash

# /usr/bin/bash je direktno za bash
# /usr/bin/env bash je portabilan

# Opis skripte - glavni cilj skripte je da:
#			-- upisuje output od free - i od du -h u /data/logs/syshealth.log
#			-- bude pokrenuta od strane Phase1Script2.service (/etc/systemd/system/Hase1Script2.service)
#			-- a da taj servis bude tempiran sa Phase1Script2.timer (/etc/systemd/system/Phase1script2.timer) na svakih 2h


# 1. napravimo od putanje varijablu
path="/data/logs/syshealth.log"

# 2. Osiguramo da je fajl tu
# otpakujemo s vana:
# 	-- prvo se od "$path" dobija path gornji
# 	$(dirname "$path") uzima ime direktorija gdje je to zapravo
# 	onda fakticki time dobijemo /data/logs

mkdir -p "$(dirname "$path")"

# 3. napravimo format ispisa
{
	echo "---------------------------------------------"
	echo 'Statistika glavne memorije memorije:'
	echo ""
	free -h
	echo ""
	echo 'Statistika diska:'
	echo ""
	df / /data -h
	echo "---------------------------------------------"

} >> "$path"
