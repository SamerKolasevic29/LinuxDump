#!/usr/bin/env bash

# Zadatak - testiranje komande da bude kao obicni string i kao niz

# losa praksa
CMD="ls -l \"Moj dokument.txt\""
"$CMD"

CMDX=(ls -l "Moj dokument.txt")
"${CMDX[@]}"
