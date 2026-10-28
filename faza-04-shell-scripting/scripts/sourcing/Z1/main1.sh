#!/usr/bin/env bash 

# ova skripta je za soursovanje 
# -- iz config.sh uzima varijablu 
# -- iz metrics.sh uzima funkciju


# sada je prvi test da se uzme bez cd-a negdje drugo
source ./config.sh
source ./metrics.sh

kvadrat $var;


