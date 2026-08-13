# LinuxDump

> Dump svega neosjetljivog što nastane dok prolazim [Linux Mastery Roadmap](./roadmap.md) na svom homelabu (HP EliteDesk 800 G4 Mini, Ubuntu Server 24.04).

## Šta je zapravo ovo?

Mjesto na kojem će biti izložene skripte, timeri, servisi, bilješke i sve ostalo što bi dobro bilo da se sačuva kao artefakt iz procesa učenja 

--- 

## Progres

| Faza | Status |
|------|--------|
| 1 — Kernel, Boot & Procesi |  Završeno |
| 2 — Filesystem, Storage & Permissions |  U toku (koncept 4/11 — LVM) |
| 3 — Networking |  |
| 4 — Shell Scripting & Automation |  |
| 5 — Server Administration & Services |  |
| 6 — Troubleshooting & Automation |  |

---
---

## Strukturaa (Guide)

```
LinuxDump/
├── README.md
├── .gitignore
├── roadmap.md                          # kopija roadmapa, checkboxevi = progress tracker
│
├── faza-01-kernel-boot-procesi/
│   ├── README.md                       # kratak recap: šta je bilo teško, "aha" momenti
│   ├── diagrams/
│   │   ├── boot-critical-chain.svg     # systemd-analyze plot
│   │   └── EXTRACTION.md               # tačna komanda kojom je izvađen
│   ├── systemd/
│   │   ├── boot-log.service
│   │   ├── syshealth.service
│   │   └── syshealth.timer
│   └── notes/
│       └── strace-ls-analysis.md
│
├── faza-02-filesystem-storage-permissions/
│   ├── README.md
│   ├── configs/
│   │   └── fstab.example               # sanitizovan
│   ├── diagrams/
│   │   ├── lvm-layout.svg
│   │   └── EXTRACTION.md
│   └── notes/
│       └── lvm-snapshot-workflow.md
│
├── faza-03-networking/                 # dodaješ kad stigneš
├── faza-04-shell-scripting/
│   └── scripts/
│       ├── disk-alert.sh
│       ├── lvm-snapshot.sh
│       └── awk-analyzer.sh
├── faza-05-server-administration/
├── faza-06-troubleshooting-automation/
└── HomeLab

---

##  Reference

Kompletan roadmap: [`roadmap.md`](./roadmap.md)
Knjige: *How Linux Works* (Ward) · *UNIX & Linux SA Handbook* (Nemeth) · *The Linux Command Line* (Shotts)
```
