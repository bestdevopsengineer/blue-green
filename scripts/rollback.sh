#!/bin/bash
set -e

NGINX_CONF="nginx/default.conf"

if grep -q "server blue:3000" "$NGINX_CONF"; then
  LIVE="blue"
  TARGET="green"
else
  LIVE="green"
  TARGET="blue"
fi

echo "Current live environment: $LIVE"
echo "Rolling back to: $TARGET"

sed -i "s/server $LIVE:3000/server $TARGET:3000/" "$NGINX_CONF"

docker exec blue-green-nginx nginx -s reload

echo "Rollback completed: $LIVE -> $TARGET"