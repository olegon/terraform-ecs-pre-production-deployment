FROM haproxy:lts

EXPOSE 8080

USER root

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

USER haproxy

COPY ./src/haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY ./src/names.txt /etc/haproxy/names.txt
