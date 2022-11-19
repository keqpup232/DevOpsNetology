# Домашнее задание к занятию "14.2 Синхронизация секретов с внешними сервисами. Vault"

## Задача 1: Работа с модулем Vault

Запустить модуль Vault конфигураций через утилиту kubectl в установленном minikube

```
kubectl apply -f 14.2/vault-pod.yml
```

Получить значение внутреннего IP пода

```
kubectl get pod 14.2-netology-vault -o json | jq -c '.status.podIPs'
```

Примечание: jq - утилита для работы с JSON в командной строке

Запустить второй модуль для использования в качестве клиента

```
kubectl run -i --tty fedora --image=fedora --restart=Never -- sh
```

Установить дополнительные пакеты

```
dnf -y install pip
pip install hvac
```

Запустить интепретатор Python и выполнить следующий код, предварительно
поменяв IP и токен

```
import hvac
client = hvac.Client(
    url='http://10.10.133.71:8200',
    token='aiphohTaa0eeHei'
)
client.is_authenticated()

# Пишем секрет
client.secrets.kv.v2.create_or_update_secret(
    path='hvac',
    secret=dict(netology='Big secret!!!'),
)

# Читаем секрет
client.secrets.kv.v2.read_secret_version(
    path='hvac',
)
```

## Задача 2 (*): Работа с секретами внутри модуля

* На основе образа fedora создать модуль;
* Создать секрет, в котором будет указан токен;
* Подключить секрет к модулю;
* Запустить модуль и проверить доступность сервиса Vault.

---

## Ответ:

### Задание 1:

Запустить модуль Vault конфигураций через утилиту kubectl в установленном minikube
```bash
ivan@MBP-Ivan 14.02_Vault % kubectl apply -f 14.2/vault-pod.yml
pod/14.2-netology-vault created

ivan@MBP-Ivan 14.02_Vault % kubectl get po -o wide
NAME                  READY   STATUS    RESTARTS   AGE     IP           NODE       NOMINATED NODE   READINESS GATES
14.2-netology-vault   1/1     Running   0          2m38s   172.17.0.3   minikube   <none>           <none>
```

<br>

Получить значение внутреннего IP пода
```bash
ivan@MBP-Ivan 14.02_Vault % kubectl get pod 14.2-netology-vault -o json | jq -c '.status.podIPs'
[{"ip":"172.17.0.3"}]
```

<br>

Запустить второй модуль для использования в качестве клиента
```bash
ivan@MBP-Ivan 14.02_Vault % kubectl run -i --tty fedora --image=fedora --restart=Never -- sh
If you don't see a command prompt, try pressing enter.
sh-5.1# dnf -y install pip
sh-5.1# pip install hvac
```

<br>

Запустить интепретатор Python и выполнить следующий код, предварительно
поменяв IP и токен
```bash
sh-5.1# python3
Python 3.11.0 (main, Oct 24 2022, 00:00:00) [GCC 12.2.1 20220819 (Red Hat 12.2.1-2)] on linux
Type "help", "copyright", "credits" or "license" for more information.

>>> import hvac
>>> client = hvac.Client(
...     url='http://172.17.0.3:8200',
...     token='aiphohTaa0eeHei'
... )
>>> client.is_authenticated()
True
>>> client.secrets.kv.v2.create_or_update_secret(
...     path='hvac',
...     secret=dict(netology='Big secret!!!'),
... )
{'request_id': '00dea304-a634-99a2-2021-43967a439950', 'lease_id': '', 'renewable': False, 'lease_duration': 0, 'data': {'created_time': '2022-11-18T16:56:59.970255296Z', 'custom_metadata': None, 'deletion_time': '', 'destroyed': False, 'version': 1}, 'wrap_info': None, 'warnings': None, 'auth': None}
>>> client.secrets.kv.v2.read_secret_version(
...     path='hvac',
... )
{'request_id': '9df3d089-620a-fda4-1d46-414ea926f0ae', 'lease_id': '', 'renewable': False, 'lease_duration': 0, 'data': {'data': {'netology': 'Big secret!!!'}, 'metadata': {'created_time': '2022-11-18T16:56:59.970255296Z', 'custom_metadata': None, 'deletion_time': '', 'destroyed': False, 'version': 1}}, 'wrap_info': None, 'warnings': None, 'auth': None}
>>> 
```