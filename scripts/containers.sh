#!/bin/sh

echo "Submodule Cloning..."
git submodule update --init --recursive

echo "Copy Contract File..."
(
cd ts-tests
yarn
yarn build
)

echo "Build Server And Prover..."
DOCKER_BUILDKIT=1 docker build --ssh default=$HOME/.ssh/id_rsa -f zksync/docker/server/Dockerfile zksync -t zksync/server
DOCKER_BUILDKIT=1 docker build --ssh default=$HOME/.ssh/id_rsa -f zksync/docker/prover/Dockerfile zksync -t zksync/prover
