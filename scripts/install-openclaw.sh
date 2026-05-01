#!/usr/bin/env bash
set -euo pipefail

OPENCLAW_DIR="/opt/openclaw"

echo "== Installing OpenClaw via official Docker setup =="

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is not installed. Run scripts/install-docker.sh first."
  exit 1
fi

if [[ ! -d "$OPENCLAW_DIR/.git" ]]; then
  git clone https://github.com/openclaw/openclaw.git "$OPENCLAW_DIR"
else
  git -C "$OPENCLAW_DIR" pull
fi

cd "$OPENCLAW_DIR"

echo "== Running OpenClaw Docker setup =="
./scripts/docker/setup.sh

echo ""
echo "== OpenClaw setup complete =="
echo "Dashboard should be available from the VPS itself at:"
echo "  http://127.0.0.1:18789/"
echo ""
echo "For remote access, prefer ZeroTier or a locked-down reverse proxy."