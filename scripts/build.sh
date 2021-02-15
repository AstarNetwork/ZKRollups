#!/bin/sh

echo "Submodule Cloning..."
git submodule update --init --recursive

echo "Prepare Operator And Prover Container Images..."
DOCKER_BUILDKIT=1 docker build --ssh default=$HOME/.ssh/id_rsa -f zksync/docker/operator/Dockerfile zksync -t docker.pkg.github.com/plasmnetwork/zkrollups/operator:latest
DOCKER_BUILDKIT=1 docker build --ssh default=$HOME/.ssh/id_rsa -f zksync/docker/prover/Dockerfile zksync -t docker.pkg.github.com/plasmnetwork/zkrollups/prover:latest
docker push docker.pkg.github.com/plasmnetwork/zkrollups/operator:latest
docker push docker.pkg.github.com/plasmnetwork/zkrollups/prover:latest
docker rmi docker.pkg.github.com/plasmnetwork/zkrollups/operator docker.pkg.github.com/plasmnetwork/zkrollups/prover

echo "Prepare Substrate Container Image..."
docker build blockchain -t docker.pkg.github.com/plasmnetwork/zkrollups/substrate:latest
docker push docker.pkg.github.com/plasmnetwork/zkrollups/substrate:latest
docker rmi docker.pkg.github.com/plasmnetwork/zkrollups/substrate

echo "Prepare Postgres And Integration Container Images..."
docker build zksync/core/lib/storage/migrations -t docker.pkg.github.com/plasmnetwork/zkrollups/postgres:latest
docker build ts-tests -t docker.pkg.github.com/plasmnetwork/zkrollups/ts-tests:latest
docker push docker.pkg.github.com/plasmnetwork/zkrollups/postgres:latest
docker push docker.pkg.github.com/plasmnetwork/zkrollups/ts-tests:latest
