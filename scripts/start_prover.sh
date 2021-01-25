#!/bin/sh

export DATABASE_URL=postgres://postgres:password@localhost/zksync
export PROVER_SECRET_AUTH=sample
export ETH_NETWORK=localhost
export PROVER_SERVER_PORT=8088
export WITNESS_GENERATORS=2
export IDLE_PROVERS=1
export RUST_LOG="zksync_api=debug,zksync_core=debug,zksync_eth_sender=debug,zksync_witness_generator=debug,zksync_server=debug,zksync_prover=debug,dummy_prover=info,key_generator=info,zksync_data_restore=info,zksync_eth_client=info,zksync_storage=info,zksync_state=info,zksync_types=info,exodus_test=info,loadtest=info,kube=debug,dev_ticker=info,block_sizes_test=info,zksync_config=debug"
export SUPPORTED_BLOCK_CHUNKS_SIZES=6,30,74,150,320,630
export SUPPORTED_BLOCK_CHUNKS_SIZES_SETUP_POWERS=21,22,23,24,25,26
export BLOCK_CHUNK_SIZES=6,30
export KEY_DIR=keys/plonk-975ae851
export ACCOUNT_TREE_DEPTH=32
export BALANCE_TREE_DEPTH=11
export PROVER_SERVER_URL=http://localhost:8088
export REQ_SERVER_TIMEOUT=10
export RUST_BACKTRACE=1
export PROVER_DOWNLOAD_SETUP=false
export PROVER_SETUP_NETWORK_DIR="-"
export PROVER_PREPARE_DATA_INTERVAL=500
export PROVER_HEARTBEAT_INTERVAL=1000
export PROVER_CYCLE_WAIT=500
export PROVER_GONE_TIMEOUT=60000
export DOCKER_DUMMY_PROVER=false
(
cd zksync
cargo run --release --bin plonk_step_by_step_prover number_one
)
