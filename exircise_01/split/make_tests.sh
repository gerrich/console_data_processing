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
echo -n > ${DIR}/${TEST_ID}.ans
echo > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})

# GNU is not UNIX 
echo "GNU is not UNIX" > ${DIR}/${TEST_ID}.dat
echo -e "GNU is\nis not\nnot UNIX" | tr ' ' '\t' > ${DIR}/${TEST_ID}.ans
echo > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})

# ignore punkt 
echo "  GNU - is not UNIX! " > ${DIR}/${TEST_ID}.dat
echo -e "GNU is\nis not\nnot UNIX" | tr ' ' '\t' > ${DIR}/${TEST_ID}.ans
echo > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})

# multiline
echo -e "GNU is not UNIX!\nGNU is an operating system that is free." > ${DIR}/${TEST_ID}.dat
echo -e "GNU is\nis not\nnot UNIX\nGNU is\nis an\nan operating\noperating system\nsystem that\nthat is\nis free" | tr ' ' '\t' > ${DIR}/${TEST_ID}.ans
echo > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})

# sentinels 
echo "GNU is not UNIX" > ${DIR}/${TEST_ID}.dat
echo -e "^ GNU\nGNU is\nis not\nnot UNIX\nUNIX $" | tr ' ' '\t' > ${DIR}/${TEST_ID}.ans
echo --sentinel > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})

# Trigrams 
echo "GNU is not UNIX" > ${DIR}/${TEST_ID}.dat
echo -e "^ ^ GNU\n^ GNU is\nGNU is not\nis not UNIX\nnot UNIX $\nUNIX $ $" | tr ' ' '\t' > ${DIR}/${TEST_ID}.ans
echo --sentinel --length 3 > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})

