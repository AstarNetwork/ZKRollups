#!/usr/bin/env bash

echo "Submodule Cloning..."
git submodule update --init --recursive

echo "Build ZkSync Contracts..."
(
cd test
yarn
yarn build
)

if [ "$1" = "actions" ]; then
    echo "Pull Container Images..."
    docker pull docker.pkg.github.com/plasmnetwork/zkrollups/substrate:latest
    docker pull docker.pkg.github.com/plasmnetwork/zkrollups/operator:latest
    docker pull docker.pkg.github.com/plasmnetwork/zkrollups/prover:latest
    docker pull docker.pkg.github.com/plasmnetwork/zkrollups/postgres:latest
    docker pull docker.pkg.github.com/plasmnetwork/zkrollups/test:latest
    docker pull docker.pkg.github.com/plasmnetwork/zkrollups/setup:latest
    docker pull matterlabs/dev-ticker:latest

    echo "Start Integration Test..."
    docker-compose -f docker-compose.test.yml up -d substrate postgres ticker setup
    docker-compose -f docker-compose.test.yml up -d operator prover
    docker-compose -f docker-compose.test.yml up test
else
    sh scripts/build.sh
    echo "Start Integration Test..."
    docker-compose build
    docker-compose up -d substrate operator prover postgres ticker setup
    docker-compose up test
fi
