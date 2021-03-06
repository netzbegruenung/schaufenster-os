#!/bin/bash

docker build --no-cache -t schaufenster-client-builder .

docker run --rm -ti \
  -v $PWD/build:/build \
  --privileged=true \
  --env-file=config.env \
  schaufenster-client-builder

docker rmi schaufenster-client-builder
