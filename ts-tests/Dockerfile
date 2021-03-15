FROM node:14.15.4-alpine

ENV ZKSYNC_HOME=/app/tests/zksync

ENV PATH=$ZKSYNC_HOME/bin:$PATH

WORKDIR /app

RUN apk add git curl postgresql

COPY . .

RUN cd tests/zksync/sdk/zksync.js &&\
    yarn &&\
    yarn build

RUN yarn &&\
    yarn build &&\
    mkdir tests/zksync/contracts/build &&\
    cp build/* tests/zksync/contracts/build/

RUN zk

ENTRYPOINT sh scripts/wait_prover.sh yarn integration
