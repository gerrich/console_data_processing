#!/bin/bash

function calc_sum() {
  perl -M'List::Util sum' -le 'print sum(<stdin>)'
}

for cnt in 1 2 3 10 100 1000 10000; do
  cmp <(seq $cnt | ./sum) <(seq $cnt | calc_sum)
done
