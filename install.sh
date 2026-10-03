#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
XDG="${XDG_CONFIG_HOME:-$HOME/.config}"

for d in sway waybar wofi alacritty mako gtklock; do
    mkdir -p "$XDG/$d"
    cp -r "$ROOT/config/$d/." "$XDG/$d/"
done

mkdir -p "$XDG/environment.d"
cp "$ROOT/config/environment.d/30-wayland.conf" "$XDG/environment.d/"

chmod +x "$XDG/sway/scripts/floating-border.sh" \
         "$XDG/waybar/scripts/net.sh" \
         "$XDG/waybar/scripts/lang.sh"

echo "Done. Log out and log back in (environment.d, swayidle)."
