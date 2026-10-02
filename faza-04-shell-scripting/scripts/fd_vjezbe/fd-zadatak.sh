#!/usr/bin/env bash

# ZADATAK - napraviti aplikacijski i audit logger 
# koristiti 4 toka 
# 	-- FD 3 je stdout
# 	-- FD 4 pise u logove

# takodjer treba da ima i funkciju za formatiranje teksta


# ~ Podesavanje podrazumjevanih vrijednosti u slucaju praznih ul. param.
APP_NAME="${APP_NAME:-MojServis}"
AUDIT_LOG="${AUDIT_LOG:-/tmp/audit.log}"
ERROR_LOG="${ERROR_LOG:-/tmp/system_errors.log}"

# ~ Postavljanje custom tokova
# prvo custom tokovi pa onda ostale štimamo

# ~~ FD 3 ide na stdout
exec 3>&1

# ~~ FD 4 ide na
exec 4>> "$AUDIT_LOG" 

# ~~ stderr ide na ERROR_LOG
exec 2> "$ERROR_LOG"


# ~ Pomocna funkcija audit_log()
# pravi format [datum] [MojServis] <poruka>

audit_log(){
	local dejt=$(date +%F\ %H:%M)
	echo "[$dejt] [$APP_NAME] $1" >&4
}

echo "Pokrecem instalciju.." >&3
audit_log "Instalacija zapoceta."

# namjerna greska da vidimo tokove
ls /foo 

if [ $? != 0 ]; then
	audit_log "UPOZORENJE: Neki paketi nedostaju"
        echo "Upozorenje: zabiljezeo u audit" >&3
fi

audit_log "Instalacija zavrsena."
