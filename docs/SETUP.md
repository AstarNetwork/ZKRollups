# How to setup Zksync
Describe how to setup Zksync env on Ubuntu.

## Abstract

1. Install Dependencies
2. Zksync Init
3. Build Zksync contracts

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
