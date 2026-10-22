#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PREFIX="${HOME}/.local"

mkdir -p "${HOME}/.config/macos-desktop-plasma/backups"

cmake -S "$ROOT" -B "$ROOT/build" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$PREFIX"
cmake --build "$ROOT/build" -j"$(nproc)"
cmake --install "$ROOT/build"

echo "Installed to $PREFIX. Restart plasmashell:"
echo "  systemctl --user restart plasma-plasmashell.service"
