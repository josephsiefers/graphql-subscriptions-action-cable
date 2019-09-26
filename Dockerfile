FROM node:10.15.1-alpine as node-modules

WORKDIR /tmp

ADD ./package.json /tmp/package.json
ADD ./yarn.lock /tmp/yarn.lock

RUN yarn install --pure-lockfile

FROM node:10.15.1-alpine as dev

#necessary for syncing node_modules locally
RUN apk add rsync

WORKDIR /home/node

VOLUME /home/node/node_modules

COPY --from=node-modules /tmp/node_modules /home/node/node_modules

COPY ./ /home/node

CMD yarn start