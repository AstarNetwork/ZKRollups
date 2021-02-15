#!/usr/bin/env bash

echo "Copy Contract File..."
(
cd ts-tests
yarn
yarn build
)

echo "Pull Container Images..."
docker pull docker.pkg.github.com/plasmnetwork/zkrollups/substrate:latest \
            docker.pkg.github.com/plasmnetwork/zkrollups/ts-tests:latest \
            docker.pkg.github.com/plasmnetwork/zkrollups/operator:latest \
            docker.pkg.github.com/plasmnetwork/zkrollups/prover:latest \
            docker.pkg.github.com/plasmnetwork/zkrollups/postgres:latest \
            matterlabs/dev-ticker:latest

echo "Start Integration Test..."
docker-compose -f docker-compose.test.yml up -d substrate operator prover postgres ticker
docker-compose -f docker-compose.test.yml up test
