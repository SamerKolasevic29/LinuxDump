#!/usr/bin/env bash

# Zadatak 3 - korisiti apps_logs.ndjson

# 1. filtriramo logove samo gdje je -.level == "ERROR"
jq 'select(.level == "ERROR")' app_logs.ndjson

# 2. formatiraje logova u format [TIMESTAMP] SERVICE: PORUKA (STATUS_CODE)
jq -r '"[\(.timestamp)] \(.service): \(.message) (kod: \(.status_code))"' app_logs.ndjson

# 3. grupisanje svih gresaka po servisu i prebrojavanje koliko svaki servis ima gresaka
jq -s '
map(select(.level == "ERROR"))
    | group_by(.service)
    | map({
        service: .[0].service,
        error_count: length
    })' app_logs.ndjson




