#!/usr/bin/env bash

# Zadatak - da vidimo ponasanje sa trapom koji treba nesto da uhvati iz subshella

set -Eeuo pipefail

trap 'echo "UHVACENO U GLAVNOM SHELLU"' ERR
(
    echo "Unutar subshella sam"
    false
)
echo "Nastavak nakon subshella"

# --- 1. trap sa ERR ---
#
# - Unutar subshella sam
# - UHVACENO U GLAVNOM SHELLU
# - nastavak nakon subshella
# -- ERR hvata sve non-zero statuse i na njih reaguje, za razliku od EXIT koji se okida uvijek


# --- 2. trap sa EXIT ---
# - Unutar subshella sam
# - nastavak nakon subshella
# - UHVACENO U GLAVNOM SHELLU
# -- posto automatski nakon zadnje komande skripta baca EXIT, tek tada trap ide
# -- trap sa EXIT ce se uvijek izvrsiti


# --- 3. trap sa ERR i set -Eeuo pipefail ---
# - Unutar subshella sam
# - UHVACENO U GLAVNOM SHELLU
# - UHVACENO U GLAVNOM SHELLU
# -- glavni shell NASLJEDJUJE ERR od subhshella
# -- trap se odaziva na jedan ERR pa na drugi nasljedjeni ERR na glavnom
