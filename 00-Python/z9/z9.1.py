import requests
from pprint import pprint

Super_Heros_Intelligence={'Hulk':0,'Captain%America':0,'Thanos':0}
TOKEN = None
with open("z9/token_superhero.txt") as f:
    TOKEN = f.read().strip()

url = "https://superheroapi.com/api/"+TOKEN

for heros in Super_Heros_Intelligence.keys():
    resp = requests.get(url+"/search/"+str(heros))
    resp.raise_for_status()
    intelligence=resp.json()["results"][0]["powerstats"]["intelligence"]
    Super_Heros_Intelligence[heros]=int(intelligence)

print(Super_Heros_Intelligence)
print(max(Super_Heros_Intelligence, key=Super_Heros_Intelligence.get))








