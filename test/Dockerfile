FROM node:12.0.0-alpine

WORKDIR /app

COPY package.json .
COPY yarn.lock .

RUN yarn install --frozen-lockfile

ENTRYPOINT sleep 5000
