#!/bin/bash

function start {
  docker-compose -f docker-compose-docs.yml up
}

function stop {
  docker-compose -f docker-compose-docs.yml down
}

function restart {
  stop
  start
}

while [[ $# > 0 ]]; do
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
      echo "Unknown command '$1'"
      echo "Available commands: start|stop|restart"
      exit 1
      ;;
  esac
  exit 0
done