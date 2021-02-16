FROM node:14.15.4-alpine

WORKDIR /app

RUN apk add git curl postgresql

COPY . .

RUN yarn

RUN cd tests/zksync &&\
    yarn &&\
    yarn build

ENTRYPOINT yarn build &&\
           yarn setup &&\
           sh scripts/wait_prover.sh yarn integration
