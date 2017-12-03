#!/bin/bash

cd $FASD_BOT_DIR_PATH && git pull origin master

docker ps -q -f "name=fasd-bot" | xargs --no-run-if-empty docker stop $1

make cleandocker build

docker run --name fasd-bot --rm -d -v $(echo $FASD_BOT_DIR_PATH):/src -e TELEGRAM_TOKEN=$(echo $TELEGRAM_TOKEN) -e WUNDERGROUND_TOKEN=$(echo $WUNDERGROUND_TOKEN) -e NODE_ENV=$(echo $NODE_ENV) fasd-bot:latest

npm install --prefix=./deploy
pm2 reload deploy
