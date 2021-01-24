#!/bin/sh

cd ZKRollups/zksync
yarn
yarn zksync prepublish

(mkdir keys/setup
cd keys/setup
axel -c https://universal-setup.ams3.digitaloceanspaces.com/setup_2%5E20.key &
axel -c https://universal-setup.ams3.digitaloceanspaces.com/setup_2%5E21.key &
axel -c https://universal-setup.ams3.digitaloceanspaces.com/setup_2%5E22.key &
axel -c https://universal-setup.ams3.digitaloceanspaces.com/setup_2%5E23.key &
axel -c https://universal-setup.ams3.digitaloceanspaces.com/setup_2%5E24.key &
axel -c https://universal-setup.ams3.digitaloceanspaces.com/setup_2%5E25.key &
axel -c https://universal-setup.ams3.digitaloceanspaces.com/setup_2%5E26.key) &

tar xf keys/packed/verify-keys-plonk-6e2f649-account-24_-balance-8.tar.gz &
tar xf keys/packed/verify-keys-plonk-adc439-account-24_-balance-8.tar.gz &
tar xf keys/packed/verify-keys-plonk-13931-account-24_-balance-8.tar.gz &
tar xf keys/packed/verify-keys-plonk-7baf9b-account-24_-balance-8.tar.gz &
tar xf keys/packed/verify-keys-plonk-d2a679-account-32_-balance-11.tar.gz &
tar xf keys/packed/verify-keys-plonk-13b28c20-account-32_-balance-11.tar.gz &
tar xf keys/packed/verify-keys-plonk-7baf9b-account-32_-balance-11.tar.gz &
tar xf keys/packed/verify-keys-plonk-eea4d9-account-24_-balance-8.tar.gz &
tar xf keys/packed/verify-keys-plonk-2081fa08-account-32_-balance-11.tar.gz &
tar xf keys/packed/verify-keys-plonk-86c5acc2-account-32_-balance-11.tar.gz &
tar xf keys/packed/verify-keys-plonk-f5096d-account-24_-balance-8.tar.gz &
tar xf keys/packed/verify-keys-plonk-305f2e-account-24_-balance-8.tar.gz &
tar xf keys/packed/verify-keys-plonk-975ae851-account-32_-balance-11.tar.gz &
tar xf keys/packed/verify-keys-plonk-3772d44-account-32_-balance-11.tar.gz &
tar xf keys/packed/verify-keys-plonk-9e9d4e9d-account-32_-balance-11.tar.gz &

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. $HOME/.cargo/env
cargo install diesel_cli --no-default-features --features postgres
cargo install --version=0.2.0 sqlx-cli
