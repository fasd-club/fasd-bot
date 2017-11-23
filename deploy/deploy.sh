#!/bin/bash

cd $FASD_BOT_DIR_PATH && git pull origin master
pm2 restart app
