#!/usr/bin/env bash

# Zadatak 2 - uzeti iz varijable $TEXT citav string i izvuci 
# 	- duzinu stringa
# 	- substring od odredjene duzine i pocetka
# 	- index prvog pojavvljivanja slova g npr.


TEXT="na vrh brda vrba mrda"

echo -e "string = $TEXT"
echo -e "Broj karaktera u varijabli text:\033[36m $(expr length "$TEXT")\033[0m"
echo -e "Posljednje dvije rijeci:\033[36m $(expr substr "$TEXT" 8 $(expr length "$TEXT"))\033[0m"
echo -e "Prvo pojavljivanje slova r: \033[36m$(expr index "$TEXT" "r")\033[0m"
