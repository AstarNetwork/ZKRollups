FROM node:14.15.4-alpine

WORKDIR /app

COPY . .

RUN apk add git curl postgresql &&\
    yarn install &&\
    yarn build

ENTRYPOINT yarn mocha -r ts-node/register 'tests/test-contract.ts' &&\
           yarn mocha -r ts-node/register 'tests/test-balance.ts' &&\
           sh scripts/wait_prover.sh yarn integration
