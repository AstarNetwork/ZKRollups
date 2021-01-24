#!/bin/sh

git clone https://github.com/PlasmNetwork/ZKRollups
cd ZKRollups/zksync

docker-compose up -d substrate postgres ticker
