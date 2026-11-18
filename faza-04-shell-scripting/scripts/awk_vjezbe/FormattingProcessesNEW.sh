#!/usr/bin/env bash

# Zqadatak - napsiati FormattingProcesses malo ljepse 
# - npr sa vanjskom varijablom da ne zakucam istu u if-u
# - i da ne uradim {next}

FILE="processes.txt"

if [[ ! -s "$FILE" ]]; then
    echo "File na putanji $PWD/$FILE ne postoji" >&2
    exit 1
fi

treshold="${1:-5.0}"

awk -v thr="$treshold" '
    BEGIN { max_cpu = 0
            max_pid = "-"
            max_cmd = "-"
    }

NR > 1 && ($3 + 0) > thr {
    count++
    printf "%-8s %-8s %s\n", $1, $3, $4
    if ($3 > max_cpu ) {
             max_cpu = $3 + 0
             max_pid = $1
             max_cmd = $4
         }
    }
    END { printf "%-10s %-10s %-10s\n", max_cpu, max_pid, max_cmd}
' "$FILE"
