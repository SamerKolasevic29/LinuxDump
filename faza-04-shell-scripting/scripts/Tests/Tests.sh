#!/usr/bin/env bash

# Testovi - moderniji i bolji fleksibilniji ispis da se koriste striktno [[]]

# da vidimo sta na prvu vidimo
# unutar [[ ]] imamo regex podudaranje za pattern da li je broj ili nije
# sada je filozofija sljedeca
# -- AKO SE PODUDARA regex nece se ispisati echo
# -- AKO SE NE PODUDARA regex ispisat ce se
# filozofija je ta da se vezu sa || ILI je lijeva strana true ILI ce ispisati drugu
[[ $1 =~ ^[0-9]+$ ]] || { echo "Nije broj" >%2; exit 2; } 

# znamo od prije, sa (()) se rade aritm oper i provjere
# -- ne teba $ na varijabli
# -- rade klasicni simboli operacija
if (( pct >= 80 )); then echo "WARN"; fi

# ovdje se sada vuce poruka skupa sa provjerom
# -- AKO JE statement tacan, onda ispisi I poruku
[[ -f $f && -r $f ]] && echo "čitljiv fajl"

# gbez navodnika globing
[[ $name == *.log ]]

# doslovna zvjezdica
[[ $name == *.log ]]

# redirekcija u [] su < > << >> a test prosao jer je 10 neprazan string
# -- takodjer je napravio fajl 9
[ 10 > 9 ]; ls
