# syntax=docker/dockerfile:experimental
FROM rust:1.45 as builder
RUN --mount=type=cache,target=/usr/local/cargo/registry \
    cargo install sccache
WORKDIR /usr/src/zksync
COPY zksync .
RUN --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,target=/root/.cache/sccache \
    RUSTC_WRAPPER=/usr/local/cargo/bin/sccache \
    cargo build --release

FROM ubuntu:18.04
RUN apt-get update && apt-get install -y sudo libpq5 ca-certificates && rm -rf /var/lib/apt/lists/*
EXPOSE 3000
EXPOSE 3031
EXPOSE 3030
COPY --from=builder /usr/src/zksync/target/release/zksync_server /usr/bin
COPY zksync/contracts/build/ /contracts/build/

ENV DATABASE_URL=postgres://postgres:password@localhost:5432/zksync
ENV DB_POOL_SIZE=10
ENV BLOCK_CHUNK_SIZES=6,30
ENV WEB3_URL=http://127.0.0.1:8545
ENV GENESIS_TX_HASH=0xb99ebfea46cbe05a21cd80fe5597d97b204befc52a16303f579c607dc1ac2e2e
ENV CONTRACT_ADDR=0x70a0F165d6f8054d0d0CF8dFd4DD2005f0AF6B55
ENV GOVERNANCE_ADDR=0x5E6D086F5eC079ADFF4FB3774CDf3e8D6a34F7E9
ENV OPERATOR_FEE_ETH_ADDRESS=0x17a4dC4aF1FAF9c3Db0515a170491c37eb0373Dc
ENV CONFIRMATIONS_FOR_ETH_EVENT=0
ENV MAX_NUMBER_OF_WITHDRAWALS_PER_BLOCK=10
ENV ETH_WATCH_POLL_INTERVAL=300
ENV ETH_NETWORK=localhost
ENV MINIBLOCKS_ITERATIONS=10
ENV MINIBLOCK_ITERATION_INTERVAL=200
ENV PROMETHEUS_EXPORT_PORT=3312
ENV OPERATOR_COMMIT_ETH_ADDRESS=0x17a4dC4aF1FAF9c3Db0515a170491c37eb0373Dc
ENV CHAIN_ID=9
ENV GAS_PRICE_FACTOR=1
ENV ETH_TX_POLL_PERIOD=3
ENV ETH_EXPECTED_WAIT_TIME_BLOCK=30
ENV ETH_WAIT_CONFIRMATIONS=1
ENV ETH_MAX_TXS_IN_FLIGHT=3
ENV ETH_IS_ENABLED=true
ENV PROVER_SECRET_AUTH=sample
ENV PROVER_PREPARE_DATA_INTERVAL=500
ENV PROVER_HEARTBEAT_INTERVAL=1000
ENV PROVER_CYCLE_WAIT=500
ENV PROVER_GONE_TIMEOUT=60000
ENV PROVER_SERVER_PORT=8088
ENV WITNESS_GENERATORS=2
ENV IDLE_PROVERS=1
ENV FORCED_EXIT_MINIMUM_ACCOUNT_AGE_SECS=0
ENV REST_API_PORT=3001
ENV HTTP_RPC_API_PORT=3030
ENV WS_API_PORT=3031
ENV PRIVATE_CORE_SERVER_PORT=8090
ENV PRIVATE_CORE_SERVER_URL=http://127.0.0.1:8090
ENV API_REQUESTS_CACHES_SIZE=10000

RUN apt-get update &&\
    apt-get install gnupg2 curl software-properties-common -y &&\
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - &&\
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" &&\
    curl -O https://download.docker.com/linux/ubuntu/dists/bionic/pool/edge/amd64/containerd.io_1.2.2-3_amd64.deb &&\
    sudo apt-get install docker-ce -y

COPY docker docker

COPY zksync/core/lib/storage/migrations core/lib/storage/migrations

RUN sudo usermod -aG docker root

RUN newgrp docker

ENTRYPOINT sleep 5000

# RUN docker build -f docker/postgres/Dockerfile core/lib/storage/migrations -t zksync/postgres

# ENTRYPOINT ["zksync_server"]
