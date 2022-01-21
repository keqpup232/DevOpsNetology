import requests
from pprint import pprint
import json

TOKEN = None
with open("z10/token_vk.txt") as f:
    TOKEN = f.read().strip()
VERSION_API = '5.131'

class User:
    URL = 'https://api.vk.com/method/'
    def __init__(self, token: str, version_api: str, user_id):
        self.token = token
        self.version_api = version_api
        self.user_id = user_id
        
    
    def mutual_friends(self, user_mutual):
        self.mutual_friends={'in':user_mutual.user_id,'mutual_friends':[]}
        self.URL+='friends.getMutual'
        self.resp = requests.get(self.URL,params={
            'v':self.version_api,
            'access_token':self.token,
            'source_uid':self.user_id,
            'target_uid':user_mutual.user_id,
            }
           )
        self.resp.raise_for_status()
        for id in self.resp.json()["response"]:
            self.resp = requests.get('https://api.vk.com/method/users.get',
                                     params={ 'v':self.version_api,
                                              'access_token':self.token,
                                              'user_ids':id,
                                            }
                                     )
            self.resp.raise_for_status()
            data=self.resp.json()
            first_name=data['response'][0]['first_name']
            last_name=data['response'][0]['last_name']
            info_mutual_friends = {
                'id':id,
                'first_name':first_name,
                'last_name':last_name,
                }

            info_mutual_friends= json.dumps(info_mutual_friends)

            self.mutual_friends['mutual_friends'].append(info_mutual_friends)

        print(json.loads(self.mutual_friends['mutual_friends']))
        return pprint(self.mutual_friends)


if __name__ == '__main__':
    user1 = User(TOKEN,VERSION_API,20033701)
    user2 = User(TOKEN,VERSION_API,38811757)
    user1.mutual_friends(user2)
