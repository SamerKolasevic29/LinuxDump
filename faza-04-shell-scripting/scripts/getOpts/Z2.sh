#!/usr/bin/env bash
set -euo pipefail

# 1. DEFAULT
interval=5
src_interval="default"
conf_file="/tmp/x.conf"

# Ako želimo podržati i -c za custom config fajl, prvo pokupimo flagove u privremene varijable
cli_interval=""

while getopts ":i:c:" opt; do
    case "$opt" in
        i) cli_interval="$OPTARG" ;;
        c) conf_file="$OPTARG" ;;
        :) echo "Greška: opcija -$OPTARG traži vrijednost" >&2; exit 2 ;;
        \?) echo "Greška: nepoznata opcija -$OPTARG" >&2; exit 2 ;;
    esac
done
shift $((OPTIND - 1))

# 2. CONFIG FAJL (gazi default)
if [[ -s "$conf_file" ]]; then
    while IFS='=' read -r key value; do
        # Ignoriši prazne linije i komentare
        [[ -z "$key" || "$key" == \#* ]] && continue
        if [[ "$key" == "X_INTERVAL" && -n "$value" ]]; then
            interval="$value"
            src_interval="config ($conf_file)"
        fi
    done < "$conf_file"
fi

# 3. ENV VARIJABLA (gazi config fajl i default)
if [[ -n "${ENV_INTERVAL:-}" ]]; then
    interval="$ENV_INTERVAL"
    src_interval="env (ENV_INTERVAL)"
fi

# 4. CLI FLAG (gazi sve iznad)
if [[ -n "$cli_interval" ]]; then
    interval="$cli_interval"
    src_interval="flag (-i)"
fi

printf "%-15s : %-10s [izvor: %s]\n" "interval" "$interval" "$src_interval"
