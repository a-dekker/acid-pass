#!/bin/bash
#
if [ ! -t 1 ]; then
    MAIN_OS_VERSION=$(echo "${VERSION_ID}" | cut -c-3 | tr -d ".")
    if [ "${MAIN_OS_VERSION}" -lt 31 ]; then
        CONNMAN_PATH=""
    else
        CONNMAN_PATH="/home/.system"
    fi
    for FILE in "${CONNMAN_PATH}"/var/lib/connman/wifi*/settings; do
        NAME=$(grep "Name=" <"${FILE}" | sed "s/^Name=//g")
        if [ -z "${NAME}" ]; then
            break
        fi
        PASSPHRASE=$(grep "Passphrase=" <"${FILE}" | sed "s/^Passphrase=//g")
        if [ -n "${PASSPHRASE}" ]; then
            echo "${NAME} | ${PASSPHRASE}"
        fi
    done | sort | base64
fi
