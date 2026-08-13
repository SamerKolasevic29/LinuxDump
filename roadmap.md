# 🐧 Linux Mastery Roadmap — EliteDesk Edition
> Od solidnog developera do kompetentnog Linux administratora
> Knjiga: **How Linux Works** (Ward) kao primarna | **UNIX & Linux SA Handbook** (Nemeth) kao referenca
> Cilj: Razumjeti Linux internale, administrirati produkcijski server, automatizirati sve
> Lab: **HP EliteDesk 800 G4 Mini** → Ubuntu Server 24.04 LTS

---

## 📚 Resursi

### Knjige
| # | Knjiga | Uloga |
|---|--------|-------|
| 1 | **How Linux Works — Brian Ward (3rd Ed.)** | PRIMARNA. Kernel, boot, filesystems, networking, scripting — konceptualno čisto. Čitaj od korice do korice. |
| 2 | **UNIX and Linux System Administration Handbook — Nemeth et al. (5th Ed.)** | Referentna biblija sysadmina. Čitaj selektivno — samo poglavlja navedena uz svaku fazu. |
| 3 | **The Linux Command Line — William Shotts (2nd Ed.)** | **Besplatna online:** linuxcommand.org. Bash biblija — čitaj paralelno uz Fazu 4. |

### Dokumentacija (ova 5, bez lutanja)
| Resurs | Koristi za |
|--------|------------|
| **Ubuntu Server Guide** (ubuntu.com/server/docs) | Prva destinacija — Netplan, LVM, AppArmor, Docker, Nginx, sve Ubuntu-specifično |
| **Arch Wiki** (wiki.archlinux.org) | Konceptualna dubina za svako pitanje — koncepti važe i za Ubuntu. Drugi u liniji. |
| **DigitalOcean Community** (digitalocean.com/community) | Izvanredno pisani step-by-step tutoriali za Ubuntu. Uvijek provjeri da je 22.04/24.04 verzija. |
| `man <command>` + `tldr <command>` | Navika čitanja man stranica je skill sam po sebi. `tldr` za brzi cheatsheet. |
| **Ubuntu Manpages** (manpages.ubuntu.com) | Online man stranice — korisno kad si na Fedori, a tražiš Ubuntu ekvivalent |

---

## Tvoj polazni kontekst

**Imaš:** C++, C#, SQL, Linux osnove

**Tvoj server — HP EliteDesk 800 G4 Mini:**
| Komponenta | Spec | Relevantnost za homelab |
|------------|------|------------------------|
| **CPU** | Intel i5-8500T — 6c/6t, do 3.5 GHz, **35W TDP** | 35W TDP = može raditi 24/7 bez brige o struji. 6 jezgri = višestruki Docker servisi simultano bez problema. |
| **GPU** | Intel UHD Graphics 630 | Server radi headless — GPU nebitna. Kernel driver `i915` učitan automatski, ne dira se. |
| **RAM** | 16 GB DDR4 | Dovoljno za 6–8 Docker kontejnera simultano (Nginx + PostgreSQL + Gitea + Grafana + Pi-hole i više). |
| **Disk** | 500 GB SSD | Solidan za OS + sve servise + podatke. Dokumentuj partition shemu od instalacije. |

**Što to znači za ovaj roadmap:**
- Faze 1–2 (kernel, filesystem) su ubrzan prolaz — sistemsko razmišljanje već imaš
- Faza 3 (networking) je posebno bitna — server mora biti ispravno zaštićen **prije** nego staviš ičta na internet
- Faza 5 je srž svega — ovdje dižeš homelab servis po servis, na pravom hardveru, stvarni servisi
- Faza 6 je dugoročna investicija — Ansible čini cijeli homelab reproducibilan jednom komandom

**Tvoj lab:**
- **Fedora KDE** — daily driver. Koristiš za čitanje, pisanje skripti, SSH prema EliteDesku, sve lokalno
- **HP EliteDesk 800 G4** — Ubuntu Server 24.04 LTS, fizički homelab server, treba biti uvijek upaljen
- **QEMU/KVM VM na Fedori** — za destruktivne eksperimente: GRUB kvarenje, disk operacije — nikad ne rizikuješ pravi server

---

## 🖥️ EliteDesk Server Setup Cheatsheet

> **Sedmica 0 — Uradi ovo prije nego počneš Fazu 1. Ovo je tvoj nulti korak.**

---

### Gdje čitati (redoslijed)

| Redoslijed | Gdje | Šta tražiš |
|-----------|------|-----------|
| 1. | **Ubuntu Server Guide → Installation** (ubuntu.com/server/docs/installation) | Instalacijski proces korak po korak, LVM layout |
| 2. | **ULSAH (Nemeth) — Ch. 1, 2** | Šta se radi na svježem serveru i zašto — filozofija prvog setup-a |
| 3. | **HLW (Ward) — Ch. 9** | Networking osnove — čitaj ovo **prije** nego konfiguriše statičku IP |
| 4. | **Ubuntu Server Guide → Security** (ubuntu.com/server/docs/security-introduction) | SSH hardening, ufw, AppArmor, fail2ban |
| 5. | **DigitalOcean: "Initial Server Setup with Ubuntu 24.04"** | Pretražuj tačan naslov — odličan praktičan vodič za post-install |
| 6. | **Ubuntu Server Guide → Networking** → Netplan | Netplan YAML sintaksa za statičku IP |

---

### Korak po korak: OS instalacija

**Priprema USB-a (na Fedori):**
```bash
# Provjeri device oznaku USB-a — pazi na oznaku (sda, sdb...)
lsblk

# Download Ubuntu Server 24.04 LTS
# https://ubuntu.com/download/server

# Napravi bootable USB (provjeri /dev/sdX dva puta — briše se sve!)
sudo dd if=ubuntu-server-24.04-live-server-amd64.iso \
    of=/dev/sdX bs=4M status=progress && sync
```
> Alternativa: **Balena Etcher** (GUI, besgrešno) — preporučeno ako prvi put.

---

**HP EliteDesk BIOS setup:**
- Pritisni **F10** pri pokretanju za BIOS Setup
- **Boot order**: USB first, zatim SSD
- **UEFI Boot**: ostavi enabled (ne prebacuj na Legacy)
- **Secure Boot**: Ubuntu 24.04 podržava — ostavi uključen
- **Wake-on-LAN**: **ENABLE** — možeš upaliti server remotely ako se ugasi po nestanku struje

---

**Tokom Ubuntu Server instalatora:**

*Storage layout (ručno, ne "Entire disk"):*
```
/dev/sdX (500 GB SSD)
├── /boot/efi    →  512 MB   (ESP, FAT32)
├── /boot        →  2 GB     (ext4)
└── LVM VG ubuntu-vg:
    ├── ubuntu-lv  →  100 GB   (ext4, mount: /)
    └── data-lv    →  ~380 GB  (ext4, mount: /data)
```
> Zašto ovako: `/data` je odvojen LV → možeš ga snapshotati, proširiti, pa čak i migrirati bez diranja OS-a.

*Ostale opcije:*
- **Hostname**: `elitedesk` (ili `homelab`, `srv01` — nešto kratko i opisno)
- **Korisnik**: tvoje ime, jaka lozinka (ovo je i sudo lozinka!)
- **OpenSSH server**: ✅ YES — obavezno uključi
- **Featured snaps**: ❌ NE — čistija instalacija, Docker ćeš instalirati ručno

---

### Korak po korak: Post-instalacija

> SSH sa Fedore čim se server podigne: `ssh <user>@<ip_adresa>`
> IP adresu nađi na serveru: `ip addr show` ili na ruteru

```bash
# ============================================
# KORAK 1: Update sistem
# ============================================
sudo apt update && sudo apt full-upgrade -y
sudo reboot

# ============================================
# KORAK 2: Essential alati
# ============================================
sudo apt install -y \
  vim curl wget git \
  htop btop iotop \
  tree net-tools nmap dnsutils \
  ufw fail2ban unattended-upgrades \
  lm-sensors intel-microcode \
  build-essential

# Provjeri temperaturu CPU-a (i5-8500T zna throttlati u mini kućištu)
sudo sensors-detect --auto
sensors

# ============================================
# KORAK 3: Statička IP (Netplan)
# ============================================
# Provjeri naziv mrežnog sučelja
ip link show
# Tipično na EliteDesku: eno1 ili enp0s31f6

sudo vim /etc/netplan/00-installer-config.yaml
```
```yaml
# /etc/netplan/00-installer-config.yaml
network:
  version: 2
  ethernets:
    enp0s31f6:              # zamijeni svojim sučeljem iz: ip link show
      dhcp4: no
      addresses:
        - 192.168.1.10/24   # statička IP — prilagodi svojoj mreži
      nameservers:
        addresses: [1.1.1.1, 8.8.8.8]
      routes:
        - to: default
          via: 192.168.1.1  # IP tvog rutera
```
```bash
sudo netplan try     # testira 120s — ako se ne potvrdi, vraća se samo
sudo netplan apply   # primijeni trajno

# ============================================
# KORAK 4: SSH hardening
# ============================================
# PRVO kopiraj SSH key sa Fedore (dok još radi password auth!):
# Na Fedori: ssh-copy-id -p 22 <user>@192.168.1.10

sudo vim /etc/ssh/sshd_config
```
```
# /etc/ssh/sshd_config — ključne promjene
Port 2222                        # promijeni sa 22 na custom port
PermitRootLogin no
PasswordAuthentication no        # ISKLJUČI tek NAKON što si kopirao SSH key!
AllowUsers <tvoj_username>
MaxAuthTries 3
ClientAliveInterval 300
ClientAliveCountMax 2
```
```bash
sudo systemctl restart ssh

# Provjeri sa novim portom (iz novog terminala — ne zatvori stari!)
ssh -p 2222 <user>@192.168.1.10

# ============================================
# KORAK 5: ufw firewall
# ============================================
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 2222/tcp       # tvoj SSH port
sudo ufw allow 80/tcp         # HTTP (za Nginx)
sudo ufw allow 443/tcp        # HTTPS
sudo ufw enable
sudo ufw status verbose

# ============================================
# KORAK 6: fail2ban
# ============================================
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo vim /etc/fail2ban/jail.local
```
```ini
# U sekciji [sshd]:
[sshd]
enabled  = true
port     = 2222
maxretry = 3
bantime  = 1h
findtime = 10m
```
```bash
sudo systemctl enable --now fail2ban
sudo fail2ban-client status sshd    # provjeri da radi

# ============================================
# KORAK 7: Automatic security updates
# ============================================
sudo dpkg-reconfigure --priority=low unattended-upgrades

# ============================================
# KORAK 8: Struktura /data direktorija
# ============================================
sudo mkdir -p /data/{docker,backups,configs,scripts,logs,www}
sudo chown -R <tvoj_user>:<tvoj_user> /data

# Inicijalizuj git repo za konfiguracije (Infrastructure as Code od dana 1!)
cd /data/configs
git init
echo "# EliteDesk Homelab Configs" > README.md
git add . && git commit -m "Initial commit"

# ============================================
# KORAK 9: Hostname na Fedori (udobnost)
# ============================================
# Na Fedori — dodaj u ~/.ssh/config:
# Host elitedesk
#   HostName 192.168.1.10
#   Port 2222
#   User <tvoj_user>
#   IdentityFile ~/.ssh/id_ed25519
# 
# Zatim: ssh elitedesk  (umjesto pune komande)
```

---

### ✅ Server Setup Best Practices

| Pravilo | Zašto je to pravilo |
|---------|---------------------|
| Nikad direktno kao `root` — uvijek `sudo` | Accidental damage prevention; svaka `sudo` akcija ide u audit log |
| SSH keys ONLY, password auth isključen | Brute-force napad postaje praktično nemoguć |
| ufw uvijek aktivan, minimum otvorenih portova | Attack surface reduction — svaki zatvoreni port je jedna manje potencijalna ranjivost |
| Statička IP na serveru | SSH target se ne mijenja; port forwarding na ruteru radi pouzdano |
| Wake-on-LAN konfigurisan | Graceful power management — server se može upaliti remotely |
| `/data/` za sve servise, ne `/home/` | Jasna separacija OS-a od podataka; olakšava backup, restore, migraciju |
| `/data/configs/` u git repozitorij | Svaka promjena konfiguracije je commit — imaš historiju i rollback |
| `lm-sensors` monitoring | i5-8500T u mini kućištu zna throttlati — znaj temperatura servera |
| Documentiraj sve u README | Buduće ti-ja će ti biti zahvalan kad zaboraviš zašto si nešto uradio |
| Provjeri `journalctl -xe` i `ufw status` dopo svake veće promjene | Greška u konfiguraciji se vidi odmah, ne tek kad nešto pukne u 3 ujutro |

---

## 🗺️ Roadmap — 6 Faza

---

### FAZA 1: Kernel, Boot & Procesi (Sedmica 1–2)
> "Razumijem šta se dešava od pritiska tipke power do login prompta"

**Čitaj:** How Linux Works — Ch. 1, 2, 3, 5, 6

**Koncepti za savladati:**
- [ ] Kernel space vs user space — šta kernel zapravo radi i šta ne radi
- [ ] System calls — kako programi komuniciraju sa kernelom (`read()`, `write()`, `fork()`, `exec()`)
- [ ] Boot proces: UEFI → GRUB → kernel → initrd → systemd init
- [ ] systemd duboko: units, targets, dependencies, journald
- [ ] Procesi: `fork()`, `exec()`, PID, PPID, zombie procesi, orphan procesi
- [ ] Signals: SIGTERM, SIGKILL, SIGHUP, SIGINT — šta koji radi i kada koristiti koji
- [ ] `/proc` filesystem — kernel-exposed informacije o procesima i sistemu u real-time
- [ ] Nice values, scheduling prioriteti, CPU affinity

**Hands-on zadaci (SSH na EliteDesk sa Fedore):**
- [ ] `systemd-analyze blame` i `systemd-analyze critical-chain graphical.target` → vidi koje servise usporavaju boot; nacrtaj dependency stablo na papiru — vizualizuj boot red svog servera
- [ ] Napravi custom systemd service koji se pokreće pri bootu: upisuje `hostname`, `uptime` i `date` u `/data/logs/boot.log` — provjeri `journalctl -u tvoj-servis`
- [ ] Napravi systemd timer koji svakih 2 sata loguje `free -h` i `df -h` u `/data/logs/syshealth.log` — provjeri `systemctl list-timers`
- [ ] `strace ls` → analiziraj system calls, pronađi `openat()`, `read()`, `write()`, `close()` — razumij šta `ls` zapravo radi na kernel nivou
- [ ] Napiši C++ program koji ispisuje vlastiti PID, kompajliraj direktno na serveru (`g++`), pa čitaj `/proc/<PID>/maps` i `/proc/<PID>/status` — vidiš memory layout procesa

---

### FAZA 2: Filesystem, Storage & Permissions (Sedmica 3–4)
> "Razumijem kako Linux čuva podatke i ko im smije pristupiti"

**Čitaj:** How Linux Works — Ch. 4, 8, 11

**Koncepti za savladati:**
- [ ] Filesystem hijerarhija: `/`, `/etc`, `/var`, `/tmp`, `/opt`, `/usr`, `/home`, `/data` — zašto je svaki direktorij baš tu
- [ ] Inodes, hard links, soft links — šta se dešava na nivou diska
- [ ] **ext4** — Ubuntu Server default: journal, extent-based storage, šta se dešava pri crash-u
- [ ] **LVM na EliteDesku**: ti ga već imaš od instalacije! Physical Volumes (PV), Volume Groups (VG), Logical Volumes (LV) — nauči njime upravljati, proširiti, snapshotati
- [ ] LVM snapshot — kopija LV-a u trenutku vremena: kako radi (COW), kreiranje, restore
- [ ] ZFS na Ubuntuu — teorija i `zfsutils-linux`: Copy-on-Write, checksums, snapshots, scrub (opciono, vrijedi znati za budućnost)
- [ ] RAID koncepti (0, 1, 5, 10) — teorija za eventualno proširenje homelab-a vanjskim diskom
- [ ] `mount`, `umount`, `/etc/fstab`, `systemd.mount` automount jedinice
- [ ] Permissions duboko: `rwx`, SUID, SGID, Sticky bit — zašto svaki postoji
- [ ] ACLs: `getfacl`, `setfacl` — fine-grained kontrola pristupa izvan standardnih rwx
- [ ] **AppArmor na Ubuntuu**: enforcing vs complain mode, profili, `aa-status`, `aa-logprof`, `apparmor_parser` — Ubuntu je AppArmor (ne SELinux!)

**Hands-on zadaci (na EliteDesku):**
- [ ] LVM live expand: proširi `data-lv` sa `lvextend -L +20G` + `resize2fs` — **bez rebootanja**, provjeri odmah sa `df -h /data`
- [ ] LVM snapshot `/data` LV-a: kreiraj snapshot, modificiraj fajl u `/data/`, vrati se iz snapshota — ovo je tvoja osnovna backup tehnika za cijelo poglavlje Faze 4
- [ ] AppArmor lab: instaliraj Nginx, premjesti web root u `/data/www/` → Nginx odbija sa 403 → dijagnosticiraj sa `sudo dmesg | grep DENIED` i `sudo aa-logprof` → popravi profil → provjeri da radi
- [ ] ACL na `/data/backups/`: postavi da `backup` user može pisati, ali `www-data` samo čitati — provjeri i dokumentiraj sa `getfacl`
- [ ] SGID na `/data/shared/`: postavi SGID bit, kreiraj fajl kao drugi user, provjeri da grupni ownership ostaje konzistentan — razumij zašto je to korisno za dijeljene direktorije

---

### FAZA 3: Networking (Sedmica 5–7)
> "Razumijem mrežu od NIC-a do aplikacije, mogu konfigurisati i troubleshootati"

**Čitaj:** How Linux Works — Ch. 9, 10 | UNIX & Linux SA Handbook — Ch. 13, 14, 15

**Koncepti za savladati:**
- [ ] TCP/IP stack: Link → Network → Transport → Application — šta se dešava na svakom nivou paket po paket
- [ ] IP adresiranje, subnetting, CIDR notacija — izračunaj ručno bez kalkulatora
- [ ] DNS duboko: A, AAAA, CNAME, MX, NS, SOA, PTR zapisi; `dig`, `nslookup`, `resolvectl status`
- [ ] DHCP DORA proces: Discover, Offer, Request, Acknowledge
- [ ] **Netplan** — Ubuntu Server pristup za mrežnu konfiguraciju (ne NetworkManager za server!): YAML sintaksa, `netplan try`, `netplan apply`
- [ ] Routing tabele, default gateway, `ip route`, `ip addr`, `ip link`
- [ ] **ufw** — Ubuntu-native firewall frontend: rules, application profiles, logging, `ufw status numbered`
- [ ] **nftables** — šta `ufw` zapravo koristi ispod; `nft list ruleset` — razumij output
- [ ] SSH duboko: key-based auth, `~/.ssh/config`, local/remote/dynamic port forwarding, ProxyJump, `sshd_config` hardening
- [ ] **WireGuard VPN** — moderni VPN ugrađen direktno u Linux kernel (od 5.6): peers, public/private keys, `AllowedIPs`, `wg show` — omogućava ti siguran remote pristup EliteDesku izvana kućne mreže
- [ ] `ss`, `lsof -i` za aktivne konekcije i koji proces drži koji port
- [ ] Wireshark / `tcpdump` za analizu paketa na žici

**Hands-on zadaci:**
- [ ] Netplan: potvrdi statičku IP konfiguraciju sa EliteDeska — `ip addr`, `ping -c 3 1.1.1.1`, `dig google.com` — sve treba raditi
- [ ] SSH hardening revisit: provjeri da je sve iz Cheatsheet-a implementirano (`sshd_config` audit), testiraj sa `ssh -v elitedesk` sa Fedore i analiziraj output
- [ ] SSH tunel: proslijedi port 5432 (PostgreSQL) sa EliteDeska na lokalni port Fedore: `ssh -L 5432:localhost:5432 elitedesk` → provjeri da se možeš konektovati na PostgreSQL sa Fedore bez direktnog otvaranja porta na firewalls
- [ ] **WireGuard VPN setup**: instaliraj WireGuard na EliteDesku (`apt install wireguard`), konfiguriši Fedoru kao peer — provjeri da se možeš SSHati na EliteDesk kroz VPN tunel, ne direktnim lokalnim IP-om. Ovo ti otvara homelab sa bilo gdje.
- [ ] ufw audit: provjeri `ufw status verbose` — svaki otvoreni port treba imati razlog. Dodaj logging (`ufw logging on`), provjeri `/var/log/ufw.log`
- [ ] `tcpdump -i any port 80 -w /tmp/capture.pcap` na EliteDesku + otvori u Wiresharku na Fedori → vizualizuj TCP handshake (SYN, SYN-ACK, ACK), vidi HTTP request/response
- [ ] `dig +trace google.com` → prati DNS resolution od root servera do konačnog A recorda, korak po korak — razumij svaki skok

**📌 Mini projekat za portfolio:**
> **"EliteDesk Network Documentation & Hardening"**
>
> Dokumentiraj kućnu mrežu: topologiju (ASCII art ili Mermaid dijagram), IP mapa svih uređaja, otvoreni portovi i zašto svaki.
> `ufw` konfiguracija sa komentarima, `fail2ban` sa prilagođenim pravilima, WireGuard konfiguracija.
> **Markdown na GitHub-u.** Ovo je realan sysadmin zadatak koji se vidi u CV-u.

---

### FAZA 4: Shell Scripting & Automation (Sedmica 8–10)
> "Ako to radiš više od jednom, skripta to radi umjesto tebe"

**Čitaj:** UNIX & Linux SA Handbook — Ch. 7, 8 | The Linux Command Line (Shotts) — Ch. 24–32

**Koncepti za savladati:**
- [ ] Bash: varijable, uslovi (`if`, `case`), petlje (`for`, `while`, `until`), funkcije, exit codes
- [ ] Regularni izrazi: `grep -E`, `sed`, `awk` — text processing pipeline
- [ ] Klasični pipeline: `cat | grep | awk | sed | sort | uniq | wc`
- [ ] Bash arrays, associative arrays, string manipulation (`${#var}`, `${var:offset}`, `${var/old/new}`)
- [ ] Error handling: `set -euo pipefail`, `trap` za cleanup pri izlasku — ovo je razlika između amateur i production skripti
- [ ] `cron` vs systemd timers — na Ubuntuu oboje rade; preferuj systemd timers (bolje logovanje, dependency management)
- [ ] Process substitution `<(...)`, command substitution `$(...)`, here documents `<<EOF`
- [ ] `xargs`, `find -exec`, GNU `parallel` za paralelne operacije
- [ ] `jq` za JSON processing — Docker logovi su JSON, sistemski alati sve više vraćaju JSON

**Hands-on zadaci (skripte u `/data/scripts/` — git repo od prvog dana):**
- [ ] `disk-alert.sh`: monitorira `/data` LV i sve mountane particije, loguje upozorenje u `/data/logs/disk-alerts.log` kad pređe 80% — pokreće se systemd timerom svakih 30 minuta
- [ ] `ssh-report.sh`: parsira `journalctl -u ssh --since "24 hours ago"`, pravi izvještaj o failed loginima — IP adresa, broj pokušaja, geografska lokacija (`whois`), sortirano silazno — output u `/data/logs/ssh-report-<datum>.html`
- [ ] `lvm-snapshot.sh`: automatski LVM snapshot `/data` LV-a, imenuje po datumu (`data-snap-2025-06-15`), rotira: čuvaj zadnjih 5 snapshota, briši starije — systemd timer svake noći u 02:00
- [ ] `awk-analyzer.sh`: parsira `df -h` output i `free -h` output, računa mean/min/max i ispisuje summary tablicu — vježba awk aritmetike i formatiranja

**📌 Projekat za portfolio:**
> **"EliteDesk Health Monitor" — Bash toolkit**
>
> 6 Bash skripti koje monitoriraju tvoj server:
> - `cpu-health.sh` — load average, temperature (`sensors`), throttling detekcija
> - `ram-health.sh` — usage, swap, pressure events iz `/proc/meminfo`
> - `disk-health.sh` — usage po LV-u, inode usage, SMART status (`smartctl`)
> - `net-health.sh` — throughput, otvoreni portovi, aktivne konekcije
> - `auth-health.sh` — failed SSH logini, fail2ban banned IP-ovi
> - `services-health.sh` — status svih kritičnih Docker i systemd servisa
>
> Jedna master skripta `health-monitor.sh` ih sve pokreće i generiše statični HTML izvještaj koji Nginx servira na `http://elitedesk/health`.
> Pokreće se systemd timerom svakih sat vremena.
> **GitHub repo sa README-jem i screenshot outputa. Ovo je portfolio materijal.**

---

### FAZA 5: Server Administration & Services (Sedmica 11–14)
> "Mogu pokrenuti i održavati produkcijski server — i imam vlastiti homelab koji radi pravi posao"

**Čitaj:** UNIX & Linux SA Handbook — Ch. 5, 9, 10, 19, 20, 22

**Koncepti za savladati:**
- [ ] User & group management: `/etc/passwd`, `/etc/shadow`, `/etc/group`, PAM — kreiranje dedicated service usera (svaki servis treba vlastiti non-root user!)
- [ ] `sudo` konfiguracija: `sudoers` fajl, `NOPASSWD` za automatizovane skripte, command-level restrictions
- [ ] Package management: `apt` duboko, `dpkg` internali, PPA repozitoriji, GPG key verifikacija, `apt-mark hold` za piniranje verzije
- [ ] Logovi na Ubuntuu: `journalctl` napredne opcije (`--since`, `--until`, `-u`, `-f`, `--output=json`), `rsyslog`, `logrotate` — svaki servis piše negdje, znaj gdje
- [ ] **Nginx**: `server` blokovi, `location` direktive, reverse proxy (`proxy_pass`), upstream, load balancing koncepti, `access_log` i `error_log`
- [ ] **SSL/TLS sa Certbot** (Let's Encrypt) za javni domain, ili self-signed za lokalnu mrežu: `openssl req -x509`
- [ ] **PostgreSQL na Ubuntuu**: `pg_hba.conf`, `postgresql.conf`, remote pristup, `pg_dump` / `pg_restore`, `pg_basebackup`, role management
- [ ] **Docker na Ubuntuu**: `docker run`, `docker compose` (v2, bez crtice), Dockerfile, multi-stage build, volumes, networks, `docker logs`, `docker exec`
- [ ] Docker networking duboko: bridge, host, custom networks — kako kontejneri komuniciraju međusobno i s vanjskim svijetom
- [ ] **systemd + Docker**: Docker service kao systemd unit, `Restart=always`, dependency između servisa, `docker compose` kao systemd service
- [ ] **Portainer** (opciono) — web GUI za Docker management: vizualni pregled svih kontejnera, logova, networka

**Hands-on zadaci (sve na EliteDesku, sve u `/data/docker/` sa `docker-compose.yml` fajlovima):**
- [ ] Instaliraj PostgreSQL (`apt install postgresql`): konfiguriši `pg_hba.conf` za remote pristup samo sa IP-a Fedore → provjeri konekciju `psql -h elitedesk -U postgres`; `pg_dump` backup u `/data/backups/`
- [ ] Nginx reverse proxy: konfiguriši da `http://elitedesk/monitor` prosljeđuje na Health Monitor HTML iz Faze 4 (Nginx servira `/data/www/`) — provjeri `curl -I http://elitedesk/monitor`
- [ ] SSL self-signed certifikat: `openssl req -x509 -nodes -days 365` → konfiguriši HTTPS na Nginxu → analiziraj TLS handshake sa `openssl s_client -connect elitedesk:443 -showcerts`
- [ ] **Pi-hole u Dockeru**: `docker compose up` → konfiguriši ruter da koristi `192.168.1.10` kao primarni DNS → provjeri da se ads blokiraju u browseru na Fedori; provjeri query log u Pi-hole admin panelu
- [ ] **Gitea u Dockeru**: self-hosted Git server na portu 3000 → Nginx reverse proxy na `http://elitedesk/git` → push postojeći repo sa Fedore na Gitea → kloniraj sa Fedore. Od sada sve skripte i konfiguracije idu na Gitea!
- [ ] **Grafana + Prometheus + node_exporter**: `docker compose` stack → Prometheus scrape `node_exporter` na EliteDesku → Grafana dashboard koji prikazuje CPU, RAM, disk, mrežu u real-time

**📌 VELIKI projekat za portfolio (LinkedIn materijal):**
> **"EliteDesk Homelab Stack — Produkcijski Docker Setup"**
>
> Na EliteDesku podigni kompletni homelab stack, sve orchestrirano sa `docker compose`:
> - **Nginx** — reverse proxy za sve servise, HTTPS sa self-signed certifikatom
> - **PostgreSQL** — centralna baza, redovni `pg_dump` backup u `/data/backups/`
> - **Pi-hole** — DNS server i ad blocker za cijelu kućnu mrežu
> - **Gitea** — self-hosted Git: gurni sve projekte iz roadmapa tamo
> - **Prometheus + Grafana** — monitoring servera u real-time s dashboardom
> - **WireGuard** — remote pristup homelabu kad nisi kod kuće
> - **Health Monitor** iz Faze 4 — HTML report koji Nginx servira
>
> Sve definisano u `docker-compose.yml` po servisu. Sve konfigurisano u `/data/configs/` → Gitea repo.
> Dokumentacija: Mermaid arhitektura dijagram, port mapa svih servisa, setup instrukcije, security mjere.
>
> **Gitea + GitHub (javni) repo + LinkedIn post sa screenshotom Grafana dashboarda.**
> **Ovo je tvoj najveći portfolio artefakt ove ljeto.**

---

### FAZA 6: Advanced Troubleshooting & Automation (Sedmica 15–18)
> "Mogu dijagnosticirati kompleksne probleme i reproductibilno automatizirati infrastrukturu"

**Čitaj:** How Linux Works — Ch. 7, 12 | UNIX & Linux SA Handbook — Ch. 28, 29

**Koncepti za savladati:**
- [ ] Performance analysis alati: `top`, `htop`, `btop`, `vmstat`, `iostat`, `sar`, `perf` — svaki za svoju svrhu
- [ ] Memory management na Ubuntuu: virtual memory, swap, **zram** (Ubuntu 22.04+ default — komprimovani RAM kao swap), OOM killer, memory pressure
- [ ] I/O scheduling, disk performance, `iotop`, `blktrace` — posebno relevantno za 500 GB SSD gdje IOPS je bitna metrika
- [ ] Kernel tuning za server: `sysctl` parametri — `vm.swappiness` (treba biti nizak za SSD!), `net.core.somaxconn`, `fs.file-max`, `net.ipv4.tcp_*` za server workload
- [ ] Kernel moduli: `lsmod`, `modprobe`, `modinfo`, blacklisting — razumij šta je već učitano na EliteDesku
- [ ] Troubleshooting metodologija: **USE method** (Utilization, Saturation, Errors) — sistematičan, reproducibilan pristup dijagnostici
- [ ] Disaster recovery: rescue mode, `chroot` u sistem sa live USB-a, GRUB repair
- [ ] **Ansible osnove**: inventory, playbooks, modules (`apt`, `copy`, `template`, `service`, `user`, `docker_compose`), roles, variables, handlers, idempotency — Infrastructure as Code

**Hands-on zadaci:**
- [ ] Memory pressure simulacija: C++ program koji alocira memoriju u petlji u GB-ima → prati sa `vmstat 1` i `watch -n1 free -h` → OOM killer ubija proces → provjeri sa `dmesg | grep -i "oom\|killed"` — vidiš kernel u akciji
- [ ] PostgreSQL I/O profiling: `iostat -x 1` i `perf stat -e cache-misses` dok pokreće heavy query (`EXPLAIN ANALYZE` na veliku tablicu) → identificiraj je li bottleneck CPU (cache misses) ili I/O (await ms na SSD-u)
- [ ] `sysctl` tuning za EliteDesk: postavi `vm.swappiness=10` (SSD je brz, ne treba agresivno swappanje), povećaj `fs.file-max` za Docker kontejnere — dokumentiraj u `/etc/sysctl.d/99-homelab.conf` i git commit
- [ ] **Ansible playbook** `homelab.yml` koji na čistom Ubuntu 24.04 reproductibilno postavi cijeli Faza 5 stack jednom komandom: `ansible-playbook -i inventory.yml homelab.yml`. Ovo je tvoja disaster recovery procedura.
- [ ] QEMU/KVM VM na Fedori: namjerno pokvari GRUB konfiguraciju (edituj `/boot/grub/grub.cfg`) → popravi iz rescue moda koristeći live USB i `chroot` — jednog dana ćeš ovo morati znati na pravom serveru u ponoć

**📌 Projekat za portfolio:**
> **"Ansible Playbook za EliteDesk Homelab"**
>
> Pretvori cijeli Faza 5 deployment u idempotent Ansible playbook. Svaki put kad pokreneš `ansible-playbook homelab.yml`:
> - Instalira sve pakete (apt, Docker)
> - Konfiguriše Netplan (statička IP), SSH hardening, ufw, fail2ban
> - Deploya Docker Compose stack (Pi-hole, Gitea, Prometheus, Grafana, Nginx)
> - Konfiguriše systemd timere (LVM snapshoti, health monitor)
> - Sve je idempotentno — može se pokrenuti više puta bez nuspojava
>
> Na čistom Ubuntu 24.04: `ansible-playbook homelab.yml` → za 10–15 minuta imaš cijeli homelab.
>
> **Gitea + GitHub repo + LinkedIn post. Ovo je Infrastructure as Code u portfoliu.**

---

## 🗓️ Pregled timeline-a

| Sedmica | Faza | Fokus | Knjiga / Dokumentacija |
|---------|------|-------|----------------------|
| **0** | **Setup** | **EliteDesk Server Setup Cheatsheet** | Ubuntu Server Guide + ULSAH Ch. 1–2 |
| 1–2 | Faza 1 | Kernel, Boot, Procesi | HLW Ch. 1–3, 5–6 |
| 3–4 | Faza 2 | Filesystem, LVM, AppArmor | HLW Ch. 4, 8, 11 |
| 5–7 | Faza 3 | Networking, WireGuard + mini projekat | HLW Ch. 9–10 + ULSAH Ch. 13–15 |
| 8–10 | Faza 4 | Shell Scripting + Health Monitor toolkit | ULSAH Ch. 7–8 + TLCL Ch. 24–32 |
| 11–14 | Faza 5 | Server Admin + Homelab Stack deploy | ULSAH Ch. 5, 9–10, 19–22 |
| 15–18 | Faza 6 | Troubleshooting + Ansible IaC | HLW Ch. 7, 12 + ULSAH Ch. 28–29 |

---

## 📝 Pravila za sebe

1. **How Linux Works čitaj od korice do korice** — preskači samo stvari koje doista već znaš
2. **UNIX & Linux SA Handbook je referenca** — čitaj samo poglavlja navedena uz svaku fazu
3. **Ubuntu Server Guide je operativni vodič** — otvori odgovarajuću sekciju za svaki servis koji postavljaš
4. **EliteDesk je uvijek upaljen** — server koji ne radi 24/7 nije server; postavi Wake-on-LAN kao backup plan
5. **Sve konfiguracije u git od dana 1** — `/data/configs/` je git repo; `git commit` nakon svake netrivijalne promjene
6. **Za destruktivne operacije** (GRUB kvarenje, disk particionisanje): QEMU/KVM VM na Fedori, **nikad** na EliteDesku
7. **Ubuntu Docs i Arch Wiki su tvoj prvi Google rezultat** — tek onda DigitalOcean, tek onda Stack Overflow
8. **Svaki projekat najpre na Gitea** (tvoj self-hosted!), zatim mirror na GitHub (javni portfolio)
9. **Ne kupuj kurseve** — imaš tri knjige, man pages, Ubuntu Server Guide, Arch Wiki. Dovoljno je.
10. **EliteDesk je tvoj produkcijski lab** — kad nešto radi na pravom hardveru 24/7, znaš da to zaista znaš

---

## 🔭 Bonus: Servisi za self-hosting na EliteDesku (post-Faza 5)

> Kada završiš Fazu 5, imaš znanje da postaviš sve s ove liste.
> 16 GB RAM i i5-8500T mogu podržati sve od ovog odjednom.

| Servis | Šta je | Zašto je zanimljivo |
|--------|--------|---------------------|
| **Nextcloud** | Self-hosted Google Drive / Photos | Privatnost, korisno svakodnevno — sync fajlova s mobitela |
| **Jellyfin** | Self-hosted Netflix/Plex | Media streaming s EliteDeska na TV ili mobitel |
| **Vaultwarden** | Self-hosted Bitwarden password manager | Potpuna kontrola nad svim lozinkama |
| **Uptime Kuma** | Self-hosted uptime monitor | Notifikacija kad ti homelab servisi padnu |
| **Homer / Homarr** | Dashboard za sve homelab servise | Jedan URL → vizualni pregled svih servisa |
| **Traefik** | Naprednija zamjena za Nginx reverse proxy | Automatski Let's Encrypt, Docker label routing |
| **n8n** | Self-hosted workflow automation (Zapier-like) | Automatizacija svega: obavještenja, backupi, integrace |
| **Forgejo** | Alternativa Gitea (Gitea fork, aktivniji razvoj) | Self-hosted Git ako odlučiš preći s Gitea |

---

*Legenda kratica: HLW = How Linux Works (Ward) | ULSAH = UNIX & Linux SA Handbook (Nemeth) | TLCL = The Linux Command Line (Shotts)*
