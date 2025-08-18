#!/bin/bash
echo Sắp xong ròi 🐧
# Kết quả
echo " 🖥️  VNC: http://localhost:6080"
echo " Use ngrok to http(port 6080) or use tailscale and paste ip in your browser"
echo " Code By MinhNeko and Quang Huy | Youtube: youtube.com/@MinhNeko | youtube.com/@huyhuy-o2z

#Start VM
sudo qemu-system-x86_64 -vnc :0 -hda 2012r2.img -smp cores=2 -m 8096M -machine usb=on -device usb-tablet

#Start noVNC
websockify --web=/novnc 6080 localhost:5900 &
