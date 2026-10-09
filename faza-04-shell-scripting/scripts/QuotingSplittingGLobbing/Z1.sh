#!/usr/bin/env bash

# Zadatak - da se safe code pise kada su u pitanju cudna imena fajlova
# "$var" rjesava prolvleme kada imamo "a b.txt" "star*.txt" "-n.txt"

# -- gore tri navedena imena trebamo napraviti komandom, onda kada ih napravimo trebamo uvidjeti razlike iz
# for f in $(ls) 
# for f in *
# -- nakon toga treba da vidimo razliku izmedju brisanja sa
# --
# ./

# ovdje " " osigurava da se fajl doslovno zove a b.txt dok kada bi bez navodnika napsiali
# imali bi a b.txt i c.txt (tri fajla)
mkdir -p /tmp/q && cd /tmp/q && touch "a b.txt" 'star*.txt' -n.txt

# ***TRIK STVAR*** tretira -n.txt kao flag a takog nema
# pozivanje -- ignorise flagove i sve tretira kao argumente
touch "a b.txt" 'star*.txt'
touch -- -n.txt


# TEST 1 testiramo sta ce biti sa citanjem ako kazemo
for f in $(ls); do echo "[$f]"; done

# POSIX standard a i trebao bi ga koristiti vako sto
printf "\n\t\t----\n"

# Uvidjeli smo razliku: tretira a ako poseban fajl

# TEST 2 - koristenje * umjest $(ls)
for f in *; do echo "[$f]"; done
printf "\n\t\t----\n"

# Uvidjeli smo razliku: ispravno gleda imena fajlova

# sada brisemo te fajlove

for f in *; do rm -- "$f"; done
for f in *; do rm ./"$f"; done

# Obe varijante brisu jer sam ih slucajno dobro napisao
# ./ stiti od flag efekta a -- isto stiti od flag efekta
