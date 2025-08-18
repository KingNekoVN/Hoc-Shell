#!/bin/bash
echo "Code By MinhNeko"
# Tải package bổ sung vào để tải
apt-get update && apt-get install -y --no-install-recommends \
    qemu-system-x86-64 \
    cloud-image-utils \
    novnc \
    websockify \
    python3-pip \
    unzip \
    p7zip-full \
    wget \
    sudo \
    && rm -rf /var/lib/apt/lists/* && apt clean

# Tạo thư mục bên trong noVNC
mkdir -p /data /novnc /opt/qemu /cloud-init

# Tải Windows2012r2
qemu-img create -f raw 2012r2.img 60G
wget -O- --no-check-certificate http://drive.muavps.net/windows/Windows2012r2.gz | gunzip | dd of=2012r2.img

# Setup noVNC
curl -L https://github.com/novnc/noVNC/archive/refs/tags/v1.3.0.zip -o /tmp/novnc.zip && \
unzip /tmp/novnc.zip -d /tmp && \
mv /tmp/noVNC-1.3.0/* /novnc && \
rm -rf /tmp/novnc.zip /tmp/noVNC-1.3.0

# Cài đặt ngrok
curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
  | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
  && echo "deb https://ngrok-agent.s3.amazonaws.com bookworm main" \
  | sudo tee /etc/apt/sources.list.d/ngrok.list \
  && sudo apt update \
  && sudo apt install ngrok

# Cài tailscale(nếu cần)
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt-get install tailscale

# Connect colab với tailscale
 sudo tailscale up

# Token Ngrok
ngrok config add-authtoken 2xB1jLlRuHFhvqas7ZDdc4K8G23_4iTdz9zAYYFk3K2YGtiNL

# Khởi chạy VPS
sudo qemu-system-x86_64 \
  -m 8G \
  -cpu EPYC \
  -boot order=d \
  -drive file=2012r2 \
  -device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
  -device usb-tablet \
  -vnc :0 \
  -cpu n270 \
  -smp sockets=1,cores=4,threads=2 \
  -device e1000,netdev=n0 -netdev user,id=n0 \
  -accel tcg,thread=multi \

