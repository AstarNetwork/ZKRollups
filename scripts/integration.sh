#!/usr/bin/env bash

echo "Copy Contract File..."
(
cd ts-tests
yarn
yarn build
)

echo "Start Integration Test..."
docker-compose up -f docker-compose.test.yml -d substrate operator prover postgres ticker
docker-compose up -f docker-compose.test.yml test
