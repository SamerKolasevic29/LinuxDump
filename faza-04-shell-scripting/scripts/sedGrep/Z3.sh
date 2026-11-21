#!/usr/bin/env bash

# Zadatak 3 - koristi access.log

# sada cemo koristiti grep za pronalazak samo ip adresa (FORMATA KOJI LICI N IP ADRESU, VIDJET CMEO POSLIJE ZASTO)
#
grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' access.log
# -o znaci exact match (ne ispisuje cijeli red nego samo ono sto se poklapa)
# AHA KONTAM
# [0-9]{1,3} govori da se u prvom bloku ispisuju moguca 3 broja u rasponu 0-9
# 
# (\.[0-9]{1,3}){3} ide iznutra prema vani
# - IZNUTRA govori da se pojavljuje pattern . pa moguca 3 broja u rasponu od 0-9
# - {3} govori da ce se taj pattern ponoviti 3 puta


# kada bi sada ubaciili 999.999.999.999 vidjeli bi da je regex ovdje pada jer ovo ne moze biti ip adresa

echo ""
# sada moramo sa awk da napisemo da propusti linije koje su fakat ip adrese
grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' access.log | awk -F'.' '$1<=255 && $2<=255 && $3<=255 && $4<=255'
