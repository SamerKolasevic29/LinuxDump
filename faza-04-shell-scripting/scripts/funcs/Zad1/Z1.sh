#!/usr/bin/env bash

# SYS REPORT SA FUNKCIJAMA


# UZIMANJE PUTANJE OD SKRIPTE SA $BASH_SOURCE[0] ili sa $0
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# sigurnosna provjera putanje 
if [[ -f "$SCRIPT_DIR/lib/log.sh" ]]; then
	source "$SCRIPT_DIR/lib/log.sh"
else 
	echo "ERROR: $SCRIPT_DIR/lib/log.sh no such file or directory " >&2
	exit 1
fi

SYS_FILE="/tmp/system_status.txt"

DATE=$(date)
USERNAME=$USER
HOSTNAME=$(hostname)
UP=$(uptime -p)
PROCESSES=$(ps -ef | wc -l)


# Ako je proslijeđeno više od 1 argumenta
if [ "$#" -gt 1 ]; then
    usage
fi

case "$1" in
    info|show)
        cat <<EOF
Date: $DATE
User: $USERNAME
Hostname: $HOSTNAME
Uptime: $UP
Number of processes: $PROCESSES
EOF
        ;;
    save)
        cat <<EOF > "$SYS_FILE"
Date: $DATE
User: $USERNAME
Hostname: $HOSTNAME
Uptime: $UP
Number of processes: $PROCESSES
EOF
        info "Report saved in $SYS_FILE"
        ;;
    *)
        # Pokriva slucajeve kada nema argumenta ili je proslijeđena nepoznata opcija
        usage
        ;;
esac
