#!/bin/bash
set -ex

curl -Lks https://downloads.atlassian.com/software/confluence/downloads/atlassian-confluence-${CONFLUENCE_VERSION}.tar.gz -o /root/confluence.tar.gz
/usr/sbin/useradd --create-home --home-dir /opt/confluence --groups atlassian --shell /bin/bash confluence
tar zxf /root/confluence.tar.gz --strip=1 -C /opt/confluence
rm /root/confluence.tar.gz
chown -R confluence:confluence /opt/atlassian-home
echo "confluence.home = /opt/atlassian-home" > /opt/confluence/confluence/WEB-INF/classes/confluence-init.properties
chown -R confluence:confluence /opt/confluence
mv /opt/confluence/conf/server.xml /opt/confluence/conf/server-backup.xml
