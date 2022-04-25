#!/bin/bash

rm outAnsible.txt
echo $'check stop docker\n' >> outAnsible.txt
docker stop ubuntu centos7 fedora >> outAnsible.txt
echo $'rm if start docker\n' >> outAnsible.txt
docker rm ubuntu centos7 fedora >> outAnsible.txt
echo $'start docker\n' >> outAnsible.txt
docker build -t keqpup232/ubuntu:python . >> outAnsible.txt
docker run -dt --name ubuntu keqpup232/ubuntu:python >> outAnsible.txt
docker run -dt --name centos7 centos >> outAnsible.txt
docker run -dt --name fedora pycontribs/fedora >> outAnsible.txt
echo $'start playbook\n' >> outAnsible.txt
ansible-playbook ~/PycharmProjects/NetologyAnsible/playbook/site.yml \
-i ~/PycharmProjects/NetologyAnsible/playbook/inventory/prod.yml \
--vault-password-file ~/PycharmProjects/NetologyAnsible/playbook/vault_pass.txt >> outAnsible.txt
echo $'stop docker\n' >> outAnsible.txt
docker stop ubuntu centos7 fedora >> outAnsible.txt
echo $'rm docker\n' >> outAnsible.txt
docker rm ubuntu centos7 fedora >> outAnsible.txt
echo $'done'

git add outAnsible.txt
git commit -a -m "playbook init"
git push origin master