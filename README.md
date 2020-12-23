Transmission daemon Docker image
================================

[![](https://github.com/monstrenyatko/docker-transmission-daemon/workflows/ci/badge.svg?branch=master)](https://github.com/monstrenyatko/docker-transmission-daemon/actions?query=workflow%3Aci)

About
=====

[Transmission](https://transmissionbt.com/) daemon in the `Docker` container.

Upstream Links
--------------
* Docker Registry @[monstrenyatko/transmission-daemon](https://hub.docker.com/r/monstrenyatko/transmission-daemon/)
* GitHub @[monstrenyatko/docker-transmission-daemon](https://github.com/monstrenyatko/docker-transmission-daemon)

Quick Start
===========

Container is already configured for automatic restart (See `docker-compose.yml`).

The web interface is available on `http://<ip-address>:9091/transmission/web`.

* Configure environment:

  - `TRANSMISSION_DAEMON_DOWNLOADS`: path to downloads directory:

    ```sh
      export TRANSMISSION_DAEMON_DOWNLOADS="/srv/downloads"
    ```
  - `TRANSMISSION_DAEMON_UID`: [**OPTIONAL**] `UID` to be used to run process instead of `root`:

    ```sh
      export TRANSMISSION_DAEMON_UID="1000"
    ```
  - `TRANSMISSION_DAEMON_GID`: [**OPTIONAL**] `GID` to be used to run process instead of `root`:

    ```sh
      export TRANSMISSION_DAEMON_GID="1000"
    ```
  - `DOCKER_REGISTRY`: [**OPTIONAL**] registry prefix to pull image from a custom `Docker` registry:

    ```sh
      export DOCKER_REGISTRY="my_registry_hostname:5000/"
    ```
  - `NET_GW`: [**OPTIONAL**] the network default GW to be used instead of one assigned by `Docker`.
  This option requires `--cap-add=NET_ADMIN`
* Pull prebuilt `Docker` image:

  ```sh
    docker-compose pull
  ```
* Start prebuilt image:

  ```sh
    docker-compose up -d
  ```
* Stop/Restart:

  ```sh
    docker-compose stop
    docker-compose start
  ```

Build own image
===============

* `default` target platform:

  ```sh
    cd <path to sources>
    DOCKER_BUILDKIT=1 docker build --tag <tag name> .
  ```
* `arm/v6` target platform:

  ```sh
    cd <path to sources>
    DOCKER_BUILDKIT=1 docker build --platform=linux/arm/v6 --tag <tag name> .
  ```
