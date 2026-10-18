#!/usr/bin/env bash

# ZADATAK - rename_extension.sh .ext1 .ext2 DIR
# -- .ext1 je ekstenzija IZ KOJIH FAJLOVA
# -- .ext2 je ekstenzija U KOJE FAJLOVE 
# -- DIR direktorij gdje se radi preimenovanje
#
# np rename_extension.sh .log .bak /log/xhealth
# uslo bi u /log/xhealth
# sve .log fajlove pravi u bak fajlove


# 0. osigurati broj varijabli

[[ $# -gt 0 ]] && [[ $# -lt 4 ]] || { echo "Error: bad param nums" >&2; exit 1; }

#1. osigurati da ext1 i ext2 su ekstenzije (.*) 
[[ $1 =~ \.([^.]+)$ ]] && [[ $2 =~ \.([^.]+)$ ]] ||  { echo "Error: bad param formats" >&2; exit 1; }

# 2. osigurati da je DIR direktorij
[[ -d $3 ]] || { echo "Error: DIR does not exist" >&2; exit 1; }

# 3. tek sada mogu preimenovat

# 3.1 ulazak 
cd "$3" || exit 1;

# 3.2 prolazak kroz petlju
for f in *"$1"; do
	[[ -e "$f" ]] || { echo "Error: theres any file with $1 extension " >$2; exit 1; }
	new_name="${f%"$1"}$2"

	mv -- "$f" "$new_name"
done
	
	


