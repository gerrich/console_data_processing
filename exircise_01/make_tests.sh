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
echo -n > ${DIR}/${TEST_ID}.dat
echo -n > ${DIR}/${TEST_ID}.ans
echo > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})

# zero in zero out
echo -n > ${DIR}/${TEST_ID}.dat
echo -n > ${DIR}/${TEST_ID}.ans
echo --format count > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})


# 10 empty lines
seq 10 | perl -lpe '$_=""' > ${DIR}/${TEST_ID}.dat
echo > ${DIR}/${TEST_ID}.ans
echo > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})


# 10 empty lines
seq 10 | perl -lpe '$_=""' > ${DIR}/${TEST_ID}.dat
echo -e "\t10" > ${DIR}/${TEST_ID}.ans
echo --format count > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})



# last line with LINE_END 
echo 1 > ${DIR}/${TEST_ID}.dat
echo 1 > ${DIR}/${TEST_ID}.ans
echo > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})

# last line w/o LINE_END 
echo -n 1 > ${DIR}/${TEST_ID}.dat
echo 1 > ${DIR}/${TEST_ID}.ans
echo > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})



# all different lines 
seq 10 > ${DIR}/${TEST_ID}.dat
seq 10 > ${DIR}/${TEST_ID}.ans
echo > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})

# non consequently repeated lines 
(seq 10; seq 10) > ${DIR}/${TEST_ID}.dat
(seq 10; seq 10) > ${DIR}/${TEST_ID}.ans
echo  > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})


# 
(seq 10; seq 10) | sort -n > ${DIR}/${TEST_ID}.dat
seq 10 > ${DIR}/${TEST_ID}.ans
echo  > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})

# 
(seq 10; seq 10) | sort -n > ${DIR}/${TEST_ID}.dat
seq 10 | perl -lane 'print "$_\t2"' > ${DIR}/${TEST_ID}.ans
echo --format count > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})


# Delimiter ,
seq 10 | perl -lne 'for $i (1..$_) {print join",",$_,$i}' > ${DIR}/${TEST_ID}.dat
seq 10 | perl -lne 'print join",", $_, $_' > ${DIR}/${TEST_ID}.ans
echo -t, -k1,1 --format count > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})

# Delimiter _
seq 10 | perl -lne 'for $i (1..$_) {print join"_",$_,$i}' > ${DIR}/${TEST_ID}.dat
seq 10 | perl -lne 'print join"_", $_, $_' > ${DIR}/${TEST_ID}.ans
echo -t_ -k1,1 --format count > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})

# Delimiter "."
seq 10 | perl -lne 'for $i (1..$_) {print join".",$_,$i}' > ${DIR}/${TEST_ID}.dat
seq 10 | perl -lne 'print join".", $_, $_' > ${DIR}/${TEST_ID}.ans
echo -t. -k1,1 --format count > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})


seq 10 | perl -lne 'for $i (1..$_) {print join"\t",$_,$i}' > ${DIR}/${TEST_ID}.dat
seq 10 | perl -lne 'print join"\t", $_, $_ * ($_ + 1)/2' > ${DIR}/${TEST_ID}.ans
echo -k1,1 --format sum2 > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})


seq 10 | perl -lne 'for $i (1..$_) {print join"\t",$_,$i}' > ${DIR}/${TEST_ID}.dat
seq 10 | perl -lne 'print join"\t", $_, $_' > ${DIR}/${TEST_ID}.ans
echo -k1,1 --format max2 > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})

seq 10 | perl -lne 'for $i (1..$_) {print join"\t",$_,$i+$_}' > ${DIR}/${TEST_ID}.dat
seq 10 | perl -lne 'print join"\t", $_, $_+1' > ${DIR}/${TEST_ID}.ans
echo -k1,1 --format min2 > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})

seq 10 | perl -lne 'for $i (1..$_) {print join"\t",$_,$i}' > ${DIR}/${TEST_ID}.dat
seq 10 | perl -lne 'print join"\t", $_, $_' > ${DIR}/${TEST_ID}.ans
echo -k1,1 --format count > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})


# Complex key
seq 10 | perl -lne 'for $i (1..$_) {print join"\t",$_,$i,$i**2}' > ${DIR}/${TEST_ID}.dat
seq 10 | perl -lne 'for $i (1..$_) {print join"\t",$_,$i,$i**2}' > ${DIR}/${TEST_ID}.ans
echo -k1,3 > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})

seq 10 | perl -lne 'for $i (1..$_) {print join"\t",$_,$i,$i**2}' > ${DIR}/${TEST_ID}.dat
seq 10 | perl -lne 'for $i (1..$_) {print join"\t",$_,$i,1}' > ${DIR}/${TEST_ID}.ans
echo -k1,2 --format count > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})

seq 10 | perl -lne 'for $i (1..$_) {print join"\t",$i,$_,$i}' > ${DIR}/${TEST_ID}.dat
seq 10 | perl -lne 'print join"\t",$_,$_' > ${DIR}/${TEST_ID}.ans
echo -k2,2 --format count > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})

# complex format
seq 10 | perl -lne 'for $i (1..$_) {print join "\t",$_,$i,$i**2}' > ${DIR}/${TEST_ID}.dat
seq 10 | perl -lne 'print join "\t",$_,$_,$_**2,$_,$_**2' > ${DIR}/${TEST_ID}.ans
echo -k1,1 --format count,sum1,max2,max3 > ${DIR}/${TEST_ID}.args
TEST_ID=$(inc ${TEST_ID})


