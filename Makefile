APP?=$(shell basename -s .git $(shell git remote get-url origin))
REGISTRY?=ghcr.io
VERSION?=$(shell git describe --tags --abbrev=0 2>/dev/null || echo "0.0.0")-$(shell git rev-parse --short HEAD)
IMAGE_TAG?=$(shell echo ${REGISTRY}/${APP}:${VERSION} | tr A-Z a-z)

image: build push

build:
	docker build -t ${IMAGE_TAG} .

push:
	docker push ${IMAGE_TAG}

prod:
	docker-compose -f ./docker-compose.production.yml -p prod --env-file ./.env.prod up

sail: 
	./vendor/bin/sail up
