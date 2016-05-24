#!/bin/bash -ue
function initialise_basebox {
  $SUDO docker build -t durdn/atlassian-base ../base
}

SUDO=""
if [ "$(docker run --rm busybox echo 'test')" != "test" ]; then
  SUDO=sudo
  if [ "$($SUDO docker run --rm busybox echo 'test')" != "test" ]; then
    echo "Could not run docker"
    exit 1
  fi
fi

DB_RUNNING=`$SUDO docker ps | grep postgres | wc -l`
