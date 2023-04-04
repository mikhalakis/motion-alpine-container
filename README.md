# motion-alpine-container
Alpine based docker container of Motion (https://motion-project.github.io/)

En example how to run:
```
docker run -d --name=motion -v ./motion.conf:/usr/local/etc/motion/motion.conf \
--device /dev/video0 -p 8080:8080 -p 8081:8081 mikhalakis/motion
```
