#!/usr/bin/env bash

# Zadatak - skripta ima $1 $2 $3

# za $1 se koristi funkcija is_int vraca true (0) ako jest a false (1) ako nije
# za $2 se koristi funkcija is_port vraca 0 ako je unutar 1-65535
# za $3 se koristi funkcija in_list gdje gledamo da li se nalazi $3 u nizu

target_int="$1"
target_port="$2"
needle="$3"

my_list=("jabuka" "banana" "jagoda")


# jednostavno samo ovako
is_int() {
[[ "$1" =~ ^[+-]?[0-9]+$ ]]
}

is_port() {

is_int "$1" && [[ "$1" -gt 0 && "$1" -le 65535 ]]
}

in_list() {
local target="$1"
shift


for item in "$@"; do
	[[ "$item" == "$target" ]] && return 0
done

return 1
}

if is_int "$target_int"; then
	echo "prvi param je int"
else
	echo "prvi param nije int"
fi

if is_port "$target_port"; then
	echo "drugi param je port"
else
	echo "drugi param nije port"
fi

if in_list "$needle" "${my_list[@]}" ; then
	echo "Treci param se nalazi u listi"
else
	echo "Treci param se ne nalati u listi"

fi
