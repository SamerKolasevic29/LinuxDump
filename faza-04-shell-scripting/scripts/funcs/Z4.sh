#!/usr/bin/env bash

# Zadatak - retry() sa N DELAY cmd args 
# - N kolik puta se petlja u funkciji ponavlja 
# - DELAY koliko spava poslije svake iteracije
# - cmd omanda koja se ponavlja sa njenim argumentima
# ... OVO sutra ali evo korak po korak


# hajde sve ti je ovo uredu sto se tice delay broj ponavljanja i komande, ali
# 1. prvo provjeri sa rade komanda sa argumentima misim koji je njen exit status
# 1.1 baci to u dev/null
# provjeris $? ako je 0 izvri se u petlji
# ako nije ugasi funkciju

retry() {

local N=$1
local DELAY=$2
local CMD=$3
local ARGS=$4

# 1. provjera da li ce uspjesno uraditi cmd args kombo
[[ $CMD == "rm -rf"  ]] && [[ $ARGS == "/"  ]] && { echo "ne smijes ovo"; exit 1  }

"$CMD" "${ARGS[@]}"
exit_code="$?"
[[ $exit_code -gt 0  ]] && { echo "No point of running a command" ; exit 1; }

# 2. petlja u kojoj imamo N ponavljanja i DELAY sleep
for((i=0; i<$N; i++)) do
	"$CMD" "${ARGS[@]}"
	sleep "$DELAY"
done

echo "$?"
}

retry $1 $2 $3 ${4[@]}
