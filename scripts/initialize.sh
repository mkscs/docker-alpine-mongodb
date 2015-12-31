#!/bin/sh
source /scripts/vars.sh

if [ ! -z "$MONGODB_DBNAME" ];then
  ROLE="${MONGODB_ROLE:-dbOwner}"
else
  ROLE="${MONGODB_ROLE:-root}"
fi

/usr/bin/mongod --dbpath "$DOCKER_DB_MOUNTPOINT" --storageEngine "$DB_STORAGE_ENGINE" --"$DB_JOURNALING" & \ 
while ! nc -vz localhost 27017; do sleep 1; done

echo "Creating user: $DB_USER"
mongo "$DB_NAME" --eval "db.createUser({ user: '$DB_USER', pwd: '$DB_PASSWORD', roles: [ { role: '$ROLE', db: '$DB_NAME' }] });"
/usr/bin/mongod --dbpath "$DOCKER_DB_MOUNTPOINT" --shutdown

rm -f /.initialize
