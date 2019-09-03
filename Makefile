.PHONY: build-debian
build-debian:
	docker build -f debian.Dockerfile . --tag pedromr/collectd:latest

.PHONY: build-alpine
build-alpine:
	docker build -f alpine.Dockerfile . --tag pedromr/collectd:latest-alpine
