#!/usr/bin/env bash
set -e

## Copies configuration files to docker-mounted location

SOURCE=./configs
DEST=/volumes/configs

rsync -cria $SOURCE/ $DEST

