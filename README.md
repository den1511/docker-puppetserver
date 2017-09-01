Puppetserver Docker image
==========================

[![Docker Pulls](https://img.shields.io/docker/pulls/camptocamp/puppetserver.svg)](https://hub.docker.com/r/camptocamp/puppetserver/)
[![Build Status](https://img.shields.io/travis/camptocamp/docker-puppetserver/master.svg)](https://travis-ci.org/camptocamp/docker-puppetserver)
[![By Camptocamp](https://img.shields.io/badge/by-camptocamp-fb7047.svg)](http://www.camptocamp.com)

Available environment variables:
--------------------------------

### JAVA_ARGS

You can set `JAVA_ARGS` using a Docker environment variables:

```shell
docker run --rm -e JAVA_ARGS='-Xmx4G' camptocamp/puppetserver
```
