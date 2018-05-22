#! /bin/bash

# Run a docker container for testing with Selenium.
#
# Create the container first, using build.sh
# Pass the full path of the directory where the tests are on the host as parameter.
# Example:
#   ./run.sh /home/my-name/workspace/my-project/tests/
#
# The test runner will print test success and coverage info.
#
# @author Alvaro Ortiz for Museum fuer Naturkunde, 2017
# contact: alvaro.OrtizTroncoso@mfn-berlin.de

# Read configuration options
source config.ini

#############################################
#
# Start the Selenium container.
#
#############################################
start() {    
    docker rm $SLNM_CONTAINER
    docker run \
       --restart no \
       --name $SLNM_CONTAINER \
       -v $PATH_ON_HOST:/usr/src/app/test \
       -d \
       $SLNM_CONTAINER
    echo "You can now run tests."
    docker ps
}

#############################################
#
# Run all tests.
#
#############################################
runtests() {
    docker exec -ti $SLNM_CONTAINER /bin/bash ./start_test_runner.sh
}

#############################################
#
# Stop and remove the container
# after the test run is completed
#
#############################################
stop() {
    docker stop $SLNM_CONTAINER
    docker rm $SLNM_CONTAINER
}

PATH_ON_HOST=$1
start
runtests
stop
