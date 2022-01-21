import requests
import os

TOKEN = None
with open("z9/token_yandex.txt") as f:
    TOKEN = f.read().strip()
HEADERS = {"Authorization":TOKEN}

class YaUploader:
    def __init__(self, token: str):
        self.token = token

    def upload(self, file_path: str):
        resp_first = requests.get(
            "https://cloud-api.yandex.net/v1/disk/resources/upload",
            params={"path":os.path.basename(file_path),"overwrite":"true"},
            headers=HEADERS
            )
        resp_first.raise_for_status()
        href=resp_first.json()["href"]

        with open(os.path.abspath(file_path), 'rb') as f:
            resp_second = requests.put(href,f)
            resp_second.raise_for_status()
        return print('Загрузка Успешна')

if __name__ == '__main__':
    uploader = YaUploader(TOKEN)
    result = uploader.upload('D:\Paint Tool SAI 1.2.5\elemap\Arrow.bmp')









