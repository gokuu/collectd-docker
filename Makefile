.PHONY: debian
debian:
	docker build -f debian.Dockerfile . --tag pedromr/collectd:latest

.PHONY: alpine
alpine:
	docker build -f alpine.Dockerfile . --tag pedromr/collectd:alpine

.PHONY: alpine-full
alpine-full:
	docker build -f alpine-full.Dockerfile . --tag pedromr/collectd:alpine-full
