#!/usr/bin/env bash

# Zadatak - napraviti getopts verziju nekog handlera flagova

# getopts je mini hendler koji hendla flagove ali samo jednoslovne -i -o itd itd

set -euo pipefail

# default vrijednosti
interval=5
outfile=""
quiet=0
verbose=0

# GETOPTS PETLJA ( opt ce biti u case-u, a $OPTIND je ono ispred njega)
# - prvo : zanci da mi hendlamo poruke
# - slova sa : desno od tog slova znaci da primaju argumente (arg. su na $OPTARG)
# - slova sto su skupa mogu ici skupa jer su obicni flaggeri i getopts automatski ide dva puta tri puta koliko ih vec ima da zna sta da radi za svaki flag

while getopts ":i:o:qv" opt; do
    case "$opt" in
        i)
            interval="$OPTARG"      # OPTARG je vrijednost iza -i 
            ;;
        o)
            outfile="$OPTARG"       # OPTARG je putanja iza -o
            ;;
        q)
            quiet=1                 # q je obici flag (prekdidac)
            ;;
        v)
            ((++verbose))           # svako v povecava brojac (-vv daje vrijednost 2)
            ;;
        :)
            echo "Greska: opcija $OPTARG trazi vrijednost" >&2
            exit 2
            ;;
        \?)
            echo "Greska: nepoznata opcija -$OPTARG" >&2
            exit 2
            ;;
     esac
done

# POMJERANJE ARGUMENATA
shift $((OPTIND - 1))
# ispis rezultata
echo "Interval : $interval"
echo "Outfile  : ${outfile:-nije zadan}"
echo "Quiet    : $quiet"
echo "Verbose  : $verbose"
echo "Ostatak  : $*" 

