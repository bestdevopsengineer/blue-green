#!/bin/bash
set -e

NGINX_CONF="nginx/default.conf"

if grep -q "server green:3000" "$NGINX_CONF"; then
  LIVE="green"
  TARGET="blue"
  TARGET_PORT="3001"
else
  LIVE="blue"
  TARGET="green"
  TARGET_PORT="3002"
fi

echo "Live environment: $LIVE"
echo "Deploying target environment: $TARGET"

docker compose build "$TARGET"
docker compose up -d "$TARGET"

echo "Checking health for $TARGET..."
if curl -f "http://localhost:${TARGET_PORT}/health"; then
  echo "Health check passed"
else
  echo "Health check failed. Keeping traffic on $LIVE"
  exit 1
fi

sed -i "s/server $LIVE:3000/server $TARGET:3000/" "$NGINX_CONF"

docker exec blue-green-nginx nginx -s reload

echo "Traffic switched from $LIVE to $TARGET"