FROM node:alpine

COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

WORKDIR /src
ENTRYPOINT ["/entrypoint.sh"]
