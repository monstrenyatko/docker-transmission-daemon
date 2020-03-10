#!/bin/sh

# Debug output
set -x

# Exit on error
set -e

export APP_USERNAME=transmission
export APP_GROUPNAME=transmission

if [ -n "$TRANSMISSION_DAEMON_GID" ] && [ "$TRANSMISSION_DAEMON_GID" !=  "$(id $APP_GROUPNAME -g)" ]; then
  set +e
  # delete all users using requested GID
  cut -d: -f1,4 /etc/passwd | grep -w $TRANSMISSION_DAEMON_GID |
  while read name_gid
  do
    name=$(echo $name_gid | cut -d: -f1)
    deluser $name
  done
  # delete group with requested GID
  delgroup $(getent group $TRANSMISSION_DAEMON_GID | cut -d: -f1)
  set -e
  # update GID
  groupmod --gid $TRANSMISSION_DAEMON_GID $APP_GROUPNAME
  usermod --gid $TRANSMISSION_DAEMON_GID $APP_USERNAME
fi

if [ -n "$TRANSMISSION_DAEMON_UID" ] && [ "$TRANSMISSION_DAEMON_UID" !=  "$(id $APP_USERNAME -u)" ]; then
  usermod --uid $TRANSMISSION_DAEMON_UID $APP_USERNAME
fi

if [ "$1" = 'transmission-daemon-app' ]; then
  shift;
  mkdir -p /var/run/transmission /var/lib/transmission/config /var/lib/transmission/downloads /var/lib/transmission/downloads/watch
  chown -R transmission:transmission /var/run/transmission /var/lib/transmission
  exec /app-entrypoint.sh transmission-daemon "$@"
fi

exec "$@"
