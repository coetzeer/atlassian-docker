#!/bin/bash -eu
cd "$(dirname $0)"
. ../common.sh
initialise_basebox

$SUDO docker build -t durdn/jira .
JIRA_VERSION="$($SUDO docker run --rm durdn/jira sh -c 'echo $JIRA_VERSION')"
JIRA_TAGGED=`$SUDO docker images | grep durdn/jira | grep $JIRA_VERSION | wc -l`

if [ $JIRA_TAGGED -eq 0 ]; then
  $SUDO docker tag durdn/jira durdn/jira:$JIRA_VERSION
else
  echo "Jira tagged already with version $JIRA_VERSION"
fi

JIRA_RUNNING=`$SUDO docker ps | grep durdn/jira | wc -l`

if [ $JIRA_RUNNING -eq 0 ]; then
  test  `docker ps -a | grep durdn/jira | wc -l` -ne 0  && docker rm jira
  $SUDO docker run -d --name jira --link postgres:db --link stash:stash -p 8080:8080 durdn/jira
fi
