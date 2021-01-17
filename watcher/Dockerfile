FROM rust:1.40

WORKDIR /app

COPY . .

RUN rustup default nightly &&\
    cargo build

ENTRYPOINT cargo run
