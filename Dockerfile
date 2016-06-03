FROM docker-registry.eyeosbcn.com/alpine6-node-base
MAINTAINER eyeos

ENV WHATAMI redis

COPY start.sh /tmp/start.sh

RUN apk update && \
	/scripts-base/installExtraBuild.sh redis && \
	chmod +x /tmp/start.sh && \
	curl -L https://releases.hashicorp.com/serf/0.6.4/serf_0.6.4_linux_amd64.zip -o serf.zip && \
	unzip serf.zip && mv serf /usr/bin/serf && rm serf.zip && \
	npm install -g eyeos-run-server eyeos-tags-to-dns eyeos-service-ready-notify-cli && \
    /scripts-base/deleteExtraBuild.sh && \
	rm -rf /etc/ssl /var/cache/apk/*

COPY dnsmasq.conf /etc/dnsmasq.d/
COPY dnsmasq_generic.conf /etc/dnsmasq.conf
CMD /tmp/start.sh

EXPOSE 6379
