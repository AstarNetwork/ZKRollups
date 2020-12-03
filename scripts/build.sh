#!/usr/bin/env bash

rustup toolchain install nightly-2020-08-23
rustup target add wasm32-unknown-unknown --toolchain nightly-2020-08-23
cd bin/node-template
cargo +nightly-2020-08-23 build --release
