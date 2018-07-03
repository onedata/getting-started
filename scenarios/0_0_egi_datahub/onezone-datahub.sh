#!/usr/bin/env bash
set -e

source ./common-config.sh

YAML_FILE=docker-compose-datahub-onezone.yml
PROJECT_NAME=datahub-onezone

start() {
    HOST=$HOST docker-compose --project-name $PROJECT_NAME -f $YAML_FILE config
    HOST=$HOST docker-compose --project-name $PROJECT_NAME -f $YAML_FILE up -d
    docker logs -f onezone-1
}

stop() {
    HOST=$HOST docker-compose --project-name $PROJECT_NAME -f $YAML_FILE down
}

restart() {
    stop
    start
}

error() {
    echo "Unknown command '$1'"
    echo "Available commands: start|stop|restart|purge|restart-and-clean"
    exit 1
}

main() {
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
}

main "$@"
