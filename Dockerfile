FROM alpine:latest AS build

# Setup environment and build Motion from source
RUN mkdir /work && cd /work && \
    apk -U --no-cache upgrade && \
    apk add --no-cache alpine-sdk automake autoconf gettext-dev libmicrohttpd-dev ffmpeg-dev libjpeg-turbo-dev && \
    git clone https://github.com/Motion-Project/motion.git  && \
    cd motion  && \
    autoreconf -fiv && \
    ./configure && \
    make clean && \
    make && \
    make install && \
    cd ../.. && \
    rm -fr work && \
    apk del --no-cache --rdepends alpine-sdk automake autoconf gettext-dev

FROM alpine:latest

# Copy Motion binary
COPY --from=build /usr/local /usr/local

# Install dependencies and creates defaul fonfiguration
RUN apk -U --no-cache upgrade && \
    apk add  --no-cache v4l-utils ffmpeg-libs libwebp libjpeg-turbo libmicrohttpd && \
    test -e /usr/local/etc/motion/motion.conf || \
    cp /usr/local/etc/motion/motion-dist.conf /usr/local/etc/motion/motion.conf
#VOLUME /dev

# Run Motion binary
CMD "/bin/sh"

