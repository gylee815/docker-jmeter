#!/bin/bash

# JMETER_VERSION=$(echo $(curl -sL https://archive.apache.org/dist/jmeter/binaries/ | grep "Apache JMeter [0-9].") | grep -o "[0-9].[[:digit:]]\.*[[:digit:]]*")
JMETER_VERSION="5.5"
# Example build line
docker build  --build-arg JMETER_VERSION=${JMETER_VERSION} -t "dusqor815/alpine-jmeter:${JMETER_VERSION}" .
