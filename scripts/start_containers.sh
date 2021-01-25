#!/bin/sh

docker-compose up -d substrate postgres ticker
sh scripts/substrate_setup.sh

psql "postgres://postgres:password@localhost/zksync" -c "INSERT INTO server_config (contract_addr, gov_contract_addr) VALUES ('0x617a6822702a24f80f42fb1baef83a3a35463a8e', '0x19c6d657e843a0a84609b3c941b4762091978cf9') ON CONFLICT (id) DO UPDATE SET (contract_addr, gov_contract_addr) = ('0x617a6822702a24f80f42fb1baef83a3a35463a8e', '0x19c6d657e843a0a84609b3c941b4762091978cf9');"
psql "postgres://postgres:password@localhost/zksync" -c "INSERT INTO eth_parameters (nonce, gas_price_limit, commit_ops, verify_ops, withdraw_ops) VALUES ('0', '400000000000', 0, 0, 0) ON CONFLICT (id) DO UPDATE SET (commit_ops, verify_ops, withdraw_ops) = (0, 0, 0);"
