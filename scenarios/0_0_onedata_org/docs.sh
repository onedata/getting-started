#!/bin/bash
YAML_FILE=docker-compose-docs.yml
PROJECT_NAME=onedata-documentation
_docker_compose="docker-compose --project-name $PROJECT_NAME -f $YAML_FILE"
function start {
    $_docker_compose up -d
}

function stop {
    $_docker_compose  down -v --remove-orphans
}

function update {
    NEW_DOC_VERSION=$1
    sed -i $YAML_FILE -e "s#\(image: [[:lower:].]\+/[[:lower:].-]\+\):[[:lower:]]\+#\1:${NEW_DOC_VERSION}#g"
    restart
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
        update)
            update $2
            ;;
        *)
            error
            ;;
    esac
fi
