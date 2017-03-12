#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROG=$1
[ -z $PROG ] && PROG="${DIR}"/agg.py

set -euo pipefail 

function inc() {
  printf "%03d" $(( $(echo $1 | grep -o '[1-9][0-9]*') + 1 ))
}
TEST_ID=000

# zero in zero out
echo > ${DIR}/${TEST_ID}.dat
echo > ${DIR}/${TEST_ID}.ans
echo > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})



