#!/usr/bin/env bash

# AWK - data processing alat 
#
# trebam da imam u glavi sljedece
#
#       input records
#           |
#           ˇ
#         fields
#           |
#           ˇ
#        condition
#           |
#           ˇ
#         action

# PISI GA UVIJEK KAO KOD (nemoj jednolinijski)
#
# 1. BEGIN
# BEGIN dio je inicijalizacija (sta ce da radi dok nije uletio u petlju)
#
# 2. GLAVNI DIO 
#  uslov_1 {akcija_1} <--- izvrsava se na svaku liniju koja ovo zadovoljava
#  uslov 2 {akcija_2} <--- vako redamo samo uslove
#
# 3. END 
# END se desava nakon glavnog dijela kada se zavrsi citanje fajla
#
#
# $0 cijela linija (sve kolone)
# $1, $2, ... su numerisane kolone
# NF broj kolona
# NR broj redova tacnije recorda
# FS separator
# OFS separator koji ce se dodjeliti na ispisu (minje aoriginale)
#
# primjer koda 
# BEGIN {  postavnjanje incijalnog ispisa, FS psotavljanje, varijable ...}
# $1 > 300 {next}
# $2 == 500 {print $0}
# END
