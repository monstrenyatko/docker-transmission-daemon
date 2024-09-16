FROM monstrenyatko/alpine:2024-09-09

LABEL maintainer="Oleg Kovalenko <monstrenyatko@gmail.com>"

RUN apk update && \
    apk add transmission-daemon~=4.0.5 && \
    # clean-up
    rm -rf /root/.cache && mkdir -p /root/.cache && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

ENV APP_NAME="transmission-daemon-app" \
    APP_BIN="transmission-daemon" \
    APP_USERNAME="transmission" \
    APP_GROUPNAME="transmission"

COPY run.sh /app/
COPY settings.json /app/settings.json.default
RUN chown -R root:root /app
RUN chmod -R 0744 /app
RUN chmod 0755 /app/run.sh

HEALTHCHECK --interval=60s --timeout=15s --start-period=120s \
    CMD curl -L 'https://api.ipify.org'

VOLUME ["/var/lib/transmission/config", "/var/lib/transmission/downloads"]

EXPOSE 9091

WORKDIR /var/lib/transmission

ENTRYPOINT ["/app/run.sh"]
CMD ["transmission-daemon-app", "--foreground", "--config-dir", "/var/lib/transmission/config"]
