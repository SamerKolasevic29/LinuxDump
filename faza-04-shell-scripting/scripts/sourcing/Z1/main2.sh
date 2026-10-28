#!/usr/bin/env bash

# main2 - on ce biti sigurnija verzija i da svaki put kada odleti negdje drugo moci ce pozvati source
# radi preko varijable self koja ce:

# 1. uzeti punu putanju skripte main (pa i ako je symlink)
SELF=$(readlink -f -- "${BASH_SOURCE[0]}")

# 2. pravi putanju 
SELF_DIR="${SELF%/*}"

# 3. gdje god da ode
cd /

# sada sourca preko putanje
source "$SELF_DIR/config.sh"
source "$SELF_DIR/metrics.sh"

# kombinacija sourcane funkcije i sourcane varijable
kvadrat var
