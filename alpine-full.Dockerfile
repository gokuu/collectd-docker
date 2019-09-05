# Builder image

FROM alpine:latest AS builder

WORKDIR /

RUN apk add curl build-base
RUN apk add --update linux-headers


RUN curl -qLs https://storage.googleapis.com/collectd-tarballs/collectd-5.9.0.tar.bz2 | \
  tar -xv --bzip2

WORKDIR /collectd-5.9.0

# Extra necessary packages
RUN apk add libatasmart libatasmart-dev

RUN ./configure --enable-smart
RUN make all install

# Destination image

FROM alpine:latest

COPY --from=builder /opt/collectd /opt/collectd

WORKDIR /opt/collectd

CMD ["./sbin/collectd", "-f"]
