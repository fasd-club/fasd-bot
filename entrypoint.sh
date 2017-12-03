#!/bin/sh

set -e

PID=0

# SIGTERM-handler
term_handler() {
	if [ $PID -ne 0 ]; then
		kill -SIGTERM "$PID"
		wait "$PID"
	fi
	exit 143; # 128 + 15 -- SIGTERM
}

# setup handlers
# on callback, kill the last background process, which is `tail -f /dev/null` and execute the specified handler
trap 'kill "$!"; term_handler' SIGTERM

# run application
npm install --silent

if [ "$NODE_ENV" = "production" ]
then
  node app.js &
  PID="$!"
else
  node ./node_modules/nodemon/bin/nodemon.js app.js &
  PID="$!"
fi

while true
do
	tail -f /proc/$PID/fd/1 & wait $PID
	exit 0
done
