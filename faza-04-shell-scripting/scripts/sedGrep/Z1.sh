#!/usr/bin/env bash

# Zadatak 1 - koristi services.txt i app.log

# RAD U services.txt
# u jednom prolazu sed-om zamijenim ACTIVE sa UP, FAILED sa down (kao i sot sam htio, blok po blok) 
sed -i 's/ACTIVE/UP/g; s/FAILED/DOWN/g;' services.txt

# da pobrisem linije u kojima je rijec DOWN
sed -i '/DOWN/d' services.txt


# RAD U app.log
#trebamo obrisati sve linije u kojima je ili space ili novi red tacnije prazne (za to koristimo klasu)
sed -i '/^[[:space:]]*$/d' app.log

# ZNACENJA (kako smo dobili da cisti bilo koji novi znak?)
# ^ znaci da je sidro pocetka (MORA POCETI GLEDATI OD PRVOG KARAKTERA U LINIJI)
# 
# [[:space:]] znaci klasa blankozankova (space, \t, \r)
# * znaci 0 ili vise ponavljanja (ovo je za onaj novi red jer nema nikakav karakter samo novi red)
# $ znaci da odmah nakon ovog svega mora biti novi red

