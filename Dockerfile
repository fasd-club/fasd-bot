FROM node:alpine

COPY package.json /src/
WORKDIR /src

CMD npm install npm@latest -g && \
    yarn && \
    sh ./start.sh