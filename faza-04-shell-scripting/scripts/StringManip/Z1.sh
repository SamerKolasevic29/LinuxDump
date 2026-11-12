#!/usr/bin/env bash

# Zadatak - od stringa "/var/log/xmonitor/server.log" uraditi sljedece
# - izvuci nekoliko rijeci (izvuci cemo path string do server.log)
# - dio koji treba za ime (server)
# - zamijeniti server sa cpu
# - zamijeniti sve / sa |
# - duzina stringa


path="/var/log/xmonitor/server.log"

# izvlacenje putanje
echo "putanja do server.log je: ${path:0:17}"

# ime fajla
echo "ime fajča je: ${path:18:6}"

# server -> cpu
echo "sada je putanja: ${path/server/cpu}"

# / -> |
echo "prettier path: ${path////|}"

# duzina stringa
echo "dzuina putanje je: ${#path}"

