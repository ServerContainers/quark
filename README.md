# Docker Webserver quark build yourself container
_maintained by ServerContainers_

[FAQ - All you need to know about the servercontainers Containers](https://marvin.im/docker-faq-all-you-need-to-know-about-the-marvambass-containers/)

# quark
suckless.org static webserver `quark` on alpine baseimage

_currently tested on: x86_64, arm64, arm_

## IMPORTANT!

In March 2023 - Docker informed me that they are going to remove my 
organizations `servercontainers` and `desktopcontainers` unless 
I'm upgrading to a pro plan.

I'm not going to do that. It's more of a professionally done hobby then a
professional job I'm earning money with.

In order to avoid bad actors taking over my org. names and publishing potenial
backdoored containers, I'd recommend to switch over clone my github repos and
build the containers yourself.

## Build & Variants

You can specify `DOCKER_REGISTRY` environment variable (for example `my.registry.tld`)
and use the build script to build the main container and it's variants for _x86_64, arm64 and arm_

You'll find all images tagged like `a3.15.0-qMonFeb2219063620210100` which means `a<alpine version>-q<quarks-latest-commit-date>`.
This way you can pin your installation/configuration to a certian version. or easily roll back if you experience any problems
(don't forget to open a issue in that case ;D).

To build a `latest` tag run `./build.sh release`

## Changelogs

* 2023-03-19
    * switched from docker hub to a build-yourself container
* 2022-10-30
    * better build script and versioning

## What is it

This Dockerfile (available as ___servercontainers/quark___) gives you an inofficial build of the suckless.org static web server `quark`. The image is super tiny and based on alpine. More info here: https://tools.suckless.org/quark/

It's based on the [_/alpine](https://registry.hub.docker.com/_/alpine/) Image

## Volumes

- `/data`
    - all this files will be exposed beneath `/`
    
## Ports

- `80`
    - standard http server
