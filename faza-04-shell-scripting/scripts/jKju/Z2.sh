#!/usr/bin/env bash

# Zadatak 2 - koristi services.json

# 1. filtriramo sve servise koji trose vise od 500 i imaju production okruzenje
jq '.services[] | select(.memory_mb > 500 and .env == "production")' services.json

# 2. sada moramo da napravimo validan JSON niz od filtriranog
jq '[.services[]
                    | select(.memory_mb > 500 and .env == "production")
                    | {
                        service: .name,
                        mem_gb: (.memory_mg / 1024),
                        owner: .meta.owner
                        }' services.json


# 3. sada trebamo da napravimo zbir memorije koju svi trose
jq '[.services[].memory_mb] | add' services.json

# treba se napraviti array da bi on mogao da hoda po njemu
