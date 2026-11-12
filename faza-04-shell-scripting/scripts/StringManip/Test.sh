#!/usr/bin/env bash

# string mainpulacija - bash built-in ima male korisne stvari za koje ne treba zvati sed i awk


# 1. duzina stringa (napravit cemo string jedan koji ce se kroz ovaj file operisati)
STRING="Samo nemoj pa se ne boj"

echo "Duzina stringa je: ${#STRING}"

# 2. substring ${string:offest:length} [od offseta pa cijela duzina]
echo "${STRING:11:12}"

# 3. zamjena (dodjelit cemo drugom da ne bi narusili)
zamjenjen="${STRING/nemoj/htjedni}"
echo "$zamjenjen"

# 4. zamjena ali svih ponavljanja ( napravit cemo novu da bi napravili ponavljanje )

ponavljanje="dva i dva su cetiri"
echo "${ponavljanje//dva/tri}"




