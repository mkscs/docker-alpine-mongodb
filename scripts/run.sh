#!/bin/sh
if [[ -e /.initialize ]];then
  source /scripts/initialize.sh
else
  source /scripts/vars.sh
fi

echo "====================================="
echo "MONGODB USER:       $DB_USER"
echo "MONGODB PASSWORD:   $DB_PASSWORD"
echo "MONGODB DATABASE:   $DB_NAME"
echo "MONGODB ROLE:       $ROLE"
echo "MONGODB PORT:       $DOCKER_DB_PORT"
echo "MONGODB ENGINE:     $DB_STORAGE_ENGINE"
echo "MONGODB JOURNALING: $DB_JOURNALING"
echo "====================================="


/usr/bin/mongod --dbpath "$DOCKER_DB_MOUNTPOINT" --port "$DOCKER_DB_PORT" --storageEngine "$DB_STORAGE_ENGINE" --"$DB_JOURNALING" --auth $@
