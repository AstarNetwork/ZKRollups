FROM node:14.15.4-alpine

WORKDIR /app

COPY package.json .
COPY yarn.lock .

RUN apk add git &&\
    yarn install --frozen-lockfile

ENTRYPOINT yarn test
