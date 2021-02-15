#!/usr/bin/env bash

echo "Copy Contract File..."
(
cd ts-tests
yarn
yarn build
)

if [[ $1 = "actions" ]]; then
    echo "Pull Container Images..."
    docker pull docker.pkg.github.com/plasmnetwork/zkrollups/substrate:latest
    docker pull docker.pkg.github.com/plasmnetwork/zkrollups/ts-tests:latest
    docker pull docker.pkg.github.com/plasmnetwork/zkrollups/operator:latest
    docker pull docker.pkg.github.com/plasmnetwork/zkrollups/prover:latest
    docker pull docker.pkg.github.com/plasmnetwork/zkrollups/postgres:latest
    docker pull matterlabs/dev-ticker:latest

    echo "Start Integration Test..."
    docker-compose -f docker-compose.test.yml up -d substrate operator prover postgres ticker
    docker-compose -f docker-compose.test.yml up test
else
    echo "Start Integration Test..."
    docker-compose build
    docker-compose up -d substrate operator prover postgres ticker
    docker-compose up test
fi
