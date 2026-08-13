## Pokretanje i postavljanje servisa i tajmera

- **prije svega popraviti putanje u servisima (na mjesta gdje će biti skripte)**

--- 
## Pokretanje servisa
```
sudo systemctl start ImeServisa.service
```

## Pokretanje tajmera ()

**tajmer pokrece servis (malo vise pogledati o automatskom i manuelnom paljenju servisa po imenu)**

```
sudo systemctl enable --now ImeServisa.timer
```
