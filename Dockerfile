FROM java:8
MAINTAINER Shay Erlichmen "shay@samba.me"

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget

# logstash
ENV LOGSTASH_VERSION 1.5.4

RUN mkdir -p /var/lib ; cd /var/lib ; wget --quiet --no-check-certificate https://download.elasticsearch.org/logstash/logstash/logstash-${LOGSTASH_VERSION}.tar.gz ; tar zxvf logstash-${LOGSTASH_VERSION}.tar.gz ; rm logstash-${LOGSTASH_VERSION}.tar.gz
RUN ln -s /var/lib/logstash-${LOGSTASH_VERSION} /var/lib/logstash
RUN mkdir /conf

VOLUME ["/var/log"]
VOLUME ["/conf"]

WORKDIR /var/lib/logstash
RUN ./bin/plugin install logstash-output-tcp
CMD ["bin/logstash", "agent", "--config", "/conf/*.conf"]
