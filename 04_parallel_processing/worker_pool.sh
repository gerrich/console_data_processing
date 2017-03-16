#!/bin/bash

N_JOBS=2
for i in $(seq 10); do
    [ $i -ge $N_JOBS ] && wait -n 
    sleep 1
    echo $i
done

wait
