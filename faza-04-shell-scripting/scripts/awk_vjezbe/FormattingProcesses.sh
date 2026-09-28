#!/usr/bin/env bash

# radim sada malo jaci awk gdje iz processes.txt citam sve redove sa usage-om vecim od 5%

FILE=processes.txt

# redoslijed je sljedeci
# PID USER CPU COMMAND
# $1  $2   $3  $4

# jedna lijepa praksa a i da mi udje u prste
if [ ! -e "$FILE" ] || [ ! -s "$FILE" ]; then
	echo -e "file na putanji $(echo "$(pwd)/$FILE") ne postoji\n Zavrsavam program..."
	exit 1;
fi
awk 'NR==1 {next}
     {
     if($3 > 5.0) {
	print $1, $3"%\t"$4
     }}' $FILE


