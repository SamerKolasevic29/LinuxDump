#!/usr/bin/env bash

# Zadatak - retry() sa N DELAY cmd args 
# - N kolik puta se petlja u funkciji ponavlja 
# - DELAY koliko spava poslije svake iteracije
# - cmd omanda koja se ponavlja sa njenim argumentima
# ... OVO sutra ali evo korak po korak


# hajde sve ti je ovo uredu sto se tice delay broj ponavljanja i komande, ali
# 1. prvo provjeri sa rade komanda sa argumentima misim koji je njen exit status
# 1.1 baci to u dev/null
# provjeris $? ako je 0 izvri se u petlji
# ako nije ugasi funkciju

