FROM node:14.15.4-alpine

ENV ZKSYNC_HOME=/app/src/zksync

ENV PATH=$ZKSYNC_HOME/bin:$PATH

WORKDIR /app

RUN apk add git curl postgresql

COPY . .

RUN cd src/zksync/sdk/zksync.js &&\
    yarn &&\
    yarn build

RUN yarn &&\
    yarn build &&\
    mkdir src/zksync/contracts/build &&\
    cp build/* src/zksync/contracts/build/ &&\
    touch src/zksync/etc/env/dev.env

RUN zk

ENTRYPOINT sh scripts/wait_prover.sh yarn integration
