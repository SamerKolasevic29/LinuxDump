	=== Scripting goals ===

-  means that part is well known now
-- means that part is unknown right now

- bash fundamentals (case, for, while if elif)
- file testing (permission tests, type tests, string tests, artimetric tests)
- subbcomands $()
- traps
- mktemp
- here docs
- stout stderr
- awk
- sed 
- grep

- expr (treba zapisati to da je dobar za substringove, trazenje indeksa prvog pojavljivanja, duzina itd)
takodjer ima i sabiranje i ostale aritm operacije ali dok a takve kalkulacije na 1000 iteracija radi fork i exec
dok bash bulitin ima $((a + b, oduzimanje mnozenje i radi na jos nizem nivou))

- xargs (Komanda koja stdin pipe-om uzima kao parametre navedene dodatne komande te primjenjuje na nju, brza, dobra, takodjer moze poredati u vise -P paralelnih radnji) 
- find - exec (kombinacija pretrage fajlova po tipu i/ili patternu te izvrsavanje komande po svakom tom fajlu,
postoji kulmunalno i pojedinacno prikupljanje rezultata HINT: sa tail -n 1 vadim total na kulmunalnoj sumi)

- file deksriptori (koncept koji nam nudi preusmjeravanje STDIN STDOUT STDERR na mjesta gdje mi zelimo)
takodjer, postoji i koncpet kanal gdje su 0 1 2 zapravo SDIN STDOUT STDERR respektivno, a n+2 su custom kanali
isto tako, preusmjeravanje se radi preko < > << >> i kada zelimo da oponasamo neki ili da ide na njeoguv &ADRESU
mora biti broj kanala pored toka, preusmjeravamo isto tako i na fajlove
-- subshells
-- read
-- source
-- bash arrays
-- associative arrays
-- string manip
-- sort uniq cut tr
-- process subs
-- parallel
-- jq

--- Python & bash pipeline??
