FROM alpine:3

MAINTAINER Oleg Kovalenko <monstrenyatko@gmail.com>

RUN apk update && apk upgrade && \
    apk add --no-cache transmission-daemon curl bash su-exec shadow && \
    rm -rf /root/.cache && mkdir -p /root/.cache && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

COPY run.sh app-entrypoint.sh /
RUN chmod +x /run.sh /app-entrypoint.sh

COPY settings.json /var/lib/transmission/config/

HEALTHCHECK --interval=60s --timeout=15s --start-period=120s \
    CMD curl -L 'https://api.ipify.org'

VOLUME ["/var/lib/transmission/config", "/var/lib/transmission/downloads"]

EXPOSE 9091

WORKDIR /var/lib/transmission

ENTRYPOINT ["/run.sh"]
CMD ["transmission-daemon-app", "--foreground", "--config-dir", "/var/lib/transmission/config"]
