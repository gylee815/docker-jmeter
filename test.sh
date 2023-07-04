#!/bin/bash
#
# Test the JMeter Docker image using a trivial test plan.

# Example for using User Defined Variables with JMeter. You can customize these variables
# These will be substituted in JMX test script
# See also: http://stackoverflow.com/questions/14317715/jmeter-changing-user-defined-variables-from-command-line

export TARGET_HOST="api.example.com"
export TARGET_PORT="443"
export AUTH_TOKEN="AUTHORIZATION_TOKEN"
export API_KEY="API_KEY"
export TARGET_PATH="/some/path/here"

# export TARGET_KEYWORD="KEYWORD"
export TARGET_PROTOCOL="https"

## Delivery Method = POST, Battery Method = POST
export TARGET_METHOD="POST"

export THREADS="500"
export RAMP_UP_PERIOD=1
export THREADS_DURATION=1800
export THREADS_DELAY=1000

T_DIR=tests/trivial

# Reporting dir: start fresh
R_DIR=${T_DIR}/report
rm -rf ${R_DIR} > /dev/null 2>&1
mkdir -p ${R_DIR}

/bin/rm -f ${T_DIR}/test-plan.jtl ${T_DIR}/jmeter.log  > /dev/null 2>&1

# docker run with jmeter args
./run.sh -Dlog_level.jmeter=DEBUG \
	-JTARGET_HOST=${TARGET_HOST} -JAUTH_TOKEN=${AUTH_TOKEN} -JTARGET_PORT=${TARGET_PORT} -JAPI_KEY=${API_KEY}\
	-JTARGET_PATH=${TARGET_PATH} -JTARGET_PROTOCOL=${TARGET_PROTOCOL} -JTARGET_METHOD=${TARGET_METHOD}\
	-JTHREADS=${THREADS} -JRAMP_UP_PERIOD=${RAMP_UP_PERIOD} -JTHREADS_DURATION=${THREADS_DURATION} -JTHREADS_DELAY=${THREADS_DELAY}\
	-n -t ${T_DIR}/test-plan.jmx -l ${T_DIR}/test-plan.jtl -j ${T_DIR}/jmeter.log \
	-e -o ${R_DIR}

echo "==== jmeter.log ===="
cat ${T_DIR}/jmeter.log

echo "==== Raw Test Report ===="
cat ${T_DIR}/test-plan.jtl

echo "==== HTML Test Report ===="
echo "See HTML test report in ${R_DIR}/index.html"
