#!/usr/bin/env bash

# sed formatiranje - iz fajla config.txt preko sed-a
# - skloniti linije sa komentarima (regex)
# - skloniti eventualne prazne linije ali i linije sa space-om (regex)
# - gdje pise true da se stavi false

cat config.txt | sed '/^\s*$/d' | sed '/^#/d' | sed 's/true/false/' > newConf.txt
# zapisan u newConf.txt
