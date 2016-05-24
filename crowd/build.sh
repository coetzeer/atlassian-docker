#!/bin/bash -eu
cd "$(dirname $0)"
. ../common.sh
initialise_basebox

$SUDO docker build -t durdn/crowd .
CROWD_VERSION="$($SUDO docker run --rm durdn/crowd sh -c 'echo $CROWD_VERSION')"
CROWD_TAGGED=`$SUDO docker images | grep durdn/crowd | grep $CROWD_VERSION | wc -l`

if [ $CROWD_TAGGED -eq 0 ]; then
  $SUDO docker tag durdn/crowd durdn/crowd:$CROWD_VERSION
else
  echo "Crowd tagged already with version $CROWD_VERSION"
fi

CROWD_RUNNING=`$SUDO docker ps | grep durdn/crowd | wc -l`
if [ $CROWD_RUNNING -eq 0 ]; then
  test  `docker ps -a | grep durdn/crowd | wc -l` -ne 0  && docker rm crowd
  $SUDO docker run -d -e CROWD_CONTEXT=ROOT -e CROWD_URL=http://localhost:8095 -e SPLASH_CONTEXT= -p 8095:8095 durdn/crowd
fi
