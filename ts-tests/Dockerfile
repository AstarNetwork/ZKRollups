FROM node:14.15.4-alpine

WORKDIR /app

COPY . .
COPY .env.example .env

RUN apk add git &&\
    yarn install --frozen-lockfile &&\
    yarn build

ENTRYPOINT yarn mocha -r ts-node/register 'tests/test-contract.ts' &&\
           yarn mocha -r ts-node/register 'tests/test-balance.ts' &&\
           sleep 5000
