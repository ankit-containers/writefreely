# Dockerfile for Writefreely
#
# Copyright 2020, Ankit R Gadiya
# BSD 3-Clause License
FROM debian:buster-slim
LABEL MAINTAINER="Ankit R Gadiya git@argp.in"

ENV WRITE_VERSION="0.12.0"

RUN apt update \
  && apt install wget -y \
  && wget -O "writefreely.tar.gz" \
    "https://github.com/writeas/writefreely/releases/download/v${WRITE_VERSION}/writefreely_${WRITE_VERSION}_linux_amd64.tar.gz" \
  && rm -rf /var/lib/apt/lists/* \
  && tar -xvf "writefreely.tar.gz" \
  && rm -rf "writefreely.tar.gz"
