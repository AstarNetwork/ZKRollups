echo "Install Rust And Build Dependencies"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. $HOME/.cargo/env
cargo install diesel_cli --no-default-features --features postgres
cargo install --version=0.2.0 sqlx-cli

echo "Clone Zksync And Build Packages"
git clone https://github.com/ArtreeTechnologies/zksync
cd zksync/infrastructure/zk
npm i
npm run build

echo "Zksync Config"
echo 'export ZKSYNC_HOME=/home/ubuntu/zksync' >> ~/.bashrc
echo 'export PATH=$ZKSYNC_HOME/bin:$PATH' >> ~/.bashrc

echo "Zksync Init"
. ~/.bashrc
zk init

echo "Build Zksync Contracts"
zk contract build
