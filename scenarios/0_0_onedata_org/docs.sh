#!/bin/bash

function start {
    docker-compose -f docker-compose-docs.yml up -d
}

function stop {
    docker-compose -f docker-compose-docs.yml down
}

function restart {
    stop
    start
}

function error {
echo "Unknown command '$1'"
echo "Available commands: start|stop|restart"
exit 1
}

if [[ -z "${1}" ]]; then
    error
else
    case ${1} in
        start)
            start
            ;;
        stop)
            stop
            ;;
        restart)
            restart
            ;;
        *)
            error
            ;;
    esac
fi