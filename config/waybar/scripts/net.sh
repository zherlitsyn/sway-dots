#!/bin/sh
wifi=$(nmcli -t -f ACTIVE,SSID,SIGNAL device wifi 2>/dev/null | grep '^yes:' | head -n1)
if [ -n "$wifi" ]; then
    ssid=$(printf '%s' "$wifi" | cut -d':' -f2)
    sig=$(printf '%s' "$wifi" | cut -d':' -f3)
    echo "${ssid} ${sig}%"
    exit 0
fi
if nmcli -t -f TYPE,STATE device status 2>/dev/null | grep -q '^ethernet:connected'; then
    echo "ETH"
    exit 0
fi
echo "No net"
