FROM alpine:latest AS build

# Setup environment and build Motion from source
RUN mkdir /work && cd /work && \
    apk -U --no-cache upgrade && \
    apk add --no-cache alpine-sdk linux-headers automake autoconf gettext-dev libmicrohttpd-dev ffmpeg-dev libjpeg-turbo-dev v4l-utils-dev && \
    git clone https://github.com/Motion-Project/motion.git  && \
    cd motion  && \
    autoreconf -fiv && \
    ./configure && \
    make clean && \
    make && \
    make install && \
    cd ../.. && \
    rm -fr work && \
    rm -fr /usr/local/share/doc && \
    rm -fr /usr/local/share/man && \
    apk del --no-cache --rdepends alpine-sdk linux-headers automake autoconf gettext-dev

FROM alpine:latest
ARG build_date
LABEL org.opencontainers.image.created="$build_date" \
      org.opencontainers.image.authors="Mikhail Lazarev <mlaz@mail.ru>" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.title="motion" \
      org.opencontainers.image.description="Alpine based docker container of Motion (https://motion-project.github.io/)" \
      org.opencontainers.image.version="0.2" \
      org.opencontainers.image.url="https://github.com/mikhalakis/motion-alpine-container"

# Copy Motion binary
COPY --from=build /usr/local /usr/local

# Install dependencies and creates defaul configuration
RUN apk -U --no-cache upgrade && \
    apk add  --no-cache v4l-utils ffmpeg-libs libwebp libjpeg-turbo libmicrohttpd && \
    test -e /usr/local/etc/motion/motion.conf || \
    cp /usr/local/etc/motion/motion-dist.conf /usr/local/etc/motion/motion.conf
#VOLUME /dev

EXPOSE 8080/tcp
EXPOSE 8081/tcp

# Run Motion binary
CMD [ "motion", "-n" ]

