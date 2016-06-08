FROM redis:3.0-alpine
MAINTAINER eyeos
ENV WHATAMI redis

RUN apk update && \
    apk add curl make gcc g++ git python unzip dnsmasq nodejs && \
    npm install -g eyeos-run-server eyeos-tags-to-dns eyeos-service-ready-notify-cli && \
    curl -L https://releases.hashicorp.com/serf/0.6.4/serf_0.6.4_linux_amd64.zip -o serf.zip && \
    unzip serf.zip && mv serf /usr/bin/serf && rm -f serf.zip && \
    apk del curl make gcc g++ git python unzip && \
    npm remove -g npm && rm -r /root/.npm && \
    rm -r /etc/ssl /var/cache/apk/*

COPY dnsmasq.conf /etc/dnsmasq.d/
COPY dnsmasq_generic.conf /etc/dnsmasq.conf

EXPOSE 6379

COPY start.sh /tmp/start.sh

CMD /tmp/start.sh
