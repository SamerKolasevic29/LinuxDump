#!/usr/bin/env bash


# Zadatak - da vidimo kakva je razlika izmedju obicnog xargs echo i xargs -n 1 echo mada mi ide na to da je -n 

# prvi poziv
cat names.txt | xargs echo

# separator
echo -e "\n --- SEPARATOR ---\n"

# drugi poziv
cat names.txt |xargs -n 1 echo

# razlika je u tome sto prvi poziv pise sve u jednom redu a drugi poziv daje po jedan red svakome
# hajde sada da ovo testiramo

# jos jedan saeparator
echo -e "\n --- SEPARATOR ---\n"


# sada da probamo nesto drugo jos
cat names.txt |xargs -n 1 echo "fajl:"

# ovo ce mi dobro doci kada napravim scope projekata mada se jos moram oko toga zajebavati

