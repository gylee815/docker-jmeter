#!/bin/bash

JMETER_VERSION="5.3"

# Example build line
docker build  --build-arg JMETER_VERSION=${JMETER_VERSION} -t "gylee/jmeter:${JMETER_VERSION}" .
