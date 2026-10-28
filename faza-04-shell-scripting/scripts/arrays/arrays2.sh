#!/usr/bin/env bash

# arrays 2 - sparse i kompaktiranje 

# [SPARSE] - rupa u nizu
# niz ima a b c d
arr=("a" "b" "c" "d")
unset 'arr[2]'

# indeksi su sada 0, 2, 3 (nema vise dvojke)
echo "Indeksi: ${!arr[@]}"
# Izlaz je 0 1 3 

# Sta ako ispisemo sve sada elemente
echo "${arr[@]}"
# izlaz je a b d

# [KOMPAKTIRANJE] - preslozit cemo niz
echo -e "\n\n Nakon preslaganja\n"
# samo ga na samog sebe preslozimo
arr=(${arr[@]})

# sada da vidimo indekse
echo "indkesi: ${!arr[@]}"

# sada da vidimo broj elemenata
echo "broj elemenata: ${arr[@]}"

# i na kraju elemente 
echo "elementi: ${arr[@]}"

