#!/usr/bin/env bash

# Zadatak - ueti iz 'ps -eo user,rss' sve usere i njihovo zauzece
# sortirati po MB 


awk '
BEGIN {
    # Odmah da se ispise zaglavlje
    printf "%-15s %12s\n", "USER", "TOTAL_MEM (MB)"
    printf "%-15s %12s\n", "----", "--------------"
}
NR > 1{
    # Megabajta PO useru
    mem_mb[$1] += ($2 /1024)
}
END {
    for (user in mem_mb) {
        # Korisit pipe jer nema sortiranje
        # Sortiranje kaze "SORTIRAJ PO 2. KOLONI NUMERICKI SILAZNO"
        printf "%-15s %12.2f\n", user, mem_mb[user] | "sort -k2 -nr"
    }
    # DOBRA PRAKSA: govorimo awk-u da je zavrseno sa slanje podataka u sort
    close("sort -k2 -nr")
}
' <(ps -eo user,rss)
