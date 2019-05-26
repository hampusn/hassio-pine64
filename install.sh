#! /usr/bin/env bash

## Upgrade ubuntu
sudo apt-get update
sudo apt-get upgrade -y

## cURL and bash are needed by home assistant 
## but comes with ubuntu by default 
## so we shouldn't need to install them.
## 
## sudo apt-get install curl bash

## Install requirements for apt-get over HTTPS
sudo apt-get install apt-transport-https ca-certificates gnupg-agent software-properties-common -y

## Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

## Add docker stable repository 
sudo add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

## Install dependencies for home assistant
sudo apt-get install docker-ce jq avahi-daemon dbus apparmor-utils network-manager -y

## Enable run on startup
sudo systemctl enable NetworkManager.service

## Install Home Assistant
curl -sL https://raw.githubusercontent.com/home-assistant/hassio-installer/master/hassio_install.sh | bash -s -- -m qemuarm-64

## Restore Home Assistant snapshot
## TODO: 
## hassio sn restore -slug SLUG_ID

## Fix Forward-Agent for sudo so we can clone git repos with sudo.
echo -e "\nDefaults    env_keep+=SSH_AUTH_SOCK\n" | sudo tee -a /etc/sudoers

## Download custom cards
ln -s /usr/share/hassio/homeassistant ~/homeassistant

cd ~/homeassistant
sudo curl -O https://raw.githubusercontent.com/hampusn/hassio-pine64/master/config/sensor.yaml
sudo curl -O https://raw.githubusercontent.com/hampusn/hassio-pine64/master/config/ui-lovelace.yaml

sudo mkdir ~/homeassistant/www
cd ~/homeassistant/www
sudo git clone git@github.com:thomasloven/lovelace-card-tools.git
sudo git clone git@github.com:thomasloven/lovelace-layout-card.git
sudo git clone git@github.com:maykar/compact-custom-header.git
sudo git clone git@github.com:hampusn/lovelace-list-card.git
sudo git clone git@github.com:hampusn/lovelace-attribute-card.git

sudo mkdir ~/homeassistant/commands
cd ~/homeassistant/commands
sudo curl -O https://raw.githubusercontent.com/hampusn/hassio-pine64/master/config/commands/kodi-recently-added.py

