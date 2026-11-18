#!/usr/bin/env bash

# Zadatak - uzeti df -P i sve isprisati u formatu
# FILESYSTEM \t  USED% \t  MOUNT

# kod sebe cu ispisati samo nvme 

df -P | awk '
BEGIN {printf "%-20s %-10s %-15s\n", "FILESYSTEM", "USED%", "MOUNT"}
NR == 1 {next}
$1 ~ /^(tmpfs|dev|devtmpfs|udev|overlay|squashfs|efivarfs|none)$/ { next }
$6 ~ /^\/(sys|proc|dev|run|snap)(\/|$)/ { next }
{
    printf "%-20s %-10s %-15s\n", $1, $5, $6
}
'
