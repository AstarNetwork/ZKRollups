# How to setup Zksync
Describe how to setup Zksync env on Ubuntu.

## Abstract

1. Install Dependencies
2. Zksync Init
3. Build Zksync contracts

## TLDR
I did following command on AWS Ubuntu 18.04 and **this didn't work on Docker Ubuntu image**.
```
$ wget https://raw.githubusercontent.com/PlasmNetwork/ZKRollups/master/zkrollup/scripts/ubuntu1.sh
$ wget https://raw.githubusercontent.com/PlasmNetwork/ZKRollups/master/zkrollup/scripts/ubuntu2.sh
$ sh ubuntu1.sh
$ sh ubuntu2.sh
```

## Install Dependencies

Zksync CLI needs some dependencies.
- Build depencencies
- Docker and docker-compose
- Rust and cargo package
- Nodejs and npm
- solc and etc...

## Zksync Init

Clone Zksync project and init environment.
```
$ zk init
```
If depencencies are not enough, the process will be reverted.

## Build Contracts

```
$ zk contract build
```
The contracts will be `zksync/contracts/contracts`.
