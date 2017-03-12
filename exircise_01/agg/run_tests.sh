#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROG=$1
[ -z $PROG ] && PROG="${DIR}"/agg.py

set -euo pipefail 

ALL_COUNT=0
OK_COUNT=0
for data in $(ls ${DIR}/*.dat); do
    ans="${data%.*}".ans
    out="${data%.*}".out
    args="${data%.*}".args
    err="${data%.*}".err
     
    ret=0
    cat "${data}" | ${PROG} $(head -n1 ${args}) 1>${out} 2>${err} || ret=$?
    
    if [ $ret -ne 0 ]; then
        echo "ERR:"
        head ${err} 
        echo "OUT:"
        head ${out}
    elif cmp ${out} ${ans}; then
        OK_COUNT=$(( $OK_COUNT + 1 ))
    fi
    ALL_COUNT=$(( $ALL_COUNT + 1 )) 
done

echo $OK_COUNT / $ALL_COUNT tests OK
if [ $OK_COUNT -eq $ALL_COUNT ]; then
    exit 0
fi
exit 1
