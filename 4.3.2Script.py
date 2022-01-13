#!/usr/bin/env python3

import socket
import json
import yaml

dict = {'drive.google.com': '0.0.0.0', 'mail.google.com': '0.0.0.0', 'google.com': '0.0.0.0'}

with open('4.3.2File.json', 'r') as f:
    dict = json.load(f)

for url, ip in dict.items():
    ip_new = socket.gethostbyname(url)
    if ip_new != ip:
        print('[ERROR] ', url, ' IP mismatch:', ' old:', ip, 'new:', ip_new)
    dict[url] = ip_new
    print(url, ' - ', ip_new)

    # по отдельности
    with open(url + ".json", 'w') as f:
        f.write(json.dumps({url: ip_new}))

    with open(url + ".yaml", 'w') as f:
        f.write(yaml.dump([{url: ip_new}]))

# общие файлы
with open('4.3.2File.json', 'w') as f:
    f.write(json.dumps(dict, indent=2))

with open('4.3.2File.yaml', 'w') as f:
    f.write(yaml.dump(dict, explicit_start=True, explicit_end=True))
