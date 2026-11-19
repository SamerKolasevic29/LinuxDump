#!/usr/bin/nev bash

# 1. zadatak: iz ssh_auth.log treba da se izvadi listing koji su useri imali najveci broj Failed passworda

# - preko grepa uzmem takve linije
# - uzimam field 9
# - sortiram radi uniq-a
# - opet sortiram numericki naopako da bih izvukao preko heada -n 1 
# uspio sam ovako:
grep "Failed password" ssh_auth.log | cut -d' ' -f9 | sort | uniq -c | sort -nr | head -n 1
 
# - fajl pozivam direktno na grep
# - uzmem kolonu sa imenima
# - sortiram naopako da bih ukinuo vska sort
# - uradim uniq count 
# - uzmem headom prvi red
grep "Failed password" ssh_auth.log | cut -d' ' -f9 | sort -r | uniq -c | head -n 1



# Zadatak 2 - uzeti /etc/passswd i izbrojati broj korisnika svakog shella (kod mene je samo bash)
# - grepom uzeo shellove
# - uzeo 7. field gdje stoji ime shella 
# - uniq -c da izbroji
grep -E '/bin/bash|/bin/sh|/bin/zsh' /etc/passwd | cut -d':' -f7 | uniq -c

# tacnije
cut -d':' -f7 /etc/passwd | sort | uniq -c | sort -nr

# Zadatak 2.1 - uzeti korisnike i UID-ove i soritrati ih po UID-u top 3
# - prvo uzimamo 1. i 3. kolonu
# - soritramo po 2. polju numericki i reversano
# - uzimamo top 3
# - column da skloni dvotacku kao separator
cut -d':' -f1,3 /etc/passwd | sort -t':' -k2,2nr | head -n 3 | column -t -s':'


# Zadatak 3 - uraditi sa shuffle 1000 nasumicnih od 1 do 20 i gledati frekvenciju svakog 
# - generisemo sa shuf -i 1-20 -r -n 1000 
# - pa sortiramo numericki radi uniq 
# - uradimo count sa uniq -c 
# - pa opet sortiramo po broju frekvencija
# - uzimamo top 5
shuf -i 1-20 -r -n 1000 | sort -n | uniq -c | sort -rn | head -n 5
