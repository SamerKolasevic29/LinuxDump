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
