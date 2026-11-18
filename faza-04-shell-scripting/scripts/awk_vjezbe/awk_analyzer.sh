#!/usr/bin/env bash

TMP_FILE=$(mktemp)
trap 'rm -f "$TMP_FILE"' EXIT

echo "Sakupljam 10 uzoraka iz /proc/meminfo..."
for i in {1..10}; do
    grep -E '^(MemTotal|MemFree|MemAvailable|Buffers|Cached|SwapFree):' /proc/meminfo >> "$TMP_FILE"
    sleep 0.2
done

awk '
{
    # Ukloni dvotačku sa kraja naziva (npr. "MemFree:" -> "MemFree")
    metric = $1
    sub(/:/, "", metric)
    val = $2 + 0

    # Ako prvi put vidimo ovu metriku, inicijalizujemo min i max njenom vrijednošću
    if (!(metric in count)) {
        min[metric] = val
        max[metric] = val
    } else {
        if (val < min[metric]) min[metric] = val
        if (val > max[metric]) max[metric] = val
    }

    sum[metric] += val
    count[metric]++
}

END {
    fmt_head = "%-15s %12s %12s %12s\n"
    fmt_row  = "%-15s %12d %12.2f %12d\n"

    printf "\n"
    printf fmt_head, "METRIKA", "MIN (kB)", "MEAN (kB)", "MAX (kB)"
    printf fmt_head, "-------", "--------", "---------", "--------"

    for (m in count) {
        mean = sum[m] / count[m]
        printf fmt_row, m, min[m], mean, max[m]
    }
}
' "$TMP_FILE"
