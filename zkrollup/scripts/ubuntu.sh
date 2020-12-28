#!/bin/sh

echo "Install Neccesary Dependencies"
sudo apt-get update
sudo apt-get install curl apt-transport-https ca-certificates software-properties-common libpq-dev build-essential pkg-config libssl-dev postgresql-client axel -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
curl -O https://download.docker.com/linux/ubuntu/dists/bionic/pool/edge/amd64/containerd.io_1.2.2-3_amd64.deb
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo add-apt-repository ppa:ethereum/ethereum -y
sudo apt-get install ./containerd.io_1.2.2-3_amd64.deb

sudo apt-get update
sudo apt-get install docker-ce nodejs yarn solc -y

sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
chmod a+x /usr/local/bin/docker-compose

source $HOME/.cargo/env
cargo install diesel_cli --no-default-features --features postgres
cargo install --version=0.2.0 sqlx-cli

git clone https://github.com/ArtreeTechnologies/zksync

cd zksync/infrastructure/zk
npm i
npm run build

sudo usermod -aG docker $USER

echo "Zksync Config"
echo 'export ZKSYNC_HOME=/home/ubuntu/zksync' >> ~/.bashrc
echo 'export PATH=$ZKSYNC_HOME/bin:$PATH' >> ~/.bashrc

echo "Zksync Init"
source ~/.bashrc
zk init
