#!/usr/bin/env bash
set -e

source common-config.sh

for NODE in ${ALL_NODES}; do
    echo "${NODE}:"
    if [[ ${HOST} == ${NODE} ]]; then
        ./deploy-config.sh
    else
        scp ${AUTH_CONFIG_PATH} ${NODE}:${AUTH_CONFIG_PATH}
        ssh ${NODE} -t "cd ${PWD} && ./deploy-config.sh"
    fi
done
