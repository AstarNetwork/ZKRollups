#!/bin/sh

cd ts-tests
yarn
yarn build
cp tests/config/test.json tests/config/eth.json
cp .env.test .env

(
cd tests/zksync
yarn
)
yarn mocha -r ts-node/register 'tests/**/test-contract.ts'
yarn mocha -r ts-node/register 'tests/**/test-balance.ts'
