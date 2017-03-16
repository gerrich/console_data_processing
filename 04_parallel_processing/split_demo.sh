#!/bin/bash

mkdir -p pool
split -a5 -l100 ../02_text_and_table/book1.utf8.txt pool/part.
for part in $(ls pool/part.?????); do
  cat $part | grep -oEe '[a-zA-Zа-яА-ЯёЁ0-1\`'\'']+' |\
  LC_ALL=C sort | uniq -c | perl -lpe 's!^ *([0-9]+) (.*)!\2\t\1!g' |\
  sort -t$'\t' -k2,2nr > ${part}.word.cnt
done

