#!/bin/bash
#
# Test the JMeter Docker image using a trivial test plan.

# Example for using User Defined Variables with JMeter. You can customize these variables
# These will be substituted in JMX test script
# See also: http://stackoverflow.com/questions/14317715/jmeter-changing-user-defined-variables-from-command-line
export THREADS="300"
export TARGET_HOST=""
export TARGET_PORT=""
export TARGET_PATH=""
# export TARGET_KEYWORD="KEYWORD"
export TARGET_PROTOCOL="https"
export TARGET_METHOD="PUT"

T_DIR=tests/trivial

# Reporting dir: start fresh
R_DIR=${T_DIR}/report
rm -rf ${R_DIR} > /dev/null 2>&1
mkdir -p ${R_DIR}

/bin/rm -f ${T_DIR}/test-plan.jtl ${T_DIR}/jmeter.log  > /dev/null 2>&1

# docker run with jmeter args
./run.sh -Dlog_level.jmeter=DEBUG \
	-JTARGET_HOST=${TARGET_HOST} -JTARGET_PORT=${TARGET_PORT} -JTHREADS=${THREADS}\
	-JTARGET_PATH=${TARGET_PATH} -JTARGET_PROTOCOL=${TARGET_PROTOCOL} -JTARGET_METHOD=${TARGET_METHOD}\
	-n -t ${T_DIR}/test-plan.jmx -l ${T_DIR}/test-plan.jtl -j ${T_DIR}/jmeter.log \
	-e -o ${R_DIR}

echo "==== jmeter.log ===="
cat ${T_DIR}/jmeter.log

echo "==== Raw Test Report ===="
cat ${T_DIR}/test-plan.jtl

echo "==== HTML Test Report ===="
echo "See HTML test report in ${R_DIR}/index.html"
