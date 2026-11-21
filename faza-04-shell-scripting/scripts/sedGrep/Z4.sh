#!/usr/bin/env bash

# Zadatak 4 - koristi se xmonitor.conf

# pravimo reusable funkciju set_config KEY VALUE FILE za upravljanje nad xmonitor.conf

# PRAVILA:
# 1. ako KEY postoji (bio aktivan ili zakomentarisan), treba ga zamjeniti sa KEY=VALUE
# 2. ako nikako ne postoji, dodaj ga na kraj fajla
#
# 3. ne koristiti sed -i nego preko mktemp napraiti kopiju, pa kada sve prodje onda uraditi mv

set_config() {

    local kij="$1"
    local veliju="$2"
    local fajl="$3"

    # sada prvo pravi ovdje mktemp
    [[ -e $PWD/xmonitor.conf ]] || return 1

    local target="$PATH/xmonitor.conf"
    local tmp=$(mktemp "${target}.XXXXX") 

    # ako puskne usput -> trap na return
    trap 'rm -rf "$tmp"' RETURN

    # 3. sada posto je to sve kompleksno (ima escape znakova) moramo normalizovati za REGEX
    local esc_kij
    esc_kij=$(printf '%s' "$kij" | sed 's/[]\.^$*|?+(){}]/\\&/g')

    local esc_veliju
    esc_veliju=$(printf '%s' "$veliju" | sed 's/[\\&|]/\\&/g')

    local pattern="^[[:space:]]*#?[[:space:]]*${esc_kij}=.*"

    # 4. zamjena ako kljuc psotoji ili dodavanje u novi red
    if grep -Eq "$pattern" "$fajl"; then
        sed -E "s|${pattern}|${esc_kij}=${esc_veliju}|" "$fajl" > "$tmp"
    
    else
        cat "$fajl" > "$tmp"
        printf '%s=%s\n' "$kij" "$veliju" >> "$tmp"
    fi

    # 5. kopiranje originalnih permisija (npr 640) i atomski mv
    local perms
    perms=$(stat -c '%a' "$fajl")
    chmod "prems" "$tmp"
     mv "$tmp" "$fajl"  
    }
