#!/usr/bin/env bash

## Copies configuration files to docker-mounted location

SOURCE=./configs
DEST=/volumes/configs

rsync -cria $SOURCE/ $DEST

