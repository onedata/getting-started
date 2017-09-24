#!/usr/bin/env bash
FQDN=$(hostname -f)
DOMAIN_NAME=$(domainname -d)
start() {
    docker rm -f onezone-1
    docker-compose --project-name $PROJECT_NAME  -f $YAML_FILE config
    DOMAIN_NAME=$DOMAIN_NAME FQDN=$FQDN docker-compose --project-name $PROJECT_NAME -f $YAML_FILE up -d
    docker logs -f  onezone-1
}

stop() {
    FQDN=$FQDN docker-compose --project-name $PROJECT_NAME -f $YAML_FILE down
}

restart() {
    stop
    start
}

error() {
    echo "Unknown command '$1'"
    echo "Available commands: start|stop|restart"
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