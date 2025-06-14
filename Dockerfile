FROM alpine:3.22

LABEL org.opencontainers.image.authors="Simon Rupf <simon@rupf.net>" \
      org.opencontainers.image.source=https://github.com/simonrupf/docker-clamd \
      org.opencontainers.image.version="${VERSION}"

RUN apk upgrade --no-cache && \
    apk add --no-cache rsync clamav-daemon clamav-libunrar tzdata && \
    sed -i '/^LogFile/s/^/#/;/^#LogSyslog/s/^#//' /etc/clamav/*.conf && \
    sed -i '/^#TCPSocket/s/^#//;/^#Foreground/s/^#//;/^#ConcurrentDatabaseReload/s/^#//' \
        /etc/clamav/clamd.conf && \
    sed -i '/LogFile/s/^/#/' /etc/clamav/*.conf && \
    sed -i '/^#LogSyslog/s/^#//' /etc/clamav/*.conf && \
    sed -i '/^#TCPSocket/s/^#//' /etc/clamav/clamd.conf && \
    sed -i '/^#Foreground/s/^#//' /etc/clamav/clamd.conf && \
    mkdir -p /run/clamav && \
    chown clamav:clamav /run/clamav && \
    rm /usr/bin/clamdscan

COPY src /usr/local/bin
WORKDIR /var/lib/clamav
USER clamav:clamav
EXPOSE 3310/tcp
VOLUME /var/lib/clamav /run/clamav

CMD start.sh
HEALTHCHECK CMD health.sh
