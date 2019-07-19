#!/bin/bash
#
if [ ! -t 1 ]; then
    for FILE in /home/.system/var/lib/connman/wifi*/settings; do
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
