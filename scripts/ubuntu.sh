#!/bin/sh

echo "Docker Installation"
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
curl -O https://download.docker.com/linux/ubuntu/dists/bionic/pool/edge/amd64/containerd.io_1.2.2-3_amd64.deb
sudo apt install ./containerd.io_1.2.2-3_amd64.deb
sudo apt-get update
sudo apt-get install docker-ce -y

echo "docker-compose Installation"
sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod a+x /usr/local/bin/docker-compose

echo "Version Check"
docker-compose --version
docker --version

echo "Nodejs And Yarn Installation"
curl -sL https://deb.nodesource.com/setup_12.x | sudo bash - &&\
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo apt-get install nodejs npm yarn -y

echo "Version Check"
node --version
yarn --version

echo "Zksync Building"
git clone https://github.com/matter-labs/zksync
cd zksync/infrastructure/zk
npm run build

echo "Zksync Config"
echo 'export ZKSYNC_HOME=/path/to/zksync' >> ~/.bashrc
echo 'export PATH=$ZKSYNC_HOME/bin:$PATH' >> ~/.bashrc

echo "Zksync Init"
zk init
