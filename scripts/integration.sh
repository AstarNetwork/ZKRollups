#!/usr/bin/env bash

docker-compose build
sh scripts/containers.sh
docker-compose up -d substrate operator prover postgres ticker
docker-compose up test
