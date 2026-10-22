#!/usr/bin/env bash
set -euo pipefail
# Randomize freePositions for current screen resolution using python
python3 - "$@" <<'PY'
import json, random, os, sys
cfg=os.path.expanduser("~/.config/plasmashellrc")
# We operate on plasmoid config? freePositions stored in appletsrc? Actually in containment config.
# This script prints a sample JSON; user applies manually.
print("scatter helper: implement per-install screen size; see docs.")
PY
