#!/bin/sh
# Индикатор раскладки. Если показывает не то, впишите сюда identifier
# вашей клавиатуры (узнать: swaymsg -t get_inputs | jq -r '.[] | select(.type=="keyboard") | .identifier')
KB_ID=""

if [ -n "$KB_ID" ]; then
    lay=$(swaymsg -t get_inputs | jq -r --arg id "$KB_ID" \
        '.[] | select(.identifier == $id) | .xkb_active_layout_name' | head -n1)
else
    lay=$(swaymsg -t get_inputs | jq -r '
        [ .[]
          | select(.type == "keyboard")
          | select(.xkb_active_layout_name != null)
          | select(.identifier | test("Power Button|Sleep Button|Video Bus|HID|Consumer") | not)
        ] | .[0].xkb_active_layout_name // empty' | head -n1)
fi

[ -n "$lay" ] || lay="n/a"
printf '%s\n' "$lay" | awk '{ print toupper(substr($0, 1, 2)) }'
