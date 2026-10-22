#!/usr/bin/env bash
set -euo pipefail
BACKUP_DIR="${HOME}/.config/macos-desktop-plasma/backups"
TS="${1:-}"
if [ -z "$TS" ]; then
    # pick latest
    latest=$(ls -1 "$BACKUP_DIR" 2>/dev/null | sed -E 's/.*\.([0-9]{8}-[0-9]{6})$/\1/' | sort | tail -1)
    TS="$latest"
fi
if [ -z "$TS" ]; then
    echo "No backups found." >&2
    exit 1
fi
for base in kglobalshortcutsrc kwinrc; do
    src="$BACKUP_DIR/${base}.${TS}"
    if [ -f "$src" ]; then
        cp -a "$src" "${HOME}/.config/${base}"
        echo "Restored ${base} from ${TS}"
    fi
done
