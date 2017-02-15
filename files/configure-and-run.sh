#!/bin/sh

#mkdir -p ${GERRIT_HOME}/etc
#cp /tmp/config/gerrit.config ${GERRIT_HOME}/etc/gerrit.config
#cp /tmp/config/secure.config ${GERRIT_HOME}/etc/secure.config

java -jar ${GERRIT_HOME}/gerrit.war init --batch --no-auto-start --site-path ${GERRIT_HOME}/site
java -jar ${GERRIT_HOME}/gerrit.war reindex --site-path ${GERRIT_HOME}/site

#java -jar ${GERRIT_HOME}/gerrit.war init --batch --no-auto-start --site-path ${GERRIT_HOME}/site

java -jar ${GERRIT_HOME}/gerrit.war daemon --console-log --site-path ${GERRIT_HOME}/site
