#!/bin/bash
echo "Code by MinhNeko and Quang Huy"
# Tải package để bổ sung
apt-get update && apt-get install -y --no-install-recommends \
    qemu-kvm \
    qemu-system-x86 \
    sudo \
    software-properties-common \
    genisoimage \
    curl \
    unzip \
    python3-pip \
    net-tool \
    && rm -rf /var/lib/apt/lists/* && apt clean

# Tải windows 10 LTSC 
wget -O win.iso https://go.microsoft.com/fwlink/p/?LinkID=2195404&clcid=0x409&culture=en-us&country=US

# Cài driver
wget -O virtio.iso https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.271-1/virtio-win-0.1.271.iso

# Tạo file qcow2
qemu-img create -f qcow2 disk.qcow2 90G

# Lấy IP bằng pinggy
while ($true) {
ssh -p 443 -o StrictHostKeyChecking=no -o ServerAliveInterval=30 -R0:127.0.0.1:5900 tcp@ap.a.pinggy.io
Start-Sleep -Seconds 10
}

# Khởi động
sudo qemu-system-x86_64 \
-M q35,nvdimm=on,hmat=on \
-usb -device usb-tablet -device usb-kbd \
-cpu qemu64,+ssse3,+sse4.1,+sse4.2,+aes,+xsave,+xsaveopt,+xsavec,+xgetbv1,+avx,+avx2,+fma,+fma4,+popcnt,+cx16,+mmx,+sse,+sse2 \
-smp sockets=1,cores=8,threads=1 \
-m 8384M \
-object memory-backend-memfd,id=mem,size=8384M,share=on,prealloc=on \
-machine memory-backend=mem \
-object iothread,id=iothread0 \
-drive file=disk.qcow2,if=none,format=qcow2,cache=unsafe,aio=threads,discard=on,id=hd0 \
-device virtio-blk-pci,drive=hd0,iothread=iothread0 \
-drive file=win.iso,media=cdrom,if=none,id=cdrom0 \
-device ahci,id=ahci0 \
-device ide-cd,drive=cdrom0,bus=ahci0.0 \
-drive file=virtio.iso,media=cdrom,if=none,id=cdrom1 \
-device ide-cd,drive=cdrom1,bus=ahci0.1 \
-device qxl-vga,vgamem_mb=2048,ram_size=268435456,vram_size=268435456 \
-device virtio-balloon,id=balloon0 \
-netdev user,id=n0,restrict=off \
-device virtio-net-pci,netdev=n0 \
-accel tcg,thread=multi,tb-size=34777216,split-wx=on \
-rtc clock=host,base=utc \
-boot order=d,menu=on \
-display vnc=:0 \
-msg timestamp=on

echo "================================================"
echo " 🖥️  VNC: localhost:5900"
echo " Code By MinhNeko and Quang Huy
echo "================================================"
