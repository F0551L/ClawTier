#!/usr/bin/env bash
set -euo pipefail

if command -v docker >/dev/null 2>&1; then
  echo "Docker already installed"
  exit 0
fi

echo "== Installing Docker =="
curl -fsSL https://get.docker.com | sh

echo "== Enabling Docker =="
systemctl enable --now docker

echo "== Docker version =="
docker --version
docker compose version