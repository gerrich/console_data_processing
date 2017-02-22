#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

LOG_NAME=server.log
MAX_LOGS=10

if [ -e $LOG_NAME ]; then
    for i in $(seq $MAX_LOGS 1) ; do
        if [ -f $LOG_NAME.${i} ]; then
            mv $LOG_NAME.${i} $LOG_NAME.$(( $i + 1 ))
        fi
    done
    mv $LOG_NAME $LOG_NAME.1
fi
