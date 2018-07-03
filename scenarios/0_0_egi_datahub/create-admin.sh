#!/usr/bin/env bash
set -e

if [[ -z "${1}" ]]; then
    echo "Provide admin password in the first argument"
else
    PASSWORD="${1}"
    curl -Ss -k -X POST -H 'Content-Type: application/json' -D - \
        'https://127.0.0.1:9443/api/v3/onepanel/users/' \
        -d '{"username": "admin", "password": "'"$PASSWORD"'", "userRole": "admin"}'
fi

