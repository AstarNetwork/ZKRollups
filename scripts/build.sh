#!/bin/sh

echo "Submodule Cloning..."
git submodule update --init --recursive

if [ $1 = "actions" ]; then
    echo "Prepare Substrate Container Image..."
    docker build blockchain -t docker.pkg.github.com/plasmnetwork/zkrollups/substrate:latest
    docker push docker.pkg.github.com/plasmnetwork/zkrollups/substrate:latest
    docker rmi docker.pkg.github.com/plasmnetwork/zkrollups/substrate

    echo "Prepare Operator Container Image..."
    DOCKER_BUILDKIT=1 docker build --ssh default=$HOME/.ssh/id_rsa -f ts-tests/tests/zksync/docker/server/Dockerfile ts-tests/tests/zksync -t docker.pkg.github.com/plasmnetwork/zkrollups/operator:latest
    docker push docker.pkg.github.com/plasmnetwork/zkrollups/operator:latest
    docker rmi docker.pkg.github.com/plasmnetwork/zkrollups/operator

    echo "Prepare Prover Contaienr Image..."
    DOCKER_BUILDKIT=1 docker build --ssh default=$HOME/.ssh/id_rsa -f ts-tests/tests/zksync/docker/prover/Dockerfile ts-tests/tests/zksync -t docker.pkg.github.com/plasmnetwork/zkrollups/prover:latest
    docker push docker.pkg.github.com/plasmnetwork/zkrollups/prover:latest
    docker rmi docker.pkg.github.com/plasmnetwork/zkrollups/prover

    echo "Prepare Postgres And Integration Container Images..."
    docker build ts-tests/tests/zksync/core/lib/storage/migrations -t docker.pkg.github.com/plasmnetwork/zkrollups/postgres:latest
    docker build ts-tests -t docker.pkg.github.com/plasmnetwork/zkrollups/ts-tests:latest
    docker push docker.pkg.github.com/plasmnetwork/zkrollups/postgres:latest
    docker push docker.pkg.github.com/plasmnetwork/zkrollups/ts-tests:latest
else
    echo "Build Server And Prover..."
    DOCKER_BUILDKIT=1 docker build --ssh default=$HOME/.ssh/id_rsa -f ts-tests/tests/zksync/docker/server/Dockerfile ts-tests/tests/zksync -t zksync/server
    DOCKER_BUILDKIT=1 docker build --ssh default=$HOME/.ssh/id_rsa -f ts-tests/tests/zksync/docker/prover/Dockerfile ts-tests/tests/zksync -t zksync/prover
fi
