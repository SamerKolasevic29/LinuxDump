#!/usr/bin/env bash

# nizovi, klasicni nizovi ali stringovni

# deklaracija - svaki element odvojen zarezom i stoji u navodnicima
arr=("element1" "element2" "element3")

# dodavanje novog elementa
arr+=("novi_element")

# broj elemenat au nizu 
echo "${#arr[@]}"

# Lista svih indeksa kojih postoje
echo "${!arr[@]}"

# ispis prvog elementa
echo "Prvi element: ${arr[0]}"

# slicing arr[@]:od_kojeg:koliko
arr2="${arr[@]:1:3}"
# DISCLAIMER: ZA SIGURNO PRENOSENJE KORISTITI NAVODNIKE

# okej je primio, ispis ide ovako
echo "${arr2[@]}"

# [PUNJENJE NIZA KOMANDAMA]
# da bi punili sigurno niz izlazom neke komande:
# -- mapfile (ona govori da svaki novi red izlaza komande je novi element)
# -- -t (uklanja \n)

# - uzima sa df-a izlaz
# - daje ga awk-u da cita 6. kolonu od 2. linije pa nadalje 
# - pa onda puni mounts niz
mapfile -t mounts < <(df -P | awk 'NR>1 {print $6}') 
echo "${mounts[@]}"
echo -e "\n\n --- FOR PETLJOM CITANJE --- \n\n"
# da vidimo da li znamo preko niza citat elem po elem
for i in "${!mounts[@]}"; do
	echo "${mounts[i]}"
done

