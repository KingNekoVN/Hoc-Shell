#!/bin/bash
# Check ảo hóa
virtu=$(egrep -i '^flags.*(vmx|svm)' /proc/cpuinfo | wc -l)
if [ $virtu = 0 ] ; then echo -e "[Error] ${RED}Virtualization/KVM in your Server/VPS is OFF\nExiting...${NC}";
else

#Start VM
sudo qemu-system-x86_64 -vnc :0 -hda disk.img -cdrom /opt/qemu/AstroOS 11 24H2.iso -smp cores=2 -m 8096M -machine usb=on -device usb-tablet

# Start noVNC
websockify --web=/novnc 5901 localhost:5900 &

echo "================================================"
echo " 🖥️  VNC: http://iptailscale:6080"
echo " Use ngrok to http(port 6080) or use tailscale"
echo " Code By MinhNeko and Quang Huy(Github) Youtube: https://youtube.com/@MinhNeko | 
echo "================================================"

