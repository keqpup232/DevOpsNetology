#!/usr/bin/env python3
import socket
import json

dict = {'drive.google.com':'0.0.0.0', 'mail.google.com':'0.0.0.0', 'google.com':'0.0.0.0'}

with open('4.4File.txt', 'r') as f:
    for line in f:
        dict = json.loads(line)

for url,ip in dict.items():
    ip_new=socket.gethostbyname(url)
    if ip_new != ip:
        print ('[ERROR] ',url, ' IP mismatch:',' old:',ip,'new:',ip_new)
    dict[url]=ip_new
    print (url,' - ',ip_new)

with open('4.4File.txt', 'w') as f:
    f.write(json.dumps(dict))