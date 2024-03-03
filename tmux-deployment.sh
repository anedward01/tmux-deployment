#!/usr/bin/env bash

#All files are set to 

if [ "${EUID}" -gt 0 ]; then
    echo "Error: Please run as root (sudo, su, etc.)" >&2
    exit 1
fi

echo "using apt update and apt install tmux"
sudo apt update
sudo apt install tmux -y

echo "Creating serverd user, home folder, and servermod group"

mkdir /usr/servers
useradd serverd -d /usr/servers -s /bin/bash
groupadd servermod

echo "Adding serverd to servermod group"
usermod -aG servermod serverd

echo "Creating TMUX socket"
echo $'\cb d' | tmux -S /usr/servers/Server

echo "Owning TMUX socket to serverd user and setting permissions to 770"
chown serverd:servermod /usr/servers/Server
chmod 770 /usr/servers/Server

echo "Installing tmux.sh and setting permissions to 770"
cp tmux.sh /usr/servers/tmux.sh
chmod 770 /usr/servers/tmux.sh

echo "Installing serverd.service and reloading systemd"
cp serverd.service /etc/systemd/system/serverd.service
systemctl daemon-reload

echo "Creating /usr/servers/hooks/startup/example.sh file"
mkdir -p /usr/servers/hooks/startup
cp startup-example.sh /usr/servers/hooks/startup/example.sh
chmod 770 /usr/servers/hooks/startup/example.sh

echo "Creating /usr/servers/hooks/shutdown/example.sh file"
mkdir -p /usr/servers/hooks/shutdown
cp shutdown-example.sh /usr/servers/hooks/shutdown/example.sh
chmod 770 /usr/servers/hooks/shutdown/example.sh

echo "Creating /usr/servers/hooks/systemd/example.service file"
echo "Edit then copy or symlink this file to /etc/systemd/system/ when ready"
mkdir /usr/servers/hooks/systemd
cp example-service.service /usr/servers/hooks/systemd/example.service

echo "Creating /usr/servers/serverFiles/ for server files to be stored at"
echo "Feel free to move this folder to a different name"
mkdir /usr/servers/serverFiles

echo "Chowning /usr/servers to serverd"
chown -R serverd:servermod /usr/servers

echo "Enabling serverd.service"
systemctl enable serverd.service

echo "Running serverd.service"
systemctl start serverd.service

echo "Verify serverd.service did not error out manually!"

echo "Setup complete"