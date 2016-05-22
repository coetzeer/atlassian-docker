#!/bin/bash
set -ex

curl -Lks https://downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-${JIRA_VERSION}-jira-${JIRA_VERSION}.tar.gz -o /root/jira.tar.gz
/usr/sbin/useradd --create-home --home-dir /opt/jira --groups atlassian --shell /bin/bash jira
tar zxf /root/jira.tar.gz --strip=1 -C /opt/jira
rm /root/jira.tar.gz
chown -R jira:jira /opt/atlassian-home
echo "jira.home = /opt/atlassian-home" > /opt/jira/atlassian-jira/WEB-INF/classes/jira-application.properties
chown -R jira:jira /opt/jira
mv /opt/jira/conf/server.xml /opt/jira/conf/server-backup.xml
