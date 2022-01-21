import requests
from datetime import date
from datetime import timedelta
from pprint import pprint

yesterday = date.today()-timedelta(1)
i=1

while True:
    resp = requests.get("https://api.stackexchange.com/2.3/questions",
                       params={
                           "tagged":"00-Python",
                           "min":yesterday,
                           "site":"ru.stackoverflow",
                           "sort":"creation",
                           "page":i
                           }
                       )
    i+=1
    resp.raise_for_status()
    data = resp.json()

    if data["has_more"] is False:
        break

    for title in data["items"]:
        
        print(title["title"],date.fromtimestamp(title["creation_date"]))











