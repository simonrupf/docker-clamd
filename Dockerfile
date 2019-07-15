FROM alpine:3.10
RUN apk add --no-cache rsync clamav-daemon clamav-libunrar

RUN sed -i '/LogFile/s/^/#/' /etc/clamav/*.conf
RUN sed -i '/^#LogSyslog/s/^#//' /etc/clamav/*.conf
RUN sed -i '/^#TCPSocket/s/^#//' /etc/clamav/clamd.conf
RUN sed -i '/^#Foreground/s/^#//' /etc/clamav/clamd.conf

RUN mkdir -p /run/clamav
RUN chown clamav:clamav /run/clamav

COPY src /usr/local/bin

USER clamav:clamav

EXPOSE 3310/tcp
VOLUME /var/lib/clamav /run/clamav

CMD start.sh
HEALTHCHECK --start-period=350s CMD health.sh
