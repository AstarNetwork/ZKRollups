#!/bin/sh

echo "Install Neccesary Dependencies"
apt-get update
apt-get install curl -y

echo "Docker Installation"
apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
curl -O https://download.docker.com/linux/ubuntu/dists/bionic/pool/edge/amd64/containerd.io_1.2.2-3_amd64.deb
apt install ./containerd.io_1.2.2-3_amd64.deb
apt-get update
apt-get install docker-ce -y

echo "docker-compose Installation"
curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod a+x /usr/local/bin/docker-compose

echo "Version Check"
docker-compose --version
docker --version

echo "Nodejs And Yarn Installation"
curl -sL https://deb.nodesource.com/setup_12.x | bash - &&\
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
apt-get install nodejs yarn -y

echo "Version Check"
node --version
yarn --version

echo "Zksync Building"
cd infrastructure/zk
npm run build

echo "Zksync Config"
echo 'export ZKSYNC_HOME=/app' >> ~/.bashrc
echo 'export PATH=$ZKSYNC_HOME/bin:$PATH' >> ~/.bashrc

echo "Zksync Init"
source ~/.bashrc
zk init
