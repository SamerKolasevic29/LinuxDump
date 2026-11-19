#!/usr/bin/env bash

# Zadatak 5 - awk vs sort | uniq -c
# generisati miliion brojeva od 1-1000 u brojevi.txt
# preko sort | uniq -c vidjeti performanse
# preko awk i njegovih asoc. tabela vidjeti ko je brzi


# 1. generisati
shuf -i 1-1000 -r -n 1000000 > brojevi.txt

# 2. preko EPOCHREALTIME-a cemo vidjeti kako ce to racunati
start=$EPOCHREALTIME 
LC_ALL=C sort brojevi.txt | uniq -c | sort -rn | head -n 5 > /dev/null
end=$EPOCHREALTIME 

echo " Brzina sort | uniq -c je: $(echo "$end - $start" | bc) sekundi"

# 3. resetujemo start, uradimo awk pa opet end
start=$EPOCHREALTIME 
awk '
{c[$1]++} 
END {
    for (k in c) print c[k], k
}' brojevi.txt | sort -rn | head -n 5 > /dev/null
end=$EPOCHREALTIME 
echo " Brzina awk je: $(echo "$end - $start" | bc) sekundi"

