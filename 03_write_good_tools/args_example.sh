#!/bin/bash

VERBOSE=
regex=''
while true; do
    case "$1" in
        -R|--regex)
            regex=$2
            shift; shift;;
        -v)
            VERBOSE=1
            shift;;
        --)
            shift; break;;
        *)
            break;;
    esac
done

find ./ -name "${regex}" | xargs du -shc | tail -n 1
