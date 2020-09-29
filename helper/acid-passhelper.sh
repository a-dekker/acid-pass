#!/bin/bash
#
if [ ! -t 1 ]; then
    . /etc/sailfish-release
    MAIN_OS_VERSION=$(echo "${VERSION_ID}" | cut -c-3 | tr -d ".")
    if [ "${MAIN_OS_VERSION}" -lt 31 ]; then
        CONNMAN_PATH="/var/lib/connman"
    elif [ "${MAIN_OS_VERSION}" -lt 34 ]; then
        CONNMAN_PATH="/home/.system/var/lib/connman"
    else
        CONNMAN_PATH="/home/nemo/.local/share/system/privileged/connman"
    fi
    for FILE in "${CONNMAN_PATH}"/wifi*/settings; do
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
