#!/usr/bin/env bash

# Zadatak - napraviti xmonitor.conf koji prima
# hostname=...
# kernel=...
# treshold_cpu=$1
# teshold_ram=$2
#
# da malo zagolicamo mastu

if [[ $# -ne 2 ]]; then
    echo "Skripta trazi 2 argumenta" >&2
    exit 1
fi

cat > xmonitor.conf <<EOF
hostname=$HOSTNAME
kernel=$(uname -r)
treshold_cpu=$1
treshold_ram=$2
EOF
