#!/usr/bin/env bash

# Zadatak - napraviti niz mountpoints
# -- napuniti ga Mounted on kolonom iz df -P 
# -- ispisati broj mountpointa

mapfile -t mountpoints < <(df -P | awk 'NR>1 {print $6}')

echo "Number of Mountpoints: ${#mountpoints[@]}"
