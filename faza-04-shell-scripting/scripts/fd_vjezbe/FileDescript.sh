#!/usr/bin/env bash

# File deskriptori - sluze da se tokovi stdin i stderr prebace negdje drugo ili da se naprave novi kanali

# FD 0 - stdin kanal koji sluzi da se stvari sa tastature unose
# FD 1 - stdout kanal koji daje obicni ispis bez errora
# FD 2 - stderr kanal koji daje samo greske tacnije errore
# FD N+2 - su custom kanali koje mozemo preusmjeriti i koristiti kao neke druge deskriptore

# tok > - sluzi za preusmjeravanje sa lijeve na desnu stranu ali nanovo pisanje
# tok >> - sluzi da se append-a mjesto gdje je tok usmjeren s lijeva na desno
# tok < - sluzi da se usmjerava sa desno na lijevo


# PRIMJER:
ls /tmp /foo 
# baca stdout (za /tmp) i jedan red stderr (za /foo)

ls /tmp /foo 1> ok.log 2> bad.log
# baca stdout (za /tmp) u ok.log (PREUSMJERENO) i stderr u bad.log (PREUSMJERENO)

ls /tmp /foo > sve.log 2>&1
# stdout i stderr idu skupa u sve.log (GDJE GOD JE stdout U JE I stderr)
