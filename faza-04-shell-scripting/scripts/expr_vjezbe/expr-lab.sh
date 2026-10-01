#!/usr/bin/env bash

# expr - legacy aritm. string. tool

# Zadatak: definisati a=25 b=7 izračunati:
# 	- sumu
# 	- razliku
# 	- proizvod
# 	- integer division
# 	- remainder

A='25'
B='7'

echo -e "$A + $B =\033[36m $(expr $A + $B)"
echo -e "\033[0m$A - $B =\033[36m $(expr $A - $B)"
echo -e "\033[0m$A x $B =\033[36m $(expr $A \* $B)"
echo -e "\033[0m$A / $B =\033[36m $(expr $A / $B)"
echo -e "\033[0m$A % $B =\033[36m $(expr $A % $B)"
