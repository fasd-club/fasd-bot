#!/bin/bash
if [ "$NODE_ENV" = "production" ]
then
  node app.js
else
  node ./node_modules/nodemon/bin/nodemon.js app.js
fi