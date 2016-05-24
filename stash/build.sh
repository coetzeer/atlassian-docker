#!/bin/bash -eu
cd "$(dirname $0)"
. ../common.sh
initialise_basebox

$SUDO docker build -t durdn/stash .
STASH_VERSION="$($SUDO docker run --rm durdn/stash sh -c 'echo $STASH_VERSION')"
STASH_TAGGED=`$SUDO docker images | grep durdn/stash | grep $STASH_VERSION | wc -l`

if [ $STASH_TAGGED -eq 0 ]; then
  $SUDO docker tag durdn/stash durdn/stash:$STASH_VERSION
else
  echo "Stash tagged already with version $STASH_VERSION"
fi

STASH_RUNNING=`$SUDO docker ps | grep durdn/stash | wc -l`
if [ $STASH_RUNNING -eq 0 ]; then
  test  `docker ps -a | grep durdn/stash | wc -l` -ne 0  && docker rm stash
  $SUDO docker run -d --name stash --link postgres:db -p 7990:7990 -p 7999:7999 durdn/stash
fi
