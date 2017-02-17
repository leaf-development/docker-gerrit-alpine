FROM rigoford/alpine-java-newrelic:3.33.0.1

MAINTAINER Martin Ford <ford.j.martin@gmail.com>

ARG GERRIT_USER=gerrit2
ARG GERRIT_USER_GID=1000
ARG GERRIT_VERSION=2.13.5
ARG GERRIT_HOME=/opt/gerrit
ARG GERRIT_DOWNLOAD_URL=https://www.gerritcodereview.com/download/gerrit-${GERRIT_VERSION}.war
ARG GERRIT_SITE=${GERRIT_HOME}/site
ARG GERRIT_PLUGINS=${GERRIT_SITE}/plugins

ARG PLUGIN_VERSION=stable-2.13
ARG PLUGIN_URL=https://gerrit-ci.gerritforge.com/view/Plugins-${PLUGIN_VERSION}/job
ARG PLUGIN_DIR=lastSuccessfulBuild/artifact/buck-out/gen/plugins

#ARG MYSQL_CONNECTOR_VERSION=5.1.39
#ARG MYSQL_CONNECTOR_BASENAME=mysql-connector-java-${MYSQL_CONNECTOR_VERSION}
#ARG MYSQL_CONNECTOR_DOWNLOAD_FILENAME=${MYSQL_CONNECTOR_BASENAME}.tar.gz
#ARG MYSQL_CONNECTOR_DOWNLOAD_URL=http://cdn.mysql.com//Downloads/Connector-J/${MYSQL_CONNECTOR_DOWNLOAD_FILENAME}
#ARG MYSQL_CONNECTOR_FILENAME=${MYSQL_CONNECTOR_BASENAME}-bin.jar

ENV GERRIT_HOME=${GERRIT_HOME} \
    GERRIT_SITE=${GERRIT_SITE} \
    GERRIT_PLUGINS=${GERRIT_PLUGINS}

RUN apk --no-cache add git

RUN mkdir -p ${GERRIT_PLUGINS}

ADD ${GERRIT_DOWNLOAD_URL} ${GERRIT_HOME}/gerrit.war
#ADD ./gerrit-${GERRIT_VERSION}.war ${GERRIT_HOME}/gerrit.war
ADD ${PLUGIN_URL}/plugin-delete-project-${PLUGIN_VERSION}/${PLUGIN_DIR}/delete-project/delete-project.jar ${GERRIT_PLUGINS}/delete-project.jar
ADD ${PLUGIN_URL}/plugin-importer-${PLUGIN_VERSION}/${PLUGIN_DIR}/importer/importer.jar ${GERRIT_PLUGINS}/importer.jar
ADD ${PLUGIN_URL}/plugin-reviewers-${PLUGIN_VERSION}/${PLUGIN_DIR}/reviewers/reviewers.jar ${GERRIT_PLUGINS}/reviewers.jar

ADD ./files/configure-and-run.sh ${GERRIT_HOME}/bin/configure-and-run.sh
RUN chmod +x ${GERRIT_HOME}/bin/configure-and-run.sh

#ADD ${MYSQL_CONNECTOR_DOWNLOAD_URL} /tmp/${MYSQL_CONNECTOR_DOWNLOAD_FILENAME}
#RUN mkdir -p /tmp/gerrit/lib/ && \
#    tar -xzf /tmp/${MYSQL_CONNECTOR_DOWNLOAD_FILENAME} -C /tmp/ && \
#    cp /tmp/${MYSQL_CONNECTOR_BASENAME}/${MYSQL_CONNECTOR_FILENAME} /tmp/gerrit/lib/${MYSQL_CONNECTOR_FILENAME} && \
#    rm /tmp/${MYSQL_CONNECTOR_DOWNLOAD_FILENAME} && \
#    rm -rf /tmp/${MYSQL_CONNECTOR_BASENAME} && \
#    ls -l /tmp/gerrit/lib/

#RUN addgroup -g ${GERRIT_USER_GID} ${GERRIT_USER} && \
#    adduser -h ${GERRIT_HOME} -s /bin/sh -u ${GERRIT_USER_GID} -D -G ${GERRIT_USER} -H ${GERRIT_USER} && \
#    chown -R ${GERRIT_USER}:${GERRIT_USER} ${GERRIT_HOME}

#USER ${GERRIT_USER}

EXPOSE 8080 29418

VOLUME ["${GERRIT_PLUGINS}"]

WORKDIR "${GERRIT_HOME}"

#ENTRYPOINT ["./bin/configure-and-run.sh"]
