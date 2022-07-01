#!/usr/bin/env python3

from datetime import date
import time
from os.path import exists
import subprocess
import json


def get_data():
    timestamp = str(int(time.time()))
    process = subprocess.run(["cat", "/proc/loadavg"], capture_output=True)
    loadavg = process.stdout.decode("utf-8").split()[0]
    process = subprocess.run(["cat", "/proc/meminfo"], capture_output=True)
    memfree = process.stdout.decode("utf-8").split()[4]
    process = subprocess.run(["cat", "/proc/vmstat"], capture_output=True)
    nrfreepages = process.stdout.decode("utf-8").split()[1]
    process = subprocess.run(["cat", "/proc/uptime"], capture_output=True)
    uptime = process.stdout.decode("utf-8").split()[0]
    data = {'timestamp': timestamp,
            'loadavg': loadavg,
            'memfree': memfree,
            'nrfreepages': nrfreepages,
            'uptime': uptime}
    return data


file_path = '/var/log/' + str(date.today()) + '-awesome-monitoring.log'
file_exists = exists(file_path)

if file_exists is False:
    with open(file_path, 'w') as f:
        list = []
        list.append(get_data())
        json.dump(list, f, indent=2)
else:
    with open(file_path, 'r') as f:
        list = json.loads(f.read())
    with open(file_path, 'w') as f:
        list.append(get_data())
        json.dump(list, f, indent=2)
