#!/bin/bash
#
if [ ! -t 1 ]
then
for FILE in /var/lib/connman/wifi*/settings
do
    NAME=$(cat ${FILE} |grep "Name="|sed "s/^Name=//g")
    if [ -z "${NAME}" ]
    then
        break
    fi
    PASSPHRASE=$(cat ${FILE} |grep "Passphrase="|sed "s/^Passphrase=//g")
    if [ ! -z "${PASSPHRASE}" ]
    then
        printf "${NAME} | "
        echo "${PASSPHRASE}"
    fi
done |sort|base64
fi
