#!/bin/bash

# Scenario has to be defined before the source
SCENARIO_NAME='20oneprovideronezone'

source ../../bin/run_onedata.sh 

# Custom scenario functions and variables

SCENARIO_DOCKER_NETWORK_NAME="scenario2"

clean_scenario() {
	docker network rm "${SCENARIO_NAME}_${SCENARIO_DOCKER_NETWORK_NAME}"
}

main "$@"


