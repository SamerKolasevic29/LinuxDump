#!/usr/bin/env bash

# String manip - da se ne bih dohvacao binarnih datoteka koje ukljucuju fork i exec radi vadjenja smijesnih
# stvari, sada se upustamo u ## i %%
# -- # skida prefiks
# -- % skida sufiks
# -- HINT: preko tastature se mogu osloniti na sta je sta (prefiks(#) sredina($) sufiks(%))

p=/var/log/xhealth/backup.tar.gz

f=${p##*/}      # backup.tar.gz (basename)
echo "${p%/*}"  # /var/log/xhealth (dirname)
echo "${f%%.*}" # backup (sve ekstenzije skinute)
echo "${f%.*}"  # backup.tar (zadnja ekstenzija skinuta)
echo "${f##*.}" # gz (zadnja ekstenzija)

line="cpu_warning=80=x"
echo "${line%%=*} | ${line#*=}" # cpu_warning | 80=x
