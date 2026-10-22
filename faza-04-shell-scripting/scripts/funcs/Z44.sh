#!/usr/bin/env bash

# prepravka - bolja verzija Z4.sh (slicna ali bolja)


retry() {
 # 1. uzimamo prva dva broja standardno $1 i $2
 local N="$1"
 local DELAY="$2"

 # Radimo shift 2, zasto?
 # 	-- zato sto je fakticki citava komanda $3 i $4 skupa 
 # 	-- pomjerimo za dva i onda ce nam biti sve ostalo sa "$*"
 shift 2
 
 # 2. sigurnosna provjera tako da vidimo da li je to rm -rf /
 local FULL_CMD_STR="$*"

 [[ "$FULL_CMD_STR" == "rm -rf /"*  ]] && { echo "Ne damo da se ove komande pozivvaju kod nas" >&2; exit 1; }

 # 3. inicijalno pozivanje ide na /dev/null 
 # "$@" izvrsava prvu rijec kao komandu a sve ostalo kao argument
 "$@" >/dev/null 2>&1
 local exit_code=$?

 # 4. Provjera inicijalnog statusa
 [[ $exit_code -gt 0  ]] && echo "Komanda baca exit code > 0" || echo "Komanda je uspjesno pozvana u inicjaciji"

local final_exit_status=0
 # 5. Pozivanje u petlji 
 for ((i=0; i<N; i++)); do
	"$@"
	final_exit_status=$?
	sleep "$DELAY"
	
done
return $"final_exit_status"
}

retry "$@"
