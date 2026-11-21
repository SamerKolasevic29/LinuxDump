#!/usr/bin/env bash

# Zadatak 1 - koirsit se services.json

# 1. ovdje vidimo koje kljuceve imamo
jq 'keys' services.json

# 2. izvlacimo imena servisa koji imaju status running
jq -r '.services[] | select(.status == running) | "\(.name)"' services.json

# 3. sada trebamo ispisati ip adrese, ako je null ispisati "N/A"
jq -r '.services[] | if .ip == null then "N/A" else "\(.ip) end"' services.json
