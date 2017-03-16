#!/bin/bash

#TODO parse args

while true; do
  # worker pool
  head -n 10 > ./in_pipe${n_pipe}
   
  $@ < ./in_pipe${n_pipe} > ./out_pipe${n_pipe} &

  # TODO: print from out_pipes
done

wait

cat /out_pipe* 
