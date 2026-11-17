#!/usr/bin/env bash

# Zadatak - imamo server.log koji ima ima sljedece kolone
# Ip adresa | tip zahtjeva | putanja | status | velicina u bajtima | vrjeme odziva

# treab za svaki:
# - izracunati ukupan broj zahtjeva po ip adresi
# - ukupan promet u KB
# - broj gresaka (svaki status koji je jednak ili veci od 400)
# 
# izlsz:
# zaglavlje u begin blocku
# rezultate po ip adresi ispisi u ENDU koristeci printf (promet na dvije decimale
# pa onda na kraju ukupno izracunati


# STA JE OVDJE FAZON:
# imati 4 asocijativna niza (req,err,traff, total)
# popunjavati prva tri u for loopu
# na kraju popuniti total


awk '
BEGIN {
    printf "%-17s %-15s %-10s %-15s\n\n", "IP ADRESA","ZAHTJEVI", "GRESKE", "PROMET (KB)"
    FS=" \\| "     
}
$3 == "/admin" {next}
{
req[$1]++
traff[$1] += $5

if ($4 >= 400) {
    err[$1]++
}
}
END {
    for (ip in req) {
    printf "%-17s %-15s %-10s %-8.2f\n", ip, req[ip], err[ip], traff[ip] / 1024
    tot_req += req[ip]
    tot_traff += traff[ip]
    tot_err += err[ip]
    }
   printf "%-17s %-15s %-10s %-8.2f\n\n", "TOTAL:", tot_req, tot_err, tot_traff / 1024
}

' server.log
