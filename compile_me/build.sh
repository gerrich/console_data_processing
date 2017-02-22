#!/bin/bash

if [ sum.cpp -nt sum ]; then
  g++ sum.cpp -o sum
fi
