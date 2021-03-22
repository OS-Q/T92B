#!/bin/bash

# Install packages
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y --no-install-recommends ubuntu-desktop gnome-terminal firefox
sudo apt install -y --no-install-recommends virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

# Autologin to LightDM
sudo groupadd -r autologin
sudo gpasswd -a vagrant autologin
sudo mkdir -pv "/etc/lightdm/"
cat | sudo tee "/etc/lightdm/lightdm.conf" << EOF
[Seat:*]
autologin-user=vagrant
EOF

# Vagrant user settings
sudo sed -i 's/XKBLAYOUT=\"\w*"/XKBLAYOUT=\"'${HOST_LANG//[_.]*/}'\"/g' /etc/default/keyboard
gsettings set org.gnome.desktop.input-sources sources '[]'
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
cp /usr/share/applications/{firefox.desktop,gnome-terminal.desktop} /home/vagrant/Desktop/
chmod +x /home/vagrant/Desktop/*.desktop
