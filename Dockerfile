FROM alpine:3.10
RUN apk add --no-cache rsync clamav-daemon clamav-libunrar && \
    sed -i '/LogFile/s/^/#/' /etc/clamav/*.conf && \
    sed -i '/^#LogSyslog/s/^#//' /etc/clamav/*.conf && \
    sed -i '/^#TCPSocket/s/^#//' /etc/clamav/clamd.conf && \
    sed -i '/^#Foreground/s/^#//' /etc/clamav/clamd.conf && \
    mkdir -p /run/clamav && \
    chown clamav:clamav /run/clamav

COPY src /usr/local/bin
WORKDIR /var/lib/clamav
USER clamav:clamav
# creating a minimal database so daemon can start right away
RUN echo "48c4533230e1ae1c118c741c0db19dfb:17387:test.exe" > firststart.hdb

EXPOSE 3310/tcp
VOLUME /var/lib/clamav /run/clamav

CMD start.sh
HEALTHCHECK CMD health.sh
