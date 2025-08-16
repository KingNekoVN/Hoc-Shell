#!/bin/bash
echo "Code By MinhNeko"
# Tải package bổ sung vào để tải
apt-get update && apt-get install -y --no-install-recommends \
    qemu-system-x86 \
    qemu-utils \
    cloud-image-utils \
    novnc \
    net-tools \
    websockify \
    python3-pip \
    unzip \
    && rm -rf /var/lib/apt/lists/* && apt clean

# Tạo thư mục bên trong noVNC
mkdir -p /data /novnc /opt/qemu /cloud-init

# Tải Micro 10
curl -L  \
-o /opt/qemu/micro10.iso

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
# Token Ngrok
echo "Bấm terminal và dán token của bạn"
# Tải file start.sh để bắt đầu khởi chạy
wget -O start.sh https://github.com/KingNekoVN/Hoc-Shell/raw/refs/heads/main/start.sh
clear
echo "Đang chạy vui lòng đừng tắt"
chmod +x start.sh && \
bash start.sh
