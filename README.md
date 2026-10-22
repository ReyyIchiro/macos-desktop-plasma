# macOS Desktop Experience for KDE Plasma (Wayland)

A KDE Plasma 6 containment that lets desktop icons be placed freely (no grid snapping), plus a macOS-style profile for KDE settings.

## Install

```bash
./install.sh
systemctl --user restart plasma-plasmashell.service
```

Add "macOS Desktop" containment to your desktop via widget picker.

## Revert profile

```bash
./scripts/revert-macos-profile.sh
```

## License

GPL-3.0-or-later (inherited from KDE desktopcontainment).
