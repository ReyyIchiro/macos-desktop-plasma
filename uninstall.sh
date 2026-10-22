#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$ROOT/build/install_manifest.txt" ]; then
    while IFS= read -r f; do rm -f "$f"; done < "$ROOT/build/install_manifest.txt"
    echo "Uninstalled using manifest."
else
    rm -rf "${HOME}/.local/share/plasma/plasmoids/org.kde.plasma.macosdesktop"
    echo "Removed plasmoid directory."
fi
