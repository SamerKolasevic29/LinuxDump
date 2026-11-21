#!/usr/bin/env bash

# Zadatak 2 - koristi sshd_config.copy
# 1. trebamo da ispisemo SVE sto nije nije komentar ili novi red

grep -vE '^[[:space:]]*$|^[[:space:]]*#' sshd_config.copy

# ili pattern '^[[:space:]]*(#|$)'

# 2. trebamo da nadjemo Port rijec i da stavimo na 2222 ali da je IDEMPOTENTNO (da se pozove 5 puta mora samo jednom se izvrsit)
# tri slucaja:
# 1. Port 22
# 2. zakomentarisano #Port 22
# 3. u fajlu vec stoji 2222

sed -E 's/^[[:space:]]*#*Port[[:space:]]22$/Port 2222/' sshd_config.copy
