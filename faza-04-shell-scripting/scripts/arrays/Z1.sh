#!/usr/bin/env bash

# Zadatak - kreirati niz "serveri" koji ima elemente web1 wbe2 db1 cache1 mail1
# - ispisati cijeli niz
# - prvi element
# - zadnji element sa indeksom -1
# - ukupan broj elemenata
# - i sa for petljom jedan po jedan

# inicijalizacija
servers=("web1" "web2" "db1" "cache1" "mail1")

# ispis cijelog niza
echo "Servers: ${servers[@]}"

# prvi element
echo "First server: ${servers[0]}"

# zadnji element 
echo "Last server: ${servers[-1]}"

# broj elemenata
echo "Number of servers: ${#servers[@]}"

# sa for petljom u svaki red mogu sada ispisat
for i in "${!servers[@]}"; do
	echo "Server #$((i + 1)): ${servers[i]}"
done
