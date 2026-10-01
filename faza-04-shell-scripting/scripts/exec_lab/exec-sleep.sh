#!/usr/bin/env bash

# exec sa sleepom - fokus na pracenje process tree-a (probat cu da pratim sa htopom)


echo "Starting sleep..."
exec sleep 30

# Pratio sam i dobio sam to da je na PID 2754 gdje je bio /usr/bin/bash preuzeo /usr/bin/sleep 30
