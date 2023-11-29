include .env.example
-include .env

SERVICE := PARANODE DOCS
bold := $(shell tput bold)
sgr0 := $(shell tput sgr0)

# Dev
.PHONY: dev
dev:
	[ ! -f .env ] && cp .env.example .env || true
	npm run start