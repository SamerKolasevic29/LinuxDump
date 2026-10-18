#!/usr/bin/env bash


# Zadatak - da od $1 koji ce biti npr "Moj Prvi Server #1" napravimo "moj-prvi-server-1"


# 1. velika u mala slova se postize sa ${var,,}
malaSlova=${1,,}
printf "\n%s pretvoreno je u: %s\n" "$1" "$malaSlova"

# 2. zamjena ' ' sa '-'
obrSimboli=${malaSlova// /-}
printf "%s je sada pretvoreno u: %s\n" "$malaSlova" "$obrSimboli"

# 3. obrisati sve simbole sem 0-9 i a-z
final=${obrSimboli//[^a-zA-Z0-9-]/}
printf "%s je na kraju: %s\n" "$1" "$final"





