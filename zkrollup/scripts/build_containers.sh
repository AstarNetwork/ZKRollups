#!/bin/sh

echo "Prepare Contracts..."
yarn compile
cp -r build zksync/contracts/build

echo "Build Server And Prover..."
DOCKER_BUILDKIT=1 docker build --ssh default -f zksync/docker/server/Dockerfile zksync -t zksync/server
DOCKER_BUILDKIT=1 docker build --ssh default -f zksync/docker/prover/Dockerfile zksync -t zksync/prover
