FROM ubuntu:18.04

WORKDIR /app

COPY scripts .

RUN apt-get update &&\
    apt-get install apt-transport-https ca-certificates curl software-properties-common -y &&\
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - &&\
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" &&\
    curl -O https://download.docker.com/linux/ubuntu/dists/bionic/pool/edge/amd64/containerd.io_1.2.2-3_amd64.deb &&\
    apt-get install ./containerd.io_1.2.2-3_amd64.deb &&\
    apt-get update &&\
    apt-get install docker-ce -y

RUN curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose &&\
    chmod a+x /usr/local/bin/docker-compose

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - &&\
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
    apt-get install nodejs yarn -y

RUN apt-get install axel -y &&\
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN apt-get install postgresql-client -y &&\
    apt-get install libpq-dev build-essential pkg-config libssl-dev -y

RUN . $HOME/.cargo/env &&\
    cargo install diesel_cli --no-default-features --features postgres &&\
    cargo install --version=0.2.0 sqlx-cli

RUN npm install -g solc

COPY zksync .

ENV PATH=$HOME/.cargo/bin:$PATH
ENV ZKSYNC_HOME=/app
ENV PATH=$ZKSYNC_HOME/bin:$PATH

ENTRYPOINT sleep 5000

# RUN zk init
