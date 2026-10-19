#!/usr/bin/env bash

# Zadatak - da se koristi -s flag i -t flag 
secret_pass="user1234"

# 1. Prvi unos lozinke sa timeout-om od 10 sekundi
if read -t 10 -srp "Unesite lozinku: " entered; then
    echo "" # Dodajemo novi red jer -s skriva Enter
    
    # 2. Ako je prva lozinka uspješno unesena, tražimo potvrdu (isto 10s)
    if read -t 10 -srp "Potvrdite lozinku: " confirmed; then
        echo "" # Još jedan novi red za uredan ispis
        
        # 3. Usporedba unesenih lozinki i provjera sa tačnom lozinkom
        if [[ "$entered" != "$confirmed" ]]; then
            echo "Greška: Lozinke se ne podudaraju!"
            exit 1
        elif [[ "$entered" == "$secret_pass" ]]; then
            echo "Uspješna prijava! Lozinka je tačna."
        else
            echo "Pristup odbijen: Pogrešna lozinka."
            exit 1
        fi

    else
        # Default ponašanje ako istekne vrijeme za potvrdu lozinke
        echo -e "\n\n[Timeout] Isteklo je vrijeme za potvrdu lozinke (10s)."
        exit 1
    fi

else
    # Default ponašanje ako istekne vrijeme za prvi unos lozinke
    echo -e "\n\n[Timeout] Isteklo je vrijeme za unos lozinke (10s)."
    exit 1
fi

