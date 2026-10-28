#!/usr/bin/env bash

# ova skripta samo drzi neku varijablu
# PAZNJA: u skripti KOJA CE BITI SOURCANA ide onaj guard
[[ -n "${_METRICS_SH_LOADED:-}" ]] && return
_METRICS_SH_LOADED=1

echo "[LOG] Loading config.sh. . ."
var=2
