# ZK Rollups
![EVM](https://github.com/staketechnologies/ZKRollups/workflows/EVM/badge.svg)![Rust](https://github.com/staketechnologies/ZKRollups/workflows/Rust/badge.svg)  
ZK Rollups pallet implementation

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
