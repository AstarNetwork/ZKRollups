#!/bin/sh

echo "Submodule Cloning..."
git submodule update --init --recursive

echo "Build Container Images..."
DOCKER_BUILDKIT=1 docker build --ssh default=$HOME/.ssh/id_rsa -f zksync/docker/operator/Dockerfile zksync -t docker.pkg.github.com/plasmnetwork/zkrollups/operator:latest
DOCKER_BUILDKIT=1 docker build --ssh default=$HOME/.ssh/id_rsa -f zksync/docker/prover/Dockerfile zksync -t docker.pkg.github.com/plasmnetwork/zkrollups/prover:latest
docker build blockchain -t docker.pkg.github.com/plasmnetwork/zkrollups/substrate:latest
docker build zksync/core/lib/storage/migrations -t docker.pkg.github.com/plasmnetwork/zkrollups/postgres:latest
docker build ts-tests -t docker.pkg.github.com/plasmnetwork/zkrollups/ts-tests:latest

echo "Push Container Images..."
docker push docker.pkg.github.com/plasmnetwork/zkrollups/operator:latest
docker push docker.pkg.github.com/plasmnetwork/zkrollups/prover:latest
docker push docker.pkg.github.com/plasmnetwork/zkrollups/substrate:latest
docker push docker.pkg.github.com/plasmnetwork/zkrollups/postgres:latest
docker push docker.pkg.github.com/plasmnetwork/zkrollups/ts-tests:latest
