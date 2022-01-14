#!/usr/bin/env python3

import os
import sys

if len(sys.argv) > 1:
    arg1 = sys.argv[1]
else:
    arg1 = '%HOMEPATH%/PycharmProjects/DebOpsNetology'
bash_command = ["cd " + arg1, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', 'modified:   '+arg1+'/')
        print(prepare_result)