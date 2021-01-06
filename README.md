## Project Overview :page_facing_up:
![EVM](https://github.com/PlasmNetwork/ZKRollups/workflows/EVM/badge.svg)![Rust](https://github.com/PlasmNetwork/ZKRollups/workflows/Rust/badge.svg)  
We believe that ZK Rollup is the killer layer2 solution in the coming months and some of the top projects will use this technology to make DApps scalable. 

ZK Rollup is valuable for Polkadot Parachain as described below.
1. Bringing vertical off-chain scalability without sacrificing on-chain data availability, security and privacy (×3-10 scalability).
1. Handling smart contracts on layer2.
1. Sharding plus Rollups will be the future. Polkadot has the sharding ish architecture but it doesn't have Rollups yet.
1. Some of the great Ethereum projects have already started using Rollups. If we could build Rollups on Substeate/Polkadot, we would help them build applications on Polkdot Parachain like Plasm Network.

## Milestone1
Our milestone1 is to deploy [matter-labs](https://github.com/matter-labs/zksync) solidity contracts and test them on a substrate-based chain.

| Number | Deliverable | Specification |
| ------------- | ------------- | ------------- |
| 1. | Deploy ZK Rollup Contract on Substrate | Deploy [matter-labs](https://github.com/matter-labs/zksync) solidity contracts on substrate evm |  
| 2. | Integration Test on Substrate | Test for all contracts and sidechain network actors |  
| 3. | Documentation | Document which describes how to test ZK Rollup on substrate |

## Build
```
$ sh scripts/build.sh
```
## Start
```
$ ./target/release/node-template purge-chain --dev
$ ./target/release/node-template --dev
```
## Test
```
$ sh scripts/test.sh
```
## Docker
```
$ docker build .
```
