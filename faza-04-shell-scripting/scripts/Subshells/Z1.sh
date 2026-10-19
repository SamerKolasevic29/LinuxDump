#!/usr/bin/env bash

# Zadatak - trebamo da ispisemo klasicno u glavnom shellu $$ $BASHPID $PWD
# i onda da upisemo u (..) da vidimo razliku


printf "\n PID Ove skripte je: %s" "$$"
printf "\n BASHPID: %s" "$BASHPID" # env varijabla
printf "\n working dir: %s\n" "$PWD" 

# ovo je sve gore od GLAVNE SKRIPTE
echo -e  "\n--- UNUTAR (..) ---"

(echo $$)
(echo $BASHPID)
(cd ..; echo $PWD;)

# $$ ce uvijek pisati isti PID od glavnog shella
# $BASHPID ce ispisati od (...) PID
# $PWD je interna putanja [gore navedeni primjer ima cd .. cisto da se vidi a dole ovaj echo je od glavne]
echo -e "\n\nnakon (...):$PWD"  
