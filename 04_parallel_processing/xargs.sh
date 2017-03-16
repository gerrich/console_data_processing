#!/bin/bash

N_JOBS=1
N_ARGS=1
while true; do
  case "$1" in
    -P)
      N_JOBS=$2
      shift; shift;;
    -n)
      N_ARGS=$2
      shift; shift;;
    --)
      shift; break;;
    *)
      break;;
  esac
done

i=0
args=()
arg_len=0
while read -r; do
  args=(${args[@]} "$REPLY")
  arg_len=$(( $arg_len + 1 ))

  if [ $arg_len -ge $N_ARGS ]; then 
      if [ $i -ge $N_JOBS ]; then
          wait -n
          i=$(( i - 1 )) 
      fi
      $@ ${args[@]} &
      args=()
      arg_len=0
      i=$(( i + 1 ))
  fi
done

if [ $arg_len -gt 0 ]; then 
    $@ ${args[@]} &
    args=()
    arg_len=0
fi
wait
