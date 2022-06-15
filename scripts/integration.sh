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
    docker pull matterlabs/dev-ticker:latest &
    docker pull docker.pkg.github.com/astarnetwork/zkrollups/prover:latest &
    docker pull docker.pkg.github.com/astarnetwork/zkrollups/operator:latest &
    docker pull docker.pkg.github.com/astarnetwork/zkrollups/postgres:latest &
    docker pull docker.pkg.github.com/astarnetwork/zkrollups/test:latest &
    docker pull docker.pkg.github.com/astarnetwork/zkrollups/setup:latest
    docker pull docker.pkg.github.com/astarnetwork/zkrollups/substrate:latest

    echo "Start Integration Test..."
    docker-compose -f docker-compose.test.yml up -d substrate postgres ticker setup
    docker-compose -f docker-compose.test.yml up -d operator prover
    docker-compose -f docker-compose.test.yml up test
else
    sh scripts/build.sh
    echo "Start Integration Test..."
    docker-compose build
    docker-compose up -d substrate postgres ticker setup
    docker-compose up -d operator prover
    docker-compose up test
fi
