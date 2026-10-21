#!/usr/bin/env bash

# Mjesto gdje se funkcije definisu


# ispisuje koristenje skripte i exit 1
usage() {
	cat <<EOF >&2
Usage: $0 [OPTION]
Options:
	info | show - shows report on terminal
	save	    - Stores report in /tmp/system_status.txt
EOF
	exit 1
}

#Ispisuje informativnu poruku na stdout
info() {
	printf "[INFO] %s\n" "$*" >&2
}

# ispisuje upozorenje na stderr
warn() {
	printf "[WARN] %s\n" "$*" >&2
}

# ispisuje na stderr i exit 1
die() {
	printf "[ERROR] %s\n" "$*" >&2
	exit 1
}

