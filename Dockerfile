FROM debian:stretch

WORKDIR /

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y realpath p7zip-full qemu-user-static git wget kmod sudo python3

RUN git clone --depth 1 https://github.com/guysoft/CustomPiOS.git

# This version of FullPageOS adds support for non-english locales.
# TODO: revert to https://github.com/guysoft/FullPageOS.git after
# this is merged upstream.
RUN git clone --depth 1 \
    -b add-locales-all \
    https://github.com/netzbegruenung/FullPageOS.git

WORKDIR /FullPageOS/src/image

RUN wget -c --trust-server-names \
    https://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2017-12-01/2017-11-29-raspbian-stretch-lite.zip

WORKDIR /FullPageOS/src

RUN /CustomPiOS/src/update-custompios-paths

WORKDIR /

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME /build

ENTRYPOINT ["/entrypoint.sh"]
