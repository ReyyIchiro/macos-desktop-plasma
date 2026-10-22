#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="${HOME}/.config/macos-desktop-plasma/backups"
TS="$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

backup() {
    local f="$1"
    if [ -f "$f" ]; then
        cp -a "$f" "$BACKUP_DIR/$(basename "$f").$TS"
    fi
}

backup "${HOME}/.config/kglobalshortcutsrc"
backup "${HOME}/.config/kwinrc"

# Spotlight: KRunner Meta+Space
kwriteconfig6 --file kglobalshortcutsrc --group krunner --key _launch "Meta+Space,Meta+Space,Launch KRunner"

# Mission Control / Overview
kwriteconfig6 --file kglobalshortcutsrc --group kwin --key ShowDesktop "Meta+D,Meta+D,Show Desktop"
kwriteconfig6 --file kwinrc --group ModifierOnlyShortcuts --key Meta "org.kde.kglobalaccel,/component/kwin,org.kde.kwin,showOverview"

# Hot corners
kwriteconfig6 --file kwinrc --group ElectricBorders --key BottomRight "ShowDesktop"
kwriteconfig6 --file kwinrc --group ElectricBorders --key TopRight "ShowOverview"

# Dock: normalize icontasks zoom (best-effort)
for cfg in "${HOME}/.config/plasma-org.kde.plasma.desktop-appletsrc" "${HOME}/.config/plasmashellrc"; do
    [ -f "$cfg" ] || continue
done

echo "Applied macOS profile. Backup: $BACKUP_DIR (*.$TS)."
echo "Log out/in or restart plasmashell for effect."
