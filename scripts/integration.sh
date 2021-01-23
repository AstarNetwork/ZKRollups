#!/usr/bin/env bash

docker-compose up -d substrate operator prover postgres ticker
docker-compose up -d test
