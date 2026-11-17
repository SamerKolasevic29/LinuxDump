#!/usr/bin/env bash

# Here documents - slanje formatiranog ispisa na stdin

# primjer
cat <<EOF
Host: $HOSTNAME
Kernel: $(uname -r)
EOF

echo "---"

# pravljenje konfiguracijskog fajla
cat > config.txt <<EOF
server=localhost
port=8080
EOF

# Quoted delimeter - ne radi expanziju
cat <<'EOF'
$HOME
$(hostname)
EOF


# ZA STA JE OVO DOBRO
# - obicni EOF je dobar za formatirani ispis i kreiranje fajlova po zelji
# - quoted EOF je bukvalista, sve prima kao obicni tekst i ne radi expanziju
