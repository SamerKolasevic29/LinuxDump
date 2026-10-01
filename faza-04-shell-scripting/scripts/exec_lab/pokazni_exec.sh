#!/usr/bin/env bash

# find i exec su kombinacija komandi koje:
# - find trazi po sistemu nesto po expressionu tacnije regexu ii nekom patternu
# - exec na sve te rezultate izvsava komandu


# PRIMJER
find /data/logs -name "*.log" -exec wc -l {} \;
# - izlista sve fajlove u /data/logs direktorijumu koji imaju ekstenziju .log
# - za svaki izracuna broj redova fajla
# 	-- {} znaci taj uzet fajl iz find-a
# 	-- \; znaci da ce svaki imati pojedinacan output tacnije count


# PRIMJER 2
find /etc/nginx -name "*.conf" -exec wc -c {} +
# izlista sve fajlove iz /etc/nginx direktorijumu koji imaju ekstenziju .conf
# - za svaki izracuna broj bajtova fajla
# 	-- + znaci da ce sve grupisati u jedan argument
