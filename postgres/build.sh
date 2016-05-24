#!/bin/bash -eu
cd "$(dirname $0)"
source ../common.sh

$SUDO docker build -t durdn/atlassian-postgres .

DB_RUNNING=`$SUDO docker ps | grep postgres | wc -l`

if [ $DB_RUNNING -eq 0 ]; then
  $SUDO docker run -d --name postgres -p=5432:5432 durdn/atlassian-postgres
else
  echo "postgres container running"
fi
