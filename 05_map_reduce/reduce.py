#!/usr/bin/env python

import sys


def read_int(fin):
    for line in fin:
        yield int(line.rstrip('\n'))

def add(a, b):
  return a + b

result = reduce(add, read_int(sys.stdin), 0)
print(result)
