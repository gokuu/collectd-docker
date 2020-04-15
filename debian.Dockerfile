FROM debian:latest

RUN apt-get update && \
  apt-get install -y --no-install-recommends python-pip python-setuptools curl bzip2 gcc build-essential && \
  apt-get clean

RUN curl -qLs https://storage.googleapis.com/collectd-tarballs/collectd-5.10.0.tar.bz2 | \
  tar -xv --bzip2

WORKDIR /collectd-5.10.0

RUN ./configure
RUN make all install

RUN mkdir -p /usr/share/collectd/docker-collectd-plugin
ADD https://raw.githubusercontent.com/signalfx/docker-collectd-plugin/master/dockerplugin.db /usr/share/collectd/docker-collectd-plugin/
ADD https://raw.githubusercontent.com/signalfx/docker-collectd-plugin/master/dockerplugin.py /usr/share/collectd/docker-collectd-plugin/
ADD https://raw.githubusercontent.com/signalfx/docker-collectd-plugin/master/requirements.txt /usr/share/collectd/docker-collectd-plugin/

RUN pip install wheel
RUN pip install -r /usr/share/collectd/docker-collectd-plugin/requirements.txt

ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /
RUN chmod +x /wait-for-it.sh

WORKDIR /opt/collectd

ENTRYPOINT ["./sbin/collectd", "-f"]
