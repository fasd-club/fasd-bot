# FASD Bot

This is our Telegram bot, created with the goal of providing utilities and fun to the group.

<img src="https://image.ibb.co/f24syR/3ca6c26c_e812_4e24_b3f6_bd279a2e0cd4.jpg" width="100"/>

## Get Started
The bot runs on [Docker](https://docs.docker.com/engine/install/).

Build the Docker image **from the root** of this repository:

```bash
$ docker build -t fasdbot:local .
```

> :bulb: _You can label it however you want for local development. If you change the label, make sure to reuse it in all other Docker commands._

Make sure to specify your [Telegram Bot API Token](https://core.telegram.org/bots) via the `TELEGRAM_TOKEN` env var. You can get an API Token from [The BotFather](https://t.me/botfather) if you don't have one.

```bash
# docker run -it -e TELEGRAM_TOKEN=YourTelegramBotAPIKeyGoesHere your-label:your-tag
docker run -it -e TELEGRAM_TOKEN=YourTelegramBotAPIKeyGoesHere fasdbot:local
```

Your local bot should be up and running! You should be able message it directly on Telegram. To check if it's running properly, send it this message:

```
-fasd- healthcheck
```

## Deployment

// TODO: Specify once it's defined
