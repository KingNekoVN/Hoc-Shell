#!/bin/bash

#Start VM
sudo qemu-system-x86_64 -vnc :0 -hda 2012r2.img -smp cores=2 -m 8096M -machine usb=on -device usb-tablet

# Start noVNC
websockify --web=/novnc 5901 localhost:5900 &

echo "================================================"
echo " 🖥️  VNC: http://iptailscale:6080"
echo " Use ngrok to http(port 6080) or use tailscale"
echo " Code By MinhNeko and Quang Huy(Github) Youtube: https://youtube.com/@MinhNeko | 
echo "================================================"

