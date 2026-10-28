#!/usr/bin/env bash

# Zadatak - uzeti top 5 procesa sa komandom "ps -eo pid,user,rss,comm --sort=-rss"
# (naravno preko head -n 5)
# -- ispisati broj 
# -- uraditi unset
# -- onda nakon tog kompaktirati

# pravo vajdenje
mapfile -t procss < <(ps -eo pid,user,rss,comm --sort=-rss | head -n 6)

# skidanje headera
procss=("${procss[@]:1:5}")

# lijepi ispis
printf "%s\n" "${procss[@]}" | column -t

# proof of all indexes
echo "${!procss[@]}"
# unsetanje 2. elementa
unset 'procss[2]'

# dokaz da ga nema
echo "${!procss[@]}"

# kompaktiranje
procss=("${procss[@]}")

# proof again
echo "${!procss[@]}"







