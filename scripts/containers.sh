#!/bin/sh

echo "Prepare Contracts..."
(cd zkrollup
yarn compile)
mkdir zksync/contracts/build
cp -r zkrollup/build/contracts/ zksync/contracts/build/
cp test/config/localhost.json zksync/etc/tokens/localhost.json

echo "Build Server And Prover..."
DOCKER_BUILDKIT=1 docker build --ssh default -f zksync/docker/server/Dockerfile zksync -t zksync/server
DOCKER_BUILDKIT=1 docker build --ssh default -f zksync/docker/prover/Dockerfile zksync -t zksync/prover
docker build -f docker/postgres/Dockerfile zksync/core/lib/storage/migrations -t zksync/postgres
