#!/bin/bash
YAML_FILE=docker-compose-docs.yml
PROJECT_NAME=onedata-documentation
_docker_compose="docker-compose --project-name $PROJECT_NAME -f $YAML_FILE"

start() {
    $_docker_compose up -d
}

stop() {
    $_docker_compose  down -v --remove-orphans
}

restart() {
    stop
    start
}

update() {
    NEW_DOC_VERSION=$1
    sed -i $YAML_FILE -e "s#\(image: [[:alnum:].]\+/[[:alnum:].-]\+\):[[:alnum:]]\+#\1:${NEW_DOC_VERSION}#g"
    if [[ $2 == "--commit" ]]; then
        git reset
        git add $YAML_FILE
        git commit -m "updated documentation container to docker image id $NEW_DOC_VERSION"
        git push
    fi
}

error() {
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
            update $2 $3
            ;;
         *)
            error
            ;;
    esac
fi
