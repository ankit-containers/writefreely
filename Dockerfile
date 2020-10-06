# Dockerfile for Writefreely
#
# Copyright 2020, Ankit R Gadiya
# BSD 3-Clause License

# Stage 1: Build from Source
FROM golang:alpine as build

ENV GO111MODULE=on

RUN apk add --update nodejs nodejs-npm make g++ git sqlite-dev git
RUN npm install -g less less-plugin-clean-css
RUN go get -u github.com/jteeuwen/go-bindata/...
RUN git clone https://github.com/writeas/writefreely.git /go/src/github.com/writeas/writefreely

WORKDIR /go/src/github.com/writeas/writefreely

RUN make build \
    && make ui
RUN mkdir /stage && \
    cp -R /go/bin \
      /go/src/github.com/writeas/writefreely/templates \
      /go/src/github.com/writeas/writefreely/static \
      /go/src/github.com/writeas/writefreely/pages \
      /go/src/github.com/writeas/writefreely/keys \
      /go/src/github.com/writeas/writefreely/cmd \
      /stage

# Stage 2: Final Image
FROM debian:buster-slim
LABEL MAINTAINER="Ankit R Gadiya git@argp.in"

COPY --from=build /stage /writefreely
