# motion-alpine-container
Alpine based docker container of Motion (https://motion-project.github.io/).

## About Motion
Motion is a program that monitors the video signal from one or more cameras and is able to detect if a significant part of the picture has changed. Or in other words, it can detect motion.

## About this image
This is Docker container image based on Alpine Linux. It's three times lighter than original [Motion-Project/motion-docker](https://github.com/Motion-Project/motion-docker) and it can capture locally connected USB webcams.

Netcams are not tested.

The source of Dockerfile is available on [GitHub](https://github.com/mikhalakis/motion-alpine-container).

The image is available on [DockerHub](https://hub.docker.com/repository/docker/mikhalakis/motion).

Currently there no support for any databases, but it's easy to enable by adding necessary libraries during the build stage. You may do it by yourself if you need.

## An example how to run:
```
docker run -d --name=motion -v ./motion.conf:/usr/local/etc/motion/motion.conf \
--device /dev/video0 -p 8080:8080 -p 8081:8081 mikhalakis/motion
```
For more configuration options please refer to official Motion [documentation](https://motion-project.github.io/motion_guide.html).
