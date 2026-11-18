for file in *.mp3; do
  [ -f "$file" ] || continue
  # Uklanja sve u zagradama (), [] i dodatne razmake
  new_name=$(echo "$file" | sed -E 's/\s*\([^)]*\)//g; s/\s*\[[^]]*\]//g; s/  +/ /g')
  if [ "$file" != "$new_name" ]; then
    mv "$file" "$new_name"
  fi
done
