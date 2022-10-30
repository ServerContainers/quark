# Docker Webserver quark (servercontainers/quark)
_maintained by ServerContainers_

[FAQ - All you need to know about the servercontainers Containers](https://marvin.im/docker-faq-all-you-need-to-know-about-the-marvambass-containers/)

# quark
suckless.org static webserver `quark` on alpine baseimage


## Versioning

You'll find all images tagged like `a3.15.0-qMonFeb2219063620210100` which means `a<alpine version>-q<quarks-latest-commit-date>`.
This way you can pin your installation/configuration to a certian version. or easily roll back if you experience any problems
(don't forget to open a issue in that case ;D).

The `latest` version will be updated/released after I managed to test a new pinned version in my production environment.
This way I can easily find and fix bugs without affecting any users. It will result in a way more stable container.


## Changelogs

* 2022-10-30
    * better build script and versioning

## What is it

This Dockerfile (available as ___servercontainers/quark___) gives you an inofficial build of the suckless.org static web server `quark`. The image is super tiny and based on alpine. More info here: https://tools.suckless.org/quark/

It's based on the [_/alpine](https://registry.hub.docker.com/_/alpine/) Image

View in Docker Registry [servercontainers/quark](https://registry.hub.docker.com/u/servercontainers/quark/)

View in GitHub [ServerContainers/quark](https://github.com/ServerContainers/quark)


## Volumes

- `/data`
    - all this files will be exposed beneath `/`
    
## Ports

- `80`
    - standard http server
