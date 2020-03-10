#!/bin/bash

# Debug output
set -x

# Exit on error
set -e

if [ "$(id -u)" = '0' -a -n "$APP_USERNAME" -a "$APP_USERNAME" != 'root' ]; then
  exec su-exec "$APP_USERNAME" "$BASH_SOURCE" "$@"
fi

exec "$@"
