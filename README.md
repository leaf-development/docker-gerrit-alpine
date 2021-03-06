# docker-gerrit-alpine

Gerrit docker image with additional plugins

## Usage

Available on [Docker Hub](https://hub.docker.com/r/rigoford/docker-gerrit-alpine/):

```
docker pull rigoford/docker-gerrit-alpine:latest
```

To create a basic Gerrit instance use:

```
docker run \
    --detach \
    --name gerrit \
    --publish 8080:8080 \
    --publish 29418:29418 \
    --restart always \
    rigoford/docker-gerrit-alpine:latest
```

If you're behind a proxy use:

```
docker run \
    --detach \
    --env JAVA_FLAGS=-Dhttp.proxyHost=<HTTP_HOST> -Dhttp.proxyPort=<HTTP_PORT> -Dhttps.proxyHost=<HTTPS_HOST> -Dhttps.proxyPort=<HTTPS_PORT>" \
    --name gerrit \
    --publish 8080:8080 \
    --publish 29418:29418 \
    --restart always \
    rigoford/docker-gerrit-alpine:latest
```

If you want to create a Gerrit instance with custom configuration use:

```
docker run \
    --detach \
    --name gerrit \
    --publish 8080:8080 \
    --publish 29418:29418 \
    --restart always \
    --volume `pwd`/config/:/tmp/gerrit/:ro \
    rigoford/docker-gerrit-alpine:latest
```

Any `gerrit.config`, `reviewers.config` or `secure.config` files located in ``` `pwd`/config``` will be copied into the `$GERRIT_SITE/etc` directory before initialising Gerrit.
