# Docker Webserver quark (servercontainers/quark)
_maintained by ServerContainers_

[FAQ - All you need to know about the servercontainers Containers](https://marvin.im/docker-faq-all-you-need-to-know-about-the-marvambass-containers/)

# quark
suckless.org static webserver `quark` on alpine baseimage


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
