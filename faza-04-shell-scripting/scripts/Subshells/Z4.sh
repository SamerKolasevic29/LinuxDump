#!/usr/bin/env bash

# Zadatak - uraditi u forkanom shellu sleep i jos neke naredbe pa da vidimo sa $SECONDS nesto



( sleep 2; echo A  ) & echo "Vanjska situacija"

echo $SECONDS

# OBJASNJENJE: 
# -- Vanjski $SECONDS traje 0 samo zato sto ne gleda forkani 
# -- kao sto bi vidjeli kada bi uradili bash Z4.sh da ce se prije ispisati Vanjska situacija i $SECONDS nego A

