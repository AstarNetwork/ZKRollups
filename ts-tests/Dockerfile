FROM node:14.15.4-alpine

WORKDIR /app

RUN apk add git curl postgresql

COPY . .

RUN yarn &&\
    yarn build

RUN cd tests/zksync/sdk/zksync.js &&\
    yarn

ENTRYPOINT yarn setup &&\
           sleep 5000
        #    sh scripts/wait_prover.sh yarn integration
