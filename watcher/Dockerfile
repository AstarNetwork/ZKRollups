FROM rust:1.40

WORKDIR /app

COPY . .

RUN rustup default nightly &&\
    cargo build

ENTRYPOINT sleep 5000
