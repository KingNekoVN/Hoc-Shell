#!/bin/bash
echo "Code by MinhNeko and Quang Huy"
# Tải package để bổ sung
apt-get update && apt-get install qemu-kvm -y   

# Tải windows 10 LTSC 
wget -O win.iso https://go.microsoft.com/fwlink/p/?LinkID=2195404&clcid=0x409&culture=en-us&country=US

# Cài driver
wget -O virtio.iso https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.271-1/virtio-win-0.1.271.iso

# Tạo file qcow2
qemu-img create -f qcow2 disk.qcow2 90G

echo "================================================"
echo " 🖥️  VNC: localhost:5900"
echo " Code By MinhNeko and Quang Huy
echo "================================================"
