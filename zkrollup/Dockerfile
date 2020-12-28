FROM ubuntu:18.04

WORKDIR /app

COPY scripts .

RUN su root

RUN apt-get update &&\
    apt-get install apt-transport-https ca-certificates curl software-properties-common libpq-dev build-essential pkg-config libssl-dev postgresql-client axel -y

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - &&\
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" &&\
    curl -O https://download.docker.com/linux/ubuntu/dists/bionic/pool/edge/amd64/containerd.io_1.2.2-3_amd64.deb &&\
    curl -sL https://deb.nodesource.com/setup_14.x | bash - &&\
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
    add-apt-repository ppa:ethereum/ethereum &&\
    apt-get install ./containerd.io_1.2.2-3_amd64.deb

RUN apt-get update &&\
    apt-get install docker-ce nodejs yarn solc -y

RUN sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose &&\
    sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y &&\
    sudo chmod a+x /usr/local/bin/docker-compose

RUN . $HOME/.cargo/env &&\
    cargo install diesel_cli --no-default-features --features postgres &&\
    cargo install --version=0.2.0 sqlx-cli

RUN git clone https://github.com/matter-labs/zksync

COPY zksync/infrastructure/zk/build zksync/infrastructure/zk/build

RUN cd zksync/infrastructure/zk &&\
    npm i

ENV PATH=$HOME/.cargo/bin:$PATH
ENV ZKSYNC_HOME=/app/zksync
ENV PATH=$ZKSYNC_HOME/bin:$PATH

RUN usermod -aG docker root

RUN . $HOME/.cargo/env &&\
    zk init
