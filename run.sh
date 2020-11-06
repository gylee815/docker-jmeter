#!/bin/bash
#
# Run JMeter Docker image with options

NAME="docker-jmeter"
IMAGE="gylee/jmeter:5.3"

# stop and rm exist docker-jmeter
sudo docker stop ${NAME} > /dev/null 2>&1
sudo docker rm ${NAME} > /dev/null 2>&1

# Finally run with all jmeter args parameter($@) set on test.sh
sudo docker run --name ${NAME} -i -v ${PWD}:${PWD} -w ${PWD} ${IMAGE} $@
