#!/usr/bin/env bash

# args - komanda koja uzima podatke sa stdin-a i na njima izvrsava zeljene komande
#	-- isto tako je dobar za paralelizaciju teskih proracuna



#PRIMJER:
#proslijedili smo mu imena fajlova u koje je xargs usao i uradio pojedinacnu i kulm sumu
printf '%s\n' txts/a.txt txts/b.txt txts/c.txt | xargs wc -l

# koncept 2: sa -0 govorimo da koristi \0 kao separarator imena fajlova npr Moji Dokumenti.pdf
find losaImena -type f -print0 | xargs -0 echo "postoji sa odvojenim imenom   "
