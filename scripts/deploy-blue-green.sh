#!/bin/bash
set -e

NGINX_CONF="nginx/default.conf"

if grep -q "server green:3000" "$NGINX_CONF"; then
  LIVE="green"
  TARGET="blue"
else
  LIVE="blue"
  TARGET="green"
fi

echo "Live environment: $LIVE"
echo "Deploying target environment: $TARGET"

docker compose build $TARGET
docker compose up -d $TARGET

curl -f http://localhost:$( [ "$TARGET" = "blue" ] && echo 3001 || echo 3002 )/health

sed -i "s/server $LIVE:3000/server $TARGET:3000/" "$NGINX_CONF"

docker exec blue-green-nginx nginx -s reload

echo "Traffic switched from $LIVE to $TARGET"