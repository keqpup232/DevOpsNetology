#!/usr/bin/env python3

import os
import sys
import requests
import json

if len(sys.argv) > 1:
    arg1 = sys.argv[1]
    arg2 = sys.argv[2]
else:
    exit('need arguments')

TOKEN = None
with open("/token_github.txt") as f:
    TOKEN = f.read().strip()

username = 'keqpup232'
repository_name = 'testgit'

headers = {
    "Authorization": "token {}".format(TOKEN),
    "Accept": "application/vnd.github.v3+json"
}
data = {
    "title": arg1,
    "head": "ivan-titan13:develop",
    "base": "master"
}

# update local rep
if arg2 == "update":
    os.system('git checkout master')
    os.system('git fetch server')
    os.system('git merge server/master')
    os.system('git push origin')

##start edit
if arg2 == "request":
    print('\n\nCOMMAND: git flow feature start feature_branch')
    os.system('git flow feature start feature_branch')
    # add changes config.txt
    print('\n\n COMMAND: git add .')
    os.system('git add .')
    print('\n\n COMMAND: git commit --message="' + arg1 + '"')
    os.system('git commit --message="' + arg1 + '"')
    print('\n\n COMMAND: git flow feature finish feature_branch')
    os.system('git flow feature finish feature_branch')
    ## push
    os.system('git checkout master')
    os.system('git push origin')
    os.system('git checkout develop')
    os.system('git merge master')
    os.system('git push origin')
    # pull request
    url = f"https://api.github.com/repos/{username}/{repository_name}/pulls"
    print(requests.post(url, data=json.dumps(data), headers=headers))
else:
    exit('bad second argument, it is expected to update or request')



## git flow method
# os.system('git flow release start '+arg2)
# os.system('git merge master')
# os.system('git flow release finish '+"'"+arg2+"'")

## another method flow
# git checkout main
# git checkout -b develop
# git checkout -b feature_branch
# work happens on feature branch
# git checkout develop
# git merge feature_branch
# git checkout main
# git merge develop
# git branch -d feature_branch

## show tree git
# os.system('git log --graph --color-words --color --source --decorate --all')
