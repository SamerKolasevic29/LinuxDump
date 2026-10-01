#!/usr/bin/env bash

# bash exec tesitranje

# 1.
echo "before"

# 2.
exec bash

# 3. 
echo "after"

# ide sada AHA momenat
# - na komentaru 1. bash nazvat cemo ga bash1 je pokrenuo skriptu exec-process.sh sa PID-om 1234
# - na komentaru 2. bash1 sa execom brise sebe eiz memorije na tom PID-u i predaje PID 1234 novom bashu bash2
# - posto je sekvenca basha1 bila i echo after, bash2 ne zna za to i nikada nece izaci u terminalu
# AHAAAAA
