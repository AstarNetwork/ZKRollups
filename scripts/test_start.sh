#!/bin/sh

docker-compose up -d substrate postgres ticker
sh scripts/deploy.sh

psql "postgres://postgres:password@localhost/zksync" -c "INSERT INTO server_config (contract_addr, gov_contract_addr) VALUES ('0xBa2fE1C0669B28fbA1537DE8F893B356A41701bB', '0xF383bd74c2F80Eb03e82Bf7F0aCb3e869dBfA324') ON CONFLICT (id) DO UPDATE SET (contract_addr, gov_contract_addr) = ('0xBa2fE1C0669B28fbA1537DE8F893B356A41701bB', '0xF383bd74c2F80Eb03e82Bf7F0aCb3e869dBfA324');"
psql "postgres://postgres:password@localhost/zksync" -c "INSERT INTO eth_parameters (nonce, gas_price_limit, commit_ops, verify_ops, withdraw_ops) VALUES ('0', '400000000000', 0, 0, 0) ON CONFLICT (id) DO UPDATE SET (commit_ops, verify_ops, withdraw_ops) = (0, 0, 0);"

(
cd zksync
cargo run --bin zksync_server --release -- --genesis | tee genesis.log
export `cat genesis.log`
cargo run --bin zksync_server --release
) &

(
cd zksync
cargo run --release --bin plonk_step_by_step_prover number_one
)
