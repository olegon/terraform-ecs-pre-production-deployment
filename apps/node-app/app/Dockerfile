FROM node:22-alpine

EXPOSE 8080

RUN apk add curl --no-cache

WORKDIR /opt/app

COPY ./src/package*.json ./

RUN npm install

COPY ./src .

USER nobody

CMD [ "node", "index.mjs" ]
