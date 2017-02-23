# docker-gerrit

Gerrit docker image with additional plugins

## Usage

Available on [Docker Hub](https://hub.docker.com/r/rigoford/docker-gerrit/):

```
docker pull rigoford/docker-gerrit:latest
```

To create a basic Gerrit instance use:

```
docker run \
    --detach \
    --name gerrit \
    --publish 8080:8080 \
    --publish 29418:29418 \
    --restart always \
    rigoford/docker-gerrit:latest
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
    rigoford/docker-gerrit:latest
```
