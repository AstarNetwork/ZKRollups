FROM ubuntu:18.04

ENV SNAPCRAFT_SETUP_CORE=1

ENV container docker

COPY scripts .

RUN echo "Install Official Packages Dependencies" &&\
    apt-get update &&\
    apt-get install sudo -y &&\
    sudo apt-get update &&\
    sudo apt-get install curl apt-transport-https ca-certificates software-properties-common libpq-dev build-essential pkg-config libssl-dev postgresql-client axel -y

RUN echo "Install PPA Packages Dependencies" &&\
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&\
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" &&\
    curl -O https://download.docker.com/linux/ubuntu/dists/bionic/pool/edge/amd64/containerd.io_1.2.2-3_amd64.deb &&\
    curl -sL https://deb.nodesource.com/setup_14.x | sudo bash - &&\
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list &&\
    sudo add-apt-repository ppa:ethereum/ethereum -y &&\
    sudo apt-get install ./containerd.io_1.2.2-3_amd64.deb -y &&\
    sudo apt-get update &&\
    sudo apt-get install docker-ce nodejs yarn -y

RUN echo "Install solc From Snap" &&\
    sudo apt-get update &&\
    sudo apt-get install snapd=2.48+18.04 systemd -y

ENTRYPOINT sleep 5000
    #  &&\
    # snap --version &&\
    # sudo snap install solc

# RUN echo "Install docker-compose And Give Privilege To Docker" &&\
#     sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose &&\
#     sudo chmod a+x /usr/local/bin/docker-compose &&\
#     sudo usermod -aG docker root &&\
#     sudo newgrp docker

# RUN sh ubuntu2.sh
