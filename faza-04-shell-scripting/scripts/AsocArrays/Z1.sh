#!/usr/bin/env bash

# Zadatak - napraviti services asoc. niz sa sljedecim key value parovima
# ssh -> active
# nginx -> active
# docker -> inactive
# postgresql -> active

# deklaracija
declare -A services

# inicijalizacija 
services[ssh]="active"
services[nginx]="active"
services[docker]="inactive"
services[postgresql]="active"

# ispis svih
echo "--- ispis svih key value parova ---"
for key in "${!services[@]}" ; do
    echo "$key -> ${services[$key]}"
done

echo ""
echo "--- ispis svih koji je status inactive"
for key in "${!services[@]}"; do
    if [[ "${services[$key]}" == "inactive" ]]; then
        echo "$key -> ${services[$key]}"
    fi
done
