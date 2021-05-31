#!/bin/bash

# Exit on error
set -e

# Load functions
source /scripts/update-app-user-uid-gid.sh

# Debug output
set -x

update_user_gid $APP_USERNAME $APP_GROUPNAME $APP_GID
update_user_uid $APP_USERNAME $APP_UID

if [ -n "$NET_GW" ]; then
  ip route del default || true
  ip route add default via $NET_GW
fi

if [ "$1" = $APP_NAME ]; then
  shift;
  mkdir -p /var/run/transmission /var/lib/transmission/config /var/lib/transmission/downloads /var/lib/transmission/watch

  if [ ! -f /var/lib/transmission/config/settings.json ]; then
    cp /app/settings.json.default /var/lib/transmission/config/settings.json
  fi

  chown $APP_USERNAME /var/lib/transmission /var/lib/transmission/downloads /var/lib/transmission/watch
  chown -R $APP_USERNAME /var/run/transmission /var/lib/transmission/config
  exec /scripts/app-entrypoint.sh $APP_BIN "$@"
fi

exec "$@"
