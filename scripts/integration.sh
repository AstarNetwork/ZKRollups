#!/usr/bin/env bash

sh scripts/containers.sh
docker-compose build
docker-compose up -d substrate operator prover postgres ticker
docker-compose up test
