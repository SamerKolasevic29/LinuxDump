#!usr/bin/env bash

# Zadatak - Napraviti trap koji hvata SIGINT (INT) to je ctrl+c
# da uhvati foregroudn proces koji stoji na glavnoj skirpti (neki mozda sleep ili cmatrix)
# uhvatit ce ali nece ugasitit glavnu skriptu nego ono sto se pokrece


trap 'echo "Signal primljen (ctrl+c) ali idalje nastavljam da radim jer si ugasio nesto iznad skirpte"' INT

echo "PID ove skripte je: $$"
echo "Pritisni ctrl+c da testiras trap (ili otvori drugi terminal i reci kil $$)"

sleep 300 
echo "Gotovoooo"

# STA SE DESILO
# 1. stavili smo trap koji ce ispisati nesto kada bude SIGINT
# 2. skripta stavlja iznad sebe sleep 300 
#       3.1 kada pritisnemo ctrl+c trap zove echo ali ctrl+c gasi sleep jer je foreground
#       4.1 ide dalje do echo "gotovoooo"
# 3.2 kada zovemo kill <PID skripte> ubijamo skriptu a ne samo sleep
