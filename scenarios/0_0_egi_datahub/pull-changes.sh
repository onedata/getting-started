#!/usr/bin/env bash

source common-config.sh

for NODE in ${ALL_NODES}; do
    echo "${NODE}:"
    if [[ ${HOST} == ${NODE} ]]; then
        cd ${REPO_PATH} && git fetch && git reset --hard origin/${BRANCH_NAME}
    else
        ssh ${NODE} cd ${REPO_PATH} && git fetch && git reset --hard origin/${BRANCH_NAME}
    fi
done
