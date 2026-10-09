#!/usr/bin/env bash

# Zadatak
# -- dato je $dir="/tmp/my logs" 
# -- i rm $dir/*.log
# a) treba objasniti sta shell posalje omandi rm?
# b) objasniti sta ako je dir prazan
# c) popaviti skriptu tako da ako je $dir prazan da se prestane izvrsavati


# OBJASNJENJE:
# - ako dadnemo rm komandi samo $dir sa razmakom unutar variajable desava se sljedece: 
#	 -- dobijamo rm /tmp/my logs/*.log (dva argumenta)
#	 -- sa rm /tmp/my ne mozemo obrisati direkotij tako da desava se greska
#	 -- sa rm logs/*.log u pozvanom direktoiju trazi dir. logs i brise sve sa ekstenzojom .log
# - ako je dir prazan onda ga tretira kao rm /*.log i brise sve iz roota sa ekstenzojom .log

# Popravljanje skripte
# bolje da ide na crnu rupu nego da bude prazno
if [ -z "$dir" ]; then
	echo "greska: varijabla dir je prazna" >&2
	exit 1
fi

rm "$dir"/*.log 2>/dev/null

