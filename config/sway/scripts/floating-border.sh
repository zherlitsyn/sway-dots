#!/bin/sh
# float -> заголовок (border normal), tiling -> border pixel 1.
# Исключения (во float без рамки, pixel 0): VS Code / Code - OSS / VSCodium, Firefox и клоны.
node=$(swaymsg -t get_tree | jq -c '[.. | select(type == "object" and (.focused? == true))] | .[0] // empty')
[ -n "$node" ] || exit 0

state=$(printf '%s' "$node" | jq -r '.floating // "off"')
app=$(printf '%s' "$node" | jq -r '(.app_id // .window_properties.class // "")' | tr '[:upper:]' '[:lower:]')

case "$app" in
    *code*|*vscodium*|*firefox*|*librewolf*|*waterfox*)
        float_border="pixel 0"
        ;;
    *)
        float_border="normal"
        ;;
esac

case "$state" in
    user_on|auto_on)
        swaymsg floating disable >/dev/null 2>&1
        swaymsg border pixel 1   >/dev/null 2>&1
        ;;
    *)
        swaymsg floating enable  >/dev/null 2>&1
        swaymsg border $float_border >/dev/null 2>&1
        ;;
esac
