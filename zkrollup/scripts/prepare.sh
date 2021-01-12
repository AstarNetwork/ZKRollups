#!/bin/sh

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. $HOME/.cargo/env
cargo install diesel_cli --no-default-features --features postgres
cargo install --version=0.2.0 sqlx-cli

(git clone https://github.com/ArtreeTechnologies/zksync
cd zksync/infrastructure/zk
npm i
npm run build)

echo 'export ZKSYNC_HOME=/home/ubuntu/zksync' >> ~/.bashrc
echo 'export PATH=$ZKSYNC_HOME/bin:$PATH' >> ~/.bashrc
. ~/.bashrc

docker-compose up -d postgres geth dev-ticker
docker-compose up -d tesseracts
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

(cd core/lib/storage
export DATABASE_URL=postgres://postgres@localhost/plasma
diesel database setup
diesel migration run
cargo sqlx prepare --check || cargo sqlx prepare)

touch etc/tokens/localhost.json
echo "[]" > etc/tokens/localhost.json

export ETH_NETWORK=localhost
cargo run --release --bin gen_token_add_contract
yarn contracts build

export OPERATOR_PRIVATE_KEY=4dc023426c7bbd647cc9789343ac495225ff11aff3463b85dac0f503b70a119d
export OPERATOR_COMMIT_ETH_ADDRESS=0x17a4dC4aF1FAF9c3Db0515a170491c37eb0373Dc
export OPERATOR_FEE_ETH_ADDRESS=0x17a4dC4aF1FAF9c3Db0515a170491c37eb0373Dc
export GENESIS_ROOT=0x2d5ab622df708ab44944bb02377be85b6f27812e9ae520734873b7a193898ba4
export WEB3_URL=http://127.0.0.1:8545
export TOKEN_PRICE_SOURCE=CoinGecko
export COINMARKETCAP_BASE_URL=http://127.0.0.1:9876
export COINGECKO_BASE_URL=http://127.0.0.1:9876
export ETHERSCAN_API_KEY=""
export UPGRADE_GATEKEEPER_ADDR=0x5E6D086F5eC079ADFF4FB3774CDf3e8D6a34F7E9
export GOVERNANCE_TARGET_ADDR=0x5E6D086F5eC079ADFF4FB3774CDf3e8D6a34F7E9
export VERIFIER_TARGET_ADDR=0x5E6D086F5eC079ADFF4FB3774CDf3e8D6a34F7E9
export CONTRACT_TARGET_ADDR=0x5E6D086F5eC079ADFF4FB3774CDf3e8D6a34F7E9
export CONTRACT_ADDR=0x70a0F165d6f8054d0d0CF8dFd4DD2005f0AF6B55
export GOVERNANCE_ADDR=0x5E6D086F5eC079ADFF4FB3774CDf3e8D6a34F7E9
export VERIFIER_ADDR=0xDAbb67b676F5b01FcC8997Cc8439846D0d8078ca
export DEPLOY_FACTORY_ADDR=0xFC073319977e314F251EAE6ae6bE76B0B3BAeeCF
export GENESIS_TX_HASH=0xb99ebfea46cbe05a21cd80fe5597d97b204befc52a16303f579c607dc1ac2e2e
export CHAIN_ID=9
export GAS_PRICE_FACTOR=1
export ETH_NETWORK=localhost
export DATABASE_URL=postgres://postgres@localhost/plasma
export DB_POOL_SIZE=10
export ETH_WAIT_CONFIRMATIONS=1
export ETH_EXPECTED_WAIT_TIME_BLOCK=30
export ETH_TX_POLL_PERIOD=3
export ETH_MAX_TXS_IN_FLIGHT=3
export ETH_GAS_PRICE_DEFAULT_LIMIT=400000000000
export ETH_GAS_PRICE_LIMIT_UPDATE_INTERVAL=150
export ETH_GAS_PRICE_LIMIT_SAMPLE_INTERVAL=15
export ETH_GAS_PRICE_LIMIT_SCALE_FACTOR=1.0
export ETH_IS_ENABLED=true
export PROVER_PREPARE_DATA_INTERVAL=500
export PROVER_HEARTBEAT_INTERVAL=1000
export PROVER_CYCLE_WAIT=500
export PROVER_GONE_TIMEOUT=60000
export PROVER_SECRET_AUTH=sample
export PROVER_DOWNLOAD_SETUP=false
export PROVER_SETUP_NETWORK_DIR="-"
export DOCKER_DUMMY_PROVER=false
export ADMIN_SERVER_API_PORT=8080
export ADMIN_SERVER_API_URL=http://127.0.0.1:8080
export ADMIN_SERVER_SECRET_AUTH=sample
export REST_API_PORT=3001
export HTTP_RPC_API_PORT=3030
export WS_API_PORT=3031
export PROVER_SERVER_PORT=8088
export PROVER_SERVER_URL=http://127.0.0.1:8088
export PRIVATE_CORE_SERVER_PORT=8090
export PRIVATE_CORE_SERVER_URL=http://127.0.0.1:8090
export RUST_BACKTRACE=1
export KEY_DIR=keys/plonk-975ae851
export SUPPORTED_BLOCK_CHUNKS_SIZES=6,30,74,150,320,630
export SUPPORTED_BLOCK_CHUNKS_SIZES_SETUP_POWERS=21,22,23,24,25,26
export MAX_NUMBER_OF_WITHDRAWALS_PER_BLOCK=10
export BLOCK_CHUNK_SIZES=6,30
export ACCOUNT_TREE_DEPTH=32
export BALANCE_TREE_DEPTH=11
export IDLE_PROVERS=1
export REQ_SERVER_TIMEOUT=10
export API_REQUESTS_CACHES_SIZE=10000
export RUST_LOG="zksync_api=debug,zksync_core=debug,zksync_eth_sender=debug,zksync_witness_generator=debug,zksync_server=debug,zksync_prover=debug,dummy_prover=info,key_generator=info,zksync_data_restore=info,zksync_eth_client=info,zksync_storage=info,zksync_state=info,zksync_types=info,exodus_test=info,loadtest=info,kube=debug,dev_ticker=info,block_sizes_test=info,zksync_config=debug"
export ZKSYNC_ACTION=dont_ask
export CONFIRMATIONS_FOR_ETH_EVENT=0
export ETH_WATCH_POLL_INTERVAL=300
export MINIBLOCK_ITERATION_INTERVAL=200
export MINIBLOCKS_ITERATIONS=10
export FAST_BLOCK_MINIBLOCKS_ITERATIONS=5
export PROMETHEUS_EXPORT_PORT=3312
export TICKER_FAST_PROCESSING_COEFF=10.0
export WITNESS_GENERATORS=2
export FORCED_EXIT_MINIMUM_ACCOUNT_AGE_SECS=0
export MAX_LIQUIDATION_FEE_PERCENT=5
export FEE_ACCOUNT_PRIVATE_KEY=unset
export NOT_SUBSIDIZED_TOKENS=2b591e99afe9f32eaa6214f7b7629768c40eeb39,34083bbd70d394110487feaa087da875a54624ec
export TICKER_DISABLED_TOKENS=38A2fDc11f526Ddd5a607C1F251C065f40fBF2f7

cargo run --bin zksync_server --release -- --genesis | tee genesis.log
export `cat genesis.log`
yarn contracts deploy-no-build | tee deploy.log

# export GOVERNANCE_TARGET_ADDR=0xc56E79CAA94C96DE01eF36560ac215cC7A4F0F47
# export VERIFIER_TARGET_ADDR=0x572b9410D9a14Fa729F3af92cB83A07aaA472dE0
# export CONTRACT_TARGET_ADDR=0x5E6D086F5eC079ADFF4FB3774CDf3e8D6a34F7E9
# export GOVERNANCE_ADDR=0xF383bd74c2F80Eb03e82Bf7F0aCb3e869dBfA324
# export CONTRACT_ADDR=0xBa2fE1C0669B28fbA1537DE8F893B356A41701bB
# export VERIFIER_ADDR=0x9EE6D7616Deb793FBf71103026DE427AB27161A4
# export export GATEKEEPER_ADDR=0x55f6Eb643438a7C116E818F8104edA87c3F08D0d
# export DEPLOY_FACTORY_ADDR=0x70a0F165d6f8054d0d0CF8dFd4DD2005f0AF6B55
# export GATEKEEPER_ADDR=0x55f6Eb643438a7C116E818F8104edA87c3F08D0d
# export GENESIS_TX_HASH=0x42e2203adf9aa9aae55a67d52181fb2a48f94bf7a0faa0bff6cc039e202c430f
# psql "postgres://postgres@localhost/plasma" -c "INSERT INTO server_config (contract_addr, gov_contract_addr) VALUES ('0xBa2fE1C0669B28fbA1537DE8F893B356A41701bB', '0xF383bd74c2F80Eb03e82Bf7F0aCb3e869dBfA324') ON CONFLICT (id) DO UPDATE SET (contract_addr, gov_contract_addr) = ('0xBa2fE1C0669B28fbA1537DE8F893B356A41701bB', '0xF383bd74c2F80Eb03e82Bf7F0aCb3e869dBfA324');"

yarn contracts publish-sources
psql "postgres://postgres@localhost/plasma" -c "INSERT INTO eth_parameters (nonce, gas_price_limit, commit_ops, verify_ops, withdraw_ops) VALUES ('0', '400000000000', 0, 0, 0) ON CONFLICT (id) DO UPDATE SET (commit_ops, verify_ops, withdraw_ops) = (0, 0, 0)"
