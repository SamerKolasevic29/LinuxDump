#!/usr/bin/env bash
set -euo pipefail
# Zadatak
# - citati .conf fajlove unutar /etc dira (sa find /etc -maxdepth 1 -name "*.conf")
# - unutar petlje racunati broj bajtova i racunati koliko ima fajlova (ikrementacija i +=)
# - nakon petlje ipisati broj bajtova i broj fajlova

bajtovi=0
br_fajlova=0

while IFS= read -r fajl; do
    br_fajlova=$((br_fajlova + 1))
    bajtovi_fajla="$(stat -c%s "$fajl")"
    ((bajtovi += bajtovi_fajla))
done < <(find /etc -maxdepth 1 -name "*.conf")

echo "Broj bajtova: $bajtovi"
echo "Broj fajlova: $br_fajlova"

# NAPOMENA: 
# - da bi set -euo radio mora se izbjeci postikrement sa:
#   -- preirkementom sa ++br_fajlova
#   -- dodjelom ikrementiranog sa br_fajlova = br_fajlova + 1
#
# - da se ne bi subshell ponavlajo 50000 puta:
#   -- natjeramo find da ne pise imena fajlova nego da pise broj bajova svakog fajla
#       --- broj ponavljanja iteracije koristimo kao broj fajlova
