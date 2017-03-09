#!/usr/bin/env python3

import argparse
import requests
import sys
import re

for line in sys.stdin:
    line = line.rstrip('\n')
   
    title = ''
    try: 
        if not re.search('^[A-Za-z]?://', line):
            line = 'http://' + line

        request = requests.get(line)
        m = re.search('<title>(.*?)</title>', request.text)
        if m:
            title = m.group(1)
    except Exception as e:
        title = 'error: ' + re.sub('[\r\n]', ' ', str(e))

    print(title)
