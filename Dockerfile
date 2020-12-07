FROM rustlang/rust:nightly

WORKDIR /app

COPY evmchain .

RUN apt-get update -y && \
	apt-get install -y cmake pkg-config libssl-dev git gcc build-essential clang libclang-dev

RUN rustup target add wasm32-unknown-unknown

RUN rustup toolchain install nightly-2020-08-23 &&\
    rustup target add wasm32-unknown-unknown --toolchain nightly-2020-08-23 &&\
    cargo +nightly-2020-08-23 build

COPY zkrollup zkrollup

RUN apt-get update &&\
    apt-get -y install curl &&\
    curl -sL https://deb.nodesource.com/setup_12.x | bash - &&\
    apt-get -y install nodejs

RUN cd zkrollup &&\
    npm i &&\
    npm run test
