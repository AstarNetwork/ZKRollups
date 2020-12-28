#!/bin/sh

echo "Install Official Packages Dependencies"
apt-get update
apt-get install sudo -y
sudo apt-get update
sudo apt-get install curl apt-transport-https ca-certificates software-properties-common libpq-dev build-essential pkg-config libssl-dev postgresql-client axel -y

echo "Install PPA Packages Dependencies"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
curl -O https://download.docker.com/linux/ubuntu/dists/bionic/pool/edge/amd64/containerd.io_1.2.2-3_amd64.deb
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo add-apt-repository ppa:ethereum/ethereum -y
sudo apt-get install ./containerd.io_1.2.2-3_amd64.deb -y

sudo apt-get update
sudo apt update
sudo apt-get install docker-ce nodejs yarn -y
sudo apt install snapd -y
sudo snap install solc

echo "Install docker-compose And Give Privilege To Docker"
sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod a+x /usr/local/bin/docker-compose
sudo usermod -aG docker $USER
newgrp docker
