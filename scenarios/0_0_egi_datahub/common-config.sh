#!/usr/bin/env bash

MASTER="onedata00.cloud.plgrid.pl"
SLAVE_1="onedata01.cloud.plgrid.pl"
SLAVE_2="zonedb01.cloud.plgrid.pl"
SLAVE_3="zonedb02.cloud.plgrid.pl"

ALL_NODES="${MASTER} ${SLAVE_1} ${SLAVE_2} ${SLAVE_3}"

HOST=`hostname -f`