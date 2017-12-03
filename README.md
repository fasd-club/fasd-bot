# FASD Bot

This is our Telegram bot, created with the goal of providing utilities and fun to the group.

<img src="https://image.ibb.co/f24syR/3ca6c26c_e812_4e24_b3f6_bd279a2e0cd4.jpg" width="100"/>

## Get Started
- Store the bot token into an environment variable named `TELEGRAM_TOKEN`.
- Build the bot running `make build`.
- Start the bot running `make start`.

The code will be automatically hot reloaded in development environment, but if you install new dependencies you should restart the bot running `make restart`.

## Deployment

Once this project has just been created and we have a lot of other priorities, the deploy process is quite simple yet.

The changes are applied to production every time something is pushed to master branch.

**How it works?**

1. Changes are pushed to master branch.
2. Github sends a webhook to deploy endpoint of production server, that works based on execution of `deploy/deploy.js`.
3. The script `deploy.sh` is executed, making the server pull the changes and restart the  applications.

## Built With

* [NodeJS](https://nodejs.org) - The framework
* [npm](www.npmjs.com) - Dependency management
* [gith](https://github.com/danheberden/gith) - Handle Github webhooks
* [wunderground-api-client](https://github.com/lukewendling/wunderground-api-client) - Client for Wunderground API
* [node-telegram-bot-api](https://github.com/yagop/node-telegram-bot-api) - Client for Telegram Bot API
