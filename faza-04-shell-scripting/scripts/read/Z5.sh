#!/usr/bin/env bash

# Zadatak - treba da cita servers.txt ali
# -- linije sa koemntarima 
# -- prazne linije
# -- linije sa prvim karakterom ' '
# -- i zadnjom linijom bez \n
# NE CTIA TACNIJE PREKSACE
# --- uradit cemo na nacin da ostale linije samo ispise, davno smo pokazali da se se moze :))

while IFS= read -r line || [[ -n $line ]]; do
	[[ -z "$line" ]] || [[ "$line" =~ ^[[:space:]] ]] || [[ "$line" =~ ^#.*$ ]] && { continue; }
        echo "$line"	
done < server.txt
