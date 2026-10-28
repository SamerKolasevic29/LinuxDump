#!/usr/bin/env bash

# ova skripta sadrzi samo funkciju 
# PAZNJA: skripta koja CE BITI SOURCANA TREBA DA IMA MAIN GUARD
[[ -n "${_CONFIG_SH_LOADED:-}" ]] && return;
_CONFIG_SH_LOADED=1

echo "[LOG] Loading metrics.sh . . ." 

kvadrat() {
local kvadrat=$(($1 * $1))
echo "Kvadrat je: $kvadrat"
}
