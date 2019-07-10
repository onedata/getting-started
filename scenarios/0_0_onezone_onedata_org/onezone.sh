#!/bin/bash
YAML_FILE=docker-compose-onezone.yml
PROJECT_NAME=onezone-onedata-org

function start {
    docker-compose --project-name $PROJECT_NAME -f $YAML_FILE up -d
}

function stop {
    docker-compose --project-name $PROJECT_NAME -f $YAML_FILE down
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
