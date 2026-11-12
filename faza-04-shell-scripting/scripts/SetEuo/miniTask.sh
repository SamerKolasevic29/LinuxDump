#!/usr/bin env bash

# zadatak - posmatranje exit statusa i efekat flagova na setu

set -euo pipefail

# funckija u pipe-u koja ne psotoji 
echo "start" | missing_command | ls > /dev/null



echo "This should not execute"

# RAZLIKA:
# - sa set -e ce uzeti od posljednje komande u pipe-u exit code i na osnovu njega nastaviti dalje
#   -- cilj je da ne ispise zadnji echo a on je ispisao
#
# - sa set -euo pipefail stajemo sa prvom komandom u pipe-u koja ima exit code > 0 i uzima njegov exit code
#   -- ovdje ne ispisuje zadnji echo radi exit code-a pozivanja missing_command
