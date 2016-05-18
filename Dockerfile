FROM redis:3.0
MAINTAINER eyeos

ENV WHATAMI redis

COPY start.sh /tmp/start.sh

RUN \
	apt-get update && \
	apt-get install -y curl && \
	curl -sL https://deb.nodesource.com/setup_0.10 | bash - && \
	apt-get install -y unzip nodejs build-essential git build-essential && \
	chmod +x /tmp/start.sh && \
	curl -L https://releases.hashicorp.com/serf/0.6.4/serf_0.6.4_linux_amd64.zip -o serf.zip && \
	unzip serf.zip && \
	mv serf /usr/bin/serf && \
	npm install -g npm@2.14.4 && \
	npm install -g eyeos-run-server eyeos-tags-to-dns eyeos-service-ready-notify-cli && \
	apt-get clean && \
	apt-get -y remove --purge curl git build-essential && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/*

COPY dnsmasq.conf /etc/dnsmasq.d/
CMD /tmp/start.sh

EXPOSE 6379
