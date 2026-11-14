#!/usr/bin/env bash

# trapovi - mehanizam za hvatanje sistemskih signala (ctrl c ili kill) i samog dogadjaja izlaska iz skirpte (EXIT)
# GLAVNA SVRHA trapa je da nikada ne ostav smece iza sebe - bez obzira na set -e flagove ili da korisnik prekine
#
# PRETPOSTAVKA - trap je ono zadnjesto ce se desiti na neki SIGNAL koji ce se desiti
#
# Mini primjer


set -euo pipefail

# kreiranje privremenog direktorija (mktemp -d pravi direktorij umjesto fajla)
tmpdir=$(mktemp -d)
echo "Kreiran je privremeni direktorij: $tmpdir"

# definisanje cleanup funkcije koju ce trap zvati
cleanup() {
    echo "Pokrecem cleanup... Brisem $tmpdir"
    rm -rf "$tmpdir"
}

# Instalacija trapa na EXIT signal (svaki put se pokrece na EXIT znaci kada zavrsi skripta, skripta baca EXIT i trap se aktivira)
trap cleanup EXIT

# stavljanje nekoliko fajlova u privremeni direktorij
touch "$tmpdir/fajl1.txt" "$tmpdir/fajl2.log"

# Namjerno pravljenje greske da bi se desio sljedeci niz
# 1. pozivanje nepostojece fukcije
# 2. set -e prekida skriptu
# 3. skripta baca EXIT 
# 4. trap pali funk. cleanup na EXIT

echo "Sada namjerno pravimo gresku..."
nepostojeca_funkcija

echo "Ova linija se nikad nece ispisati"
