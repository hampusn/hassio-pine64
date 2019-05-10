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
## sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

## Install dependencies for home assistant
sudo apt-get install docker-ce jq avahi-daemon dbus apparmor-utils network-manager -y

## Enable run on startup
sudo systemctl enable NetworkManager.service

## Install Home Assistant
## curl -sL https://raw.githubusercontent.com/home-assistant/hassio-installer/master/hassio_install.sh | sudo bash -s
curl -sL https://raw.githubusercontent.com/home-assistant/hassio-installer/master/hassio_install.sh | bash -s -- -m qemuarm-64

## Restore Home Assistant snapshot
## TODO: 
## hassio sn restore -slug SLUG_ID
