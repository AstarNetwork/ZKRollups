#!/usr/bin/env bash

echo "Copy Contract File..."
(
cd ts-tests
yarn
yarn build
)

echo "Start Integration Test..."
docker-compose -f docker-compose.test.yml up -d substrate operator prover postgres ticker
docker-compose -f docker-compose.test.yml up test
