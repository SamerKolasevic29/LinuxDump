#!/usr/bin/env bash

# treshold.sh 
# arguments VALUE WARN CRIT

# i) ima samo 3 argumenta
# ii) prvo vidjeti da su to brojevi
# iii) CRIT je vece od WARN

# $1 VAL
# $2 WARN
# $3 CRIT

# i)
[[ $# != 3 ]] && { echo "Error: bad param numbers" >&2; exit 3; }

# ii)
if [[ $1 =~ ^(0|[1-9][0-9]*)$ && $2 =~ ^(0|[1-9][0-9]*)$ && $3 =~ ^(0|[1-9][0-9]*)$ ]]; then

# iii)
	if (( $2 <= $3 )); then
		(( $1 < $2  )) && { echo "Status: OK (0)"; exit 0;  }
		(( $1 < $3  )) && { echo "Status: WARN (1) "; exit 1; }
		 echo "Status: CRITICAL (2)"
		 exit 2

	else 
		echo "Error: bad WARN and CRIT" >&2;
		exit 3;
	fi
else
	echo "Error: params are not numbers" >&2;
	exit 3;
fi


