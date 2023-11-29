---
sidebar_position: 1
---

# Install Raspberry Pi

## Install

1. Get Raspberry Pi Imager
2. On SSD, install `Other general-purpose OS > Ubuntu > Ubuntu Server 22.04.3 LTS (64-bit)`.
3. Boot.

## Configure

### No password with sudo

```bash
sudo visudo
```

```bash
pnode ALL=(ALL) NOPASSWD: ALL
```

### Generate ssh key

```bash
ssh-keygen
```

### Setup Ethernet

```bash
sudo nano /etc/netplan/50-cloud-init.yaml
```

Add `ethernets` like

```bash
network:
    version: 2
    ethernets:
        eth0:
            dhcp4: true
            optional: true
```

Replace `eth0` with your actual Ethernet interface name if it's different. You can find it by running ip `link` or `ifconfig` command.

### Add swap

```bash
# Create a Swap File
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
# Make the File a Swap File
sudo mkswap /swapfile
# Enable the Swap File:
sudo swapon /swapfile
/swapfile none swap sw 0 0
```

```bash
sudo nano /etc/fstab
```

Add at the end

```bash
/swapfile none swap sw 0 0
```

to confirm that the swap is active.

```bash
swapon --show
free -h
```

### Update packages

Update packages

```bash
sudo apt update && sudo apt upgrade -y
```

### Change timezone

```bash
sudo timedatectl set-timezone Europe/Paris
```

### Install docker

[https://docs.docker.com/engine/install/ubuntu/](https://docs.docker.com/engine/install/ubuntu/)

1. Set up Docker's `apt` repository.

Add Docker's official GPG key:

```bash
sudo apt install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

Add the repository to Apt sources:

```bash
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

2. Install the Docker packages.

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
```

3. Post-installation steps

Create the docker group and add your user

```bash
sudo groupadd docker
sudo usermod -aG docker $USER
```

Apply with

```bash
newgrp docker
```

## Geekworm X735 V3.0

Install Geekworm X735 V3.0: [./geekworm-x735-v30.md](./geekworm-x735-v30.md)

## Kiok mode with Firefox

Install kiosk mode with Firefox: [./kiosk-with-firefox.md](./kiosk-with-firefox.md)

## Start Avahi

???

```bash
sudo hostnamectl set-hostname pnode
```

Reboot

```bash
subo
```

???

```bash
sudo nano /etc/avahi/avahi-daemon.conf
```

```nano
[server]
host-name=pnode
domain-name=local
[...]
allow-interfaces=wlan0
deny-interfaces=docker0
```

```bash
sudo systemctl restart avahi-daemon
```

Check if the hostname resolves locally

```bash
ping -c 4 pnode.local
```

Issues:

Change hostname in `/boot/firmware/user-data`

```
avahi-resolve -n pnode.local
```

should return

```
pnode.local     192.168.1.28
```

Restart the computer that need to access if it is not working.
