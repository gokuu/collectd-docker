FROM debian:latest


RUN apt-get update 
RUN apt-get install -y collectd
RUN apt-get clean

ENTRYPOINT ["collectd", "-f"]
