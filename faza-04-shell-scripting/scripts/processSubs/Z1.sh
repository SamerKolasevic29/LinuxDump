#!/usr/bin/env bash

# Zadatak - napraviti diff dva ispisa direktorija
# - dobar primjer BORBA 1.0 i BORBA 1.3

# odmah cemo otici na Projects
cd "$HOME"/Projects/githab

# sada ide diff
diff <(ls "BORBA-V1.0") <(ls "BORBA-v1.3")

