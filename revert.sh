#!/bin/bash
# Remove the MacBook8,1 speaker names and EQ chain for the invoking user.
# Does not touch the kernel driver. Does not restart PipeWire.
set -euo pipefail

if [[ "$(id -u)" -eq 0 ]]; then
  echo "run as the desktop user, not root: bash $0" >&2
  exit 1
fi

PW_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/pipewire/pipewire.conf.d"
WP_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/wireplumber/wireplumber.conf.d"

rm -f "$PW_DIR/51-macbook81-speaker.conf" "$WP_DIR/51-mb81-rawpcm-speaker.conf"
echo "Removed for $USER."
echo "Restart WirePlumber when nothing is playing. This script will not."
echo "  systemctl --user restart wireplumber"
