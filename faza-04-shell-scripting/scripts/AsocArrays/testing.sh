#!/usr/bin/env bash

# asocijativni nizovi - to su nizovi koj kao indeks imaju key a vrijednost value (hashset)


# deklaracija ide sa declare -A 
declare -A ports

# dodjeljivanje ide sa ImeNiza[key]=value


ports[ssh]=22
ports[http]=80
potrs[https]=443

echo "${ports[ssh]}"
