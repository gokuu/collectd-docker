# Builder image

FROM alpine:latest AS builder

WORKDIR /

RUN apk add curl build-base
RUN apk add --update linux-headers

RUN curl -qLs https://storage.googleapis.com/collectd-tarballs/collectd-5.11.0.tar.bz2 | \
  tar -xv --bzip2

WORKDIR /collectd-5.11.0

# Extra necessary packages
RUN apk add libatasmart libatasmart-dev

RUN ./configure --enable-smart
RUN make all install

# Destination image

FROM alpine:latest

# Extra necessary packages
RUN apk add libatasmart

# wait-for-it.sh script
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /
RUN chmod +x /wait-for-it.sh

COPY --from=builder /opt/collectd /opt/collectd

WORKDIR /opt/collectd

ENTRYPOINT ["./sbin/collectd", "-f"]
