#!/bin/bash -eu
cd "$(dirname $0)"
. ../common.sh
initialise_basebox

$SUDO docker build -t durdn/confluence .
CONFLUENCE_VERSION="$($SUDO docker run --rm durdn/confluence sh -c 'echo $CONFLUENCE_VERSION')"
CONF_TAGGED=`$SUDO docker images | grep durdn/confluence | grep $CONFLUENCE_VERSION | wc -l`

if [ $CONF_TAGGED -eq 0 ]; then
  $SUDO docker tag durdn/confluence durdn/confluence:$CONFLUENCE_VERSION
else
  echo "Confluence tagged already with version $CONFLUENCE_VERSION"
fi

CONFLUENCE_RUNNING=`$SUDO docker ps | grep durdn/confluence | wc -l`

if [ $CONFLUENCE_RUNNING -eq 0 ]; then
  test  `docker ps -a | grep durdn/confluence | wc -l` -ne 0  && docker rm confluence
  $SUDO docker run -d --name confluence --link postgres:db  -p 8090:8090 durdn/confluence
fi
