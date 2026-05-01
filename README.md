# openclaw-vps-autoconfig

Bootstrap and configuration scripts for a disposable VPS setup, intended for running OpenClaw and related services.

---

## Overview

This repo defines the **baseline configuration** for a fresh VPS, with a focus on repeatability and minimal manual intervention.

### Goals

* Rebuild from scratch in minutes
* Avoid manual configuration drift
* Keep infrastructure simple and reproducible
* Prefer ephemeral / disposable servers
* Separate base system setup from application setup

---

## Usage

### 1. Provision VPS

* Create a new VPS (e.g. Contabo)
* Choose a standard Linux image (Ubuntu recommended)

---

### 2. Connect via SSH

```bash
ssh user@YOUR_IP
```

---

### 3. Run bootstrap

```bash
sudo apt update && sudo apt install -y git
git clone https://github.com/YOUR_USERNAME/openclaw-vps-autoconfig.git
cd openclaw-vps-autoconfig
sudo bash bootstrap.sh
```

During bootstrap you may be prompted for:

* ZeroTier Network ID (optional)

---

### 4. Reboot (if required)

```bash
sudo reboot
```

---

## Structure

```
.
├── bootstrap.sh              # Base system setup (packages, firewall, ZeroTier)
├── scripts/
│   ├── install-docker.sh     # Docker installation
│   ├── install-openclaw.sh   # OpenClaw setup (stage 2)
│   └── harden-ssh.sh         # Optional SSH hardening
├── compose/                  # Docker compose files
├── .env.example              # Environment template
└── README.md
```

---

## Setup Stages

### Stage 1 — Bootstrap

Handled by `bootstrap.sh`:

* System update/upgrade
* Base package install (`curl`, `git`, `ufw`, `fail2ban`)
* Firewall configuration
* ZeroTier install and optional network join

This stage prepares a **secure, minimal, network-ready host**.

---

### Stage 2 — Services (separate scripts)

Handled by scripts in `/scripts`:

* Docker installation
* OpenClaw deployment
* Optional reverse proxy / additional services

This separation allows:

* changing app stack without touching base config
* easier rebuilds and experimentation

---

## Networking

* Primary access via ZeroTier private network
* Public exposure should be avoided where possible
* Default open ports:

  * `22/tcp` (SSH)
  * `9993/udp` (ZeroTier)

Future option:

* Restrict SSH to ZeroTier only

---

## Security Notes

* Change passwords immediately after bootstrap
* Consider SSH key authentication (optional but recommended)
* Keep exposed ports to a minimum
* Prefer private network access over public endpoints

---

## Design Principles

* **Disposable first**
  Servers should be treated as replaceable

* **Scripted over manual**
  No SSH tinkering — everything goes into scripts

* **Minimal exposure**
  Only required ports/services are enabled

* **Layered setup**

  * Bootstrap = OS + base tools
  * Scripts = services + applications

---

## Future Work

* Docker Compose–based OpenClaw deployment
* Reverse proxy (Caddy / Nginx)
* ZeroTier-only service exposure model
* Automated rebuild workflow
* Optional SSH hardening script

---

## Notes

This setup is intentionally simple. Complexity should only be added when it provides clear value.

---
