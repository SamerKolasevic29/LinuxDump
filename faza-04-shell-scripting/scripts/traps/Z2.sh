#!Usr/bin/env bash 

# Zadatak - safe_backup.sh i sta on radi?
# - prima $1 i ako nije proslijedjen ili direktorij ne postoji ispisi gresku i izadji sa code-om 1
# - set -euo pipefail
# - provjerava da li postoji ikakav lock fajl na mjestu odakle se uzima
# - kreira privremeni radni direktorij mktemp -d
# - unutar tog direkotirja kreira arhivu (tar -czf "$tmpdir/backup.tar.gz" "$1") a tek kada tar uspjesno zavrsi premjesta u gotobvu arhivu trenutni direkotij pod imenom backup_$(date +$F_%H%M%S).tar.gz
# - ima cleanup funckiju koja brise lock fajl i temp direktorij

# 1. set -euo pipefail i putanje lock i src direktorija
set -euo pipefail
LOCKFILE="/tmp/backup.lock"
SRC_DIR=${1:-}      # $1 ili prazan string

# 2. provjera da li ima src uopste 
if [[ -z "$SRC_DIR" || ! -d "$SRC_DIR" ]]; then 
    echo "Putanja nije posljedjena ili direktorij ne postoji" >&2
    exit 1
fi

# 3. da li postoji VEC NA POCETKU lock file
if [[ -e "$LOCKFILE" ]]; then
    echo "Backup je vec u toku (postoji $LOCKFILE), izlatim bez diranja lock file-a" >&2
    exit 1
fi

# 4. kada smo sigurni da nema, pravimo jedan
touch "$LOCKFILE"
TMPDIR=$(mktemp -d)

# 5. cleanup funkcija za trap 
# NAPOMENA: bitan je i redoslijed implementacije i pozivanja trapa
# kako sam prosli put fulio redoslijed jer sam odmah poletio na implementaciju
# zeznuo bih stvar tako da evo ovako ide 
# - prvo provjera lock fajla 
# - drugo cleanup i trap
cleanup() {
   local exit_code=$?
   echo "Cistim resurse"
   rm -rf "$TMPDIR"
   rm -rf "$LOCKFILE"
   exit "$exit_code" 
}
trap cleanup EXIT INT TERM

# 5. sada kada smo sve gore definisali ide glavni dio
echo "Pravim arhivu za '$SRC_DIR' u privremenom direktoriju..."
tar -czf "$TMPDIR/backup.tar.gz" -C "$(dirname "$SRC_DIR")" "$(basename "$SRC_DIR")"

DEST_FILE="backup_$(date +%F_%H%M%S).tar.gz"
mv "$TMPDIR/backup.tar.gz" "./$DEST_FILE"

echo "Backup uspješno završen: $DEST_FILE"
# Ovdje skripta normalno završava -> okida se EXIT trap -> briše TMPDIR i LOCKFILE
