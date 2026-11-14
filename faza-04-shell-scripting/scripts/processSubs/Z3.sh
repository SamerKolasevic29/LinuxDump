#!/usr/bin/env bash

# Zadatak - iz komande generisi_logove() 
# - filtriraj INFO WARN I ERROR linije u logicke fajlove preko tee


generisi_logove() {
    echo "INFO: Sistem pokrenut"
    echo "WARN: Memorija na 80%"
    echo "ERROR: Konekcija na bazu pukla"
    echo "INFO: Pokušavam ponovo..."
    echo "WARN: Visok CPU load"
    echo "ERROR: Timeout na portu 5432"
}

# sada pozivamo funkciju i na pipe-u pisemo u vise fajlova onako kako zelimo filtrirati
# - tee drzi output funkcije
# - WARN daje u warnings.log
# - INFO daje u info.log
# - ERROR daje u errors.log

generisi_logove | tee >(grep "ERROR" > errors.log) >(grep "WARN" > warnings.log) >(grep "INFO" > info.log) > /dev/null
