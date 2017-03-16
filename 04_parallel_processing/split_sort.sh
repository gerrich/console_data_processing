#!/bin/bash

mkdir -p pool
rm -f pool/part.????? 
cat ../02_text_and_table/book1.utf8.txt | grep -oEe '[a-zA-Zа-яА-ЯёЁ0-1\`'\'']+' |\
split -a5 -l10000 - pool/part.
for part in pool/part.?????; do
  LC_ALL=C sort $part > ${part}.srt
done

LC_ALL=C sort -m pool/part.?????.srt > book1.utf8.words.srt
