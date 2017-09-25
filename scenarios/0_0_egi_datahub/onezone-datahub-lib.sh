#!/usr/bin/env bash
FQDN=$(hostname -f)
DOMAIN_NAME=$(domainname -d)
start() {
    docker-compose --project-name $PROJECT_NAME  -f $YAML_FILE config
    DOMAIN_NAME=$DOMAIN_NAME FQDN=$FQDN docker-compose --project-name $PROJECT_NAME -f $YAML_FILE up -d
    docker logs -f onezone-1
}

stop() {
    FQDN=$FQDN docker-compose --project-name $PROJECT_NAME -f $YAML_FILE down
}

restart() {
    stop
    start
}
restart-and-clean() {
    stop
    start
}

purge() {
    stop
    FQDN=$FQDN docker-compose --project-name $PROJECT_NAME -f $YAML_FILE down
    FQDN=$FQDN docker-compose --project-name $PROJECT_NAME -f $YAML_FILE rm -fsv
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
            purge)
                purge
                ;;
            restart-and-clean)
                restart-and-clean
                ;;
            *)
                error
                ;;
        esac
    fi
}