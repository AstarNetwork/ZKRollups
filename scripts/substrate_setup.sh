#!/bin/sh

cd ts-tests
yarn mocha -r ts-node/register 'tests/**/test-contract.ts'
yarn mocha -r ts-node/register 'tests/**/test-balance.ts'