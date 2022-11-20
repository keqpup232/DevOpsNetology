# Домашнее задание к занятию "14.3 Карты конфигураций"

## Задача 1: Работа с картами конфигураций через утилиту kubectl в установленном minikube

Выполните приведённые команды в консоли. Получите вывод команд. Сохраните
задачу 1 как справочный материал.

### Как создать карту конфигураций?

```
kubectl create configmap nginx-config --from-file=nginx.conf
kubectl create configmap domain --from-literal=name=netology.ru
```

### Как просмотреть список карт конфигураций?

```
kubectl get configmaps
kubectl get configmap
```

### Как просмотреть карту конфигурации?

```
kubectl get configmap nginx-config
kubectl describe configmap domain
```

### Как получить информацию в формате YAML и/или JSON?

```
kubectl get configmap nginx-config -o yaml
kubectl get configmap domain -o json
```

### Как выгрузить карту конфигурации и сохранить его в файл?

```
kubectl get configmaps -o json > configmaps.json
kubectl get configmap nginx-config -o yaml > nginx-config.yml
```

### Как удалить карту конфигурации?

```
kubectl delete configmap nginx-config
```

### Как загрузить карту конфигурации из файла?

```
kubectl apply -f nginx-config.yml
```

## Задача 2 (*): Работа с картами конфигураций внутри модуля

Выбрать любимый образ контейнера, подключить карты конфигураций и проверить
их доступность как в виде переменных окружения, так и в виде примонтированного
тома

---

## Ответ:

### Задание 1:


Как создать карту конфигураций?
```bash
ivan@MBP-Ivan 14.3 % kubectl create configmap nginx-config --from-file=nginx.conf
configmap/nginx-config created

ivan@MBP-Ivan 14.3 % kubectl create configmap domain --from-literal=name=netology.ru                  
configmap/domain created
```

<br>

Как просмотреть список карт конфигураций?
```bash
ivan@MBP-Ivan 14.3 % kubectl get configmaps
NAME               DATA   AGE
domain             1      2m1s
kube-root-ca.crt   1      6d6h
nginx-config       1      2m42s

ivan@MBP-Ivan 14.3 % kubectl get configmap
NAME               DATA   AGE
domain             1      2m5s
kube-root-ca.crt   1      6d6h
nginx-config       1      2m46s
```

<br>

Как просмотреть карту конфигурации?
```bash
ivan@MBP-Ivan 14.3 % kubectl get configmap nginx-config
NAME           DATA   AGE
nginx-config   1      3m31s

ivan@MBP-Ivan 14.3 % kubectl describe configmap domain
Name:         domain
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
name:
----
netology.ru

BinaryData
====

Events:  <none>
```

<br>

Как получить информацию в формате YAML и/или JSON?
```bash
ivan@MBP-Ivan 14.3 % kubectl get configmap nginx-config -o yaml
apiVersion: v1
data:
  nginx.conf: |
    server {
        listen 80;
        server_name  netology.ru www.netology.ru;
        access_log  /var/log/nginx/domains/netology.ru-access.log  main;
        error_log   /var/log/nginx/domains/netology.ru-error.log info;
        location / {
            include proxy_params;
            proxy_pass http://10.10.10.10:8080/;
        }
    }
kind: ConfigMap
metadata:
  creationTimestamp: "2022-11-20T18:16:52Z"
  name: nginx-config
  namespace: default
  resourceVersion: "12120"
  uid: b99d3433-95a4-4bdc-8f4c-bf04b491b845

ivan@MBP-Ivan 14.3 % kubectl get configmap domain -o json
{
    "apiVersion": "v1",
    "data": {
        "name": "netology.ru"
    },
    "kind": "ConfigMap",
    "metadata": {
        "creationTimestamp": "2022-11-20T18:17:33Z",
        "name": "domain",
        "namespace": "default",
        "resourceVersion": "12150",
        "uid": "77cb3eba-fd5d-4ce8-a7ee-2c20d079361e"
    }
}
```

<br>

Как выгрузить карту конфигурации и сохранить его в файл?
```bash
ivan@MBP-Ivan 14.3 % kubectl get configmaps -o json > configmaps.json

ivan@MBP-Ivan 14.3 % kubectl get configmap nginx-config -o yaml > nginx-config.yml

ivan@MBP-Ivan 14.3 % ls -la | grep config
-rw-r--r--  1 ivan  staff  3228 Nov 20 21:24 configmaps.json
-rw-r--r--  1 ivan  staff   566 Nov 20 21:24 nginx-config.yml
```

<br>

Как удалить карту конфигурации?
```bash
ivan@MBP-Ivan 14.3 % kubectl delete configmap nginx-config
configmap "nginx-config" deleted

ivan@MBP-Ivan 14.3 % kubectl get configmaps
NAME               DATA   AGE
domain             1      8m24s
kube-root-ca.crt   1      6d6h
```

<br>

Как загрузить карту конфигурации из файла?
```bash
ivan@MBP-Ivan 14.3 % kubectl apply -f nginx-config.yml
configmap/nginx-config created

ivan@MBP-Ivan 14.3 % kubectl get configmaps           
NAME               DATA   AGE
domain             1      9m5s
kube-root-ca.crt   1      6d6h
nginx-config       1      2s
```