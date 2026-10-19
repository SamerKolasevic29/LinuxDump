#!/usr/bin/env bash

# Zadatak - proci kroz etc/passwd sa readom i citati samo redove ciji shell nije nologin/false
# cilj je da /etc/passwd ima 7 kolona
# 	-- one koje nam trebaju dajemo joj varijablu (user uid shell)
# 	-- koje nam ne trebaju ide _ te odbacuje
# isto tako sa IFS= kazemo koji je delimetar 
# 	-- u /etc/passwd delimetar je : tako da IFS=:


while IFS=: read -r user _ uid _ _ shell; do
	[[ $shell == *nologin || $shell == *false ]] && printf '%s\t\t%s\t%s\n' "$user" "$uid" "$shell"
done < /etc/passwd
