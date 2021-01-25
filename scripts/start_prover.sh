#!/bin/sh

export DATABASE_URL=postgres://postgres:password@localhost/zksync
export PROVER_SECRET_AUTH=sample
export ETH_NETWORK=localhost
export PROVER_SERVER_PORT=8088
export WITNESS_GENERATORS=2
export IDLE_PROVERS=1
export RUST_LOG="zksync_api=debug,zksync_core=debug,zksync_eth_sender=debug,zksync_witness_generator=debug,zksync_server=debug,zksync_prover=debug,dummy_prover=info,key_generator=info,zksync_data_restore=info,zksync_eth_client=info,zksync_storage=info,zksync_state=info,zksync_types=info,exodus_test=info,loadtest=info,kube=debug,dev_ticker=info,block_sizes_test=info,zksync_config=debug"

(
cd zksync
cargo run --release --bin plonk_step_by_step_prover number_one
)
