#!/usr/bin/env bash
set -euo pipefail

# Zadatak - uzeti podatke iz dva snap-a od /proc/stat
# koristiti NR==FNR da bi napravili razliku izmedju prvog i drugog fajl radi delte


SNAP1=$(mktemp)
SNAP2=$(mktemp)
trap 'rm -f "$SNAP1" "$SNAP2"' EXIT

# 1. Uzmi prvi snimak, sačekaj 1 sekundu, pa uzmi drugi
grep '^cpu' /proc/stat > "$SNAP1"
sleep 1
grep '^cpu' /proc/stat > "$SNAP2"

# 2. Jedan awk poziv spaja oba snimka i računa deltu
awk '
# Ovaj blok se izvršava SAMO za prvi fajl ($SNAP1)
NR == FNR {
    tot = 0
    for (i = 2; i <= 9; i++) tot += $i
    
    prev_tot[$1]  = tot
    prev_idle[$1] = $5 + $6
    next
}

# Ovaj blok se izvršava SAMO za drugi fajl ($SNAP2)
($1 in prev_tot) {
    tot = 0
    for (i = 2; i <= 9; i++) tot += $i
    idle = $5 + $6

    delta_tot  = tot - prev_tot[$1]
    delta_idle = idle - prev_idle[$1]

    if (delta_tot > 0) {
        cpu_pct = ((delta_tot - delta_idle) / delta_tot) * 100
    } else {
        cpu_pct = 0
    }

    printf "%-8s %6.2f%%\n", $1, cpu_pct
}
' "$SNAP1" "$SNAP2"

# DOBRO ZA UPAMPTIT
# NR == FNR 
# - izjednacavamo zadani broj redova na broj redova prvog fajla
# - i ta ce istinitost biti tacna SVE DOK je prvi fajl u pitanju
# - kada dodje do drugog fajla FNR ide na 1 tako da NR I FNR NISU ISTI i onda se pokrece uslov dva
