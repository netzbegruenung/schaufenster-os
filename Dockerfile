FROM debian:stretch

WORKDIR /

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y ca-certificates coreutils realpath p7zip-full qemu-user-static git curl kmod sudo python3 lsof

RUN git clone --depth 1 https://github.com/guysoft/CustomPiOS.git

# This version of FullPageOS adds support for non-english locales.
# TODO: revert to https://github.com/guysoft/FullPageOS.git after
# this is merged upstream.
RUN git clone --depth 1 \
    -b add-locales-all \
    https://github.com/netzbegruenung/FullPageOS.git

#RUN git clone --depth 1 https://github.com/guysoft/FullPageOS.git

RUN set -x

WORKDIR /FullPageOS/src/image

# # Settings for the Rasbian lite base image to use
# ENV SHA1 c4ed01ab67dcb2e209d558334eb33dc76ae58469
# ENV RASPBIAN_DATE 2017-12-01
# ENV FILENAME 2017-11-29-raspbian-stretch-lite.zip
# ENV RASPBIAN_URL "https://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-${RASPBIAN_DATE}/${FILENAME}"

# RUN echo $RASPBIAN_URL && \
#     curl -O -L $RASPBIAN_URL && \
#     echo "${SHA1} ${FILENAME}" | sha1sum -c -

# use local image file
ADD ./image/2017-11-29-raspbian-stretch-lite.zip /FullPageOS/src/image/


WORKDIR /FullPageOS/src

RUN /CustomPiOS/src/update-custompios-paths

WORKDIR /

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME /build

ENTRYPOINT ["/entrypoint.sh"]
