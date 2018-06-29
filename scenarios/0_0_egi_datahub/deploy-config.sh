#!/usr/bin/env bash
set -e

## Copies configuration files to docker-mounted location

source ./common-config.sh

SOURCE=./configs

sudo rsync -cit $AUTH_CONFIG_PATH $CONFIGS_PATH/
sudo rsync -crit $SOURCE/ $CONFIGS_PATH

