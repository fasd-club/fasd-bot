# FASD Bot

![Docker image: build + push](https://github.com/fasd-club/fasd-bot/workflows/Docker%20image%3A%20build%20+%20push/badge.svg)

This is our Telegram bot, created with the goal of providing utilities and fun to the group.

<img src="https://image.ibb.co/f24syR/3ca6c26c_e812_4e24_b3f6_bd279a2e0cd4.jpg" width="100"/>

## Get Started
The bot runs on [Docker](https://docs.docker.com/engine/install/).

Build the Docker image **from the root** of this repository:

```bash
$ docker build -t fasdbot:local .
```

> :bulb: _You can label it however you want for local development. If you change the label, make sure to reuse it in all other Docker commands._

### Env vars

A set of environment variables are needed to run the bot. Copy `.env-example` into `.env` and fill in the values to your needs.

- `TELEGRAM_TOKEN` - Is the minimum **required** to run the bot. You can get an API Token from [The BotFather](https://t.me/botfather).
- `STICKER_COLLECTION_NAME` - Neeeded only to manage a given sticker collection.
- `STICKER_COLLECTION_OWNER_ID` - Neeeded only to manage a given sticker collection.

Once you have your `.env` file properly set up, you can feed it to container when running it:

```bash
docker run -it --env-file=.env fasdbot:local
```

Your local bot should be up and running! You should be able message it directly on Telegram. To check if it's running properly, send it this message:

```
-fasd- healthcheck
```

## Deployment

### Docker image

Pushes to `master` automatically triggers a [GitHub Action](https://github.com/fasd-club/fasd-bot/actions) that will build the docker image and push it as [`fasdclub/telegram-bot:latest` to Docker Hub](https://hub.docker.com/repository/docker/fasdclub/telegram-bot).

Images are not currently versioned (they're all tagged as `:latest`) as there's not many changes in the bot currently. If the need ever comes, we shuold start using git tags to [version-tag the builds automatically](https://docs.docker.com/ci-cd/github-actions/#push-tagged-versions-to-docker-hub).

### Running the container in Kubernetes@Okteto

Integration with [Okteto](https://cloud.okteto.com) is set via `okteto-pipeline.yml` and deploys should be automated from git pushes.
