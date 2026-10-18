#!/usr/bin/env bash

# basename dobar za:
# - vadjenje imena fajla skupa sa ekstenzijom
# - vajdenje ekstenzije

# dirname dobar za vadjenje putanje koja ne ukljucuje ime fajla

# zadatak je sada da se napravi skripta koja od $1 vadi:
# -- Full parh ($1)
# -- Filename (basename $1)
# -- Name (basename $1 .ekstension)
# -- Extension (basename $1 | mozda grep vidjet cemo)

# za ekstenziju cemo napraviti varijablu
EXTENSION=$(echo "$(basename $1)" | cut -d'.' -f2)

echo -e "Full path:\033[36m $1 \033[0m"
echo -e "Filename:\033[36m $(basename "$1")\033[0m"
echo -e "Name:\033[36m $(basename "$1" ".$EXTENSION")\033[0m"
echo -e "Extension:\033[36m $EXTENSION \033[0m"

# Prepravljena verzija preko trimminga # i %

basename_new=${1##*/}
dirname_new=${1%/*}
extension_new=${1%.*}

echo "$basename_new"
echo "$dirname_new"
echo "$extension_net"

# Rasprava za ovo:
# basename_new ce uvijek biti jer trimuje sve do zadnjeg /
# dirname_new ce isto tako biti jer uzima sve do zadnjeg /
# exstenzija nece raditi za:
# 	-- Makefile fajl npr jer nema gdje da izreze na tacku
# 	-- dotfajlovi isto tako ne bi radili 
# 	-- visestruke ekstenzije i mogu medjutim 
# 		--- RJESENJE ZA SVE OVO JE PRESLUSAVANJE CITAVOG PATHA i ZNATI PRISTUP
