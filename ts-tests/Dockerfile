FROM node:14.15.4-alpine

WORKDIR /app

COPY . .

RUN apk add git &&\
    yarn install &&\
    yarn build

ENTRYPOINT yarn mocha -r ts-node/register 'tests/test-contract.ts' &&\
           yarn mocha -r ts-node/register 'tests/test-balance.ts' &&\
           sleep 5000
