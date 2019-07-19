FROM alpine:3.10
RUN apk add --no-cache rsync clamav-daemon clamav-libunrar && \
    sed -i '/LogFile/s/^/#/' /etc/clamav/*.conf && \
    sed -i '/^#LogSyslog/s/^#//' /etc/clamav/*.conf && \
    sed -i '/^#TCPSocket/s/^#//' /etc/clamav/clamd.conf && \
    sed -i '/^#Foreground/s/^#//' /etc/clamav/clamd.conf && \
    mkdir -p /run/clamav && \
    chown clamav:clamav /run/clamav

COPY src /usr/local/bin

USER clamav:clamav

EXPOSE 3310/tcp
VOLUME /var/lib/clamav /run/clamav

CMD start.sh
HEALTHCHECK --start-period=350s CMD health.sh
