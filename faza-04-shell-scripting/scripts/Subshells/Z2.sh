#!/usr/bin/env bash

# Zadatak - da opet napravim zamku sa while petljom gdje se u pipe-u broji
# -- nacin da je popravim process sub
# -- nacin da je popravim lastpipe


# 1. zamka (broji unutar pipe-a i nece nikad proslijediti)

# sta ovdje zapravo radi 
# -- ovaj printf ima iteracija koliko i varijabli koje treba da ispise (3)
# -- onda ce isto toliko i pipe da radi
printf '%s\n' a b c | while read -r x; do (( ++count )); done
echo "$count"

# 1. prepravka Process subshell
# -- fazon je da ce sada biti obrnut sto se tice redoslijeda 
# 	-- (SVE DOK RADI READ SA DESNE STRANE ikrementiraj count)
# -- a broj iteracija proslijedimo sa < <()
while read -r x; do (( ++count )); done < <(printf '%s\n' a b c)
echo "$count"

# 2. prepravka sa lastpipe
# -- shopt -s lastpipe govori da zadnji pipe u komandi ne pravi novi subshell
shopt -s lastpipe
printf '%s\n' a b c | while read -r x; do (( ++countNew )); done
echo "$countNew"
