.PHONY: cleandocker
cleandocker:
	docker rmi -f $(shell docker images fasd-bot -q | uniq)

.PHONY: build
build:
	docker build . -t fasd-bot:latest

.PHONY: start
start:
	docker run --name fasd-bot --rm -d -v $(shell pwd):/src -e TELEGRAM_TOKEN=$(TELEGRAM_TOKEN) -e NODE_ENV=$(NODE_ENV) fasd-bot:latest

.PHONY: restart
restart:
	docker restart fasd-bot