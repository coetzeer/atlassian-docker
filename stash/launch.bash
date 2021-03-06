#!/bin/bash
set -o errexit
set -x
. /usr/local/share/atlassian/common.bash

sudo own-volume
umask 0027

if [ -z "$STASH_HOME" ]; then
  export STASH_HOME=/opt/atlassian-home
fi

if [ "$CONTEXT_PATH" == "ROOT" -o -z "$CONTEXT_PATH" ]; then
  CONTEXT_PATH=
else
  echo "Setting context path to: $CONTEXT_PATH"
  CONTEXT_PATH="/$CONTEXT_PATH"
fi
xmlstarlet ed -u '//Context/@path' -v "$CONTEXT_PATH" conf/server-backup.xml > conf/server.xml

if [ -n "$DATABASE_URL" ]; then
  extract_database_url "$DATABASE_URL" DB /opt/stash/lib
  cat << EOF > /opt/atlassian-home/stash-config.properties
#>*******************************************************
#> Migrated to database at $DB_JDBC_URL
#> Generated by launch script on `date`
#>*******************************************************
jdbc.driver=$DB_JDBC_DRIVER
jdbc.url=$DB_JDBC_URL
jdbc.user=$DB_USER
jdbc.password=$DB_PASSWORD
EOF

fi

/opt/stash/bin/catalina.sh run
