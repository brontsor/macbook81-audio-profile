#!/bin/bash
# Install the MacBook8,1 speaker names and EQ chain for the invoking user.
# Does not touch the kernel driver. Does not restart PipeWire.
set -euo pipefail

if [[ "$(id -u)" -eq 0 ]]; then
  echo "run as the desktop user, not root: bash $0" >&2
  exit 1
fi

ROOT="$(cd "$(dirname "$0")" && pwd)"
PW_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/pipewire/pipewire.conf.d"
WP_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/wireplumber/wireplumber.conf.d"

install -d -m 755 "$PW_DIR" "$WP_DIR"
install -m 644 "$ROOT/51-macbook81-speaker.conf" "$PW_DIR/51-macbook81-speaker.conf"
install -m 644 "$ROOT/51-mb81-rawpcm-speaker.conf" "$WP_DIR/51-mb81-rawpcm-speaker.conf"

echo "Installed for $USER."
echo "Restart WirePlumber when nothing is playing. This script will not."
echo "  systemctl --user restart wireplumber"
