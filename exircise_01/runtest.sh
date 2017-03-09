#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROG="${DIR}"/agg.py
set -euo pipefail 

ALL_COUNT=0
OK_COUNT=0
for data in *.dat; do
    ans="${data%.*}".ans
    out="${data%.*}".out
    
    ret=0
    cat "${data}" | ${PROG} > ${out} || ret=$?
    
    if [ $ret -eq 0 ]; then
        OK_COUNT=$(( $OK_COUNT + 1 ))
    fi
    ALL_COUNT=$(( $ALL_COUNT + 1 )) 
done

echo $OK_COUNT / $ALL_COUNT tests OK
if [ $OK_COUNT -eq $ALL_COUNT ]; then
    exit 0
fi
exit 1
