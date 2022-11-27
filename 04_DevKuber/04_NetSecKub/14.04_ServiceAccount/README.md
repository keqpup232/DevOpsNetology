# Домашнее задание к занятию "14.4 Сервис-аккаунты"

## Задача 1: Работа с сервис-аккаунтами через утилиту kubectl в установленном minikube

Выполните приведённые команды в консоли. Получите вывод команд. Сохраните
задачу 1 как справочный материал.

### Как создать сервис-аккаунт?

```
kubectl create serviceaccount netology
```

### Как просмотреть список сервис-акаунтов?

```
kubectl get serviceaccounts
kubectl get serviceaccount
```

### Как получить информацию в формате YAML и/или JSON?

```
kubectl get serviceaccount netology -o yaml
kubectl get serviceaccount default -o json
```

### Как выгрузить сервис-акаунты и сохранить его в файл?

```
kubectl get serviceaccounts -o json > serviceaccounts.json
kubectl get serviceaccount netology -o yaml > netology.yml
```

### Как удалить сервис-акаунт?

```
kubectl delete serviceaccount netology
```

### Как загрузить сервис-акаунт из файла?

```
kubectl apply -f netology.yml
```

## Задача 2 (*): Работа с сервис-акаунтами внутри модуля

Выбрать любимый образ контейнера, подключить сервис-акаунты и проверить
доступность API Kubernetes

```
kubectl run -i --tty fedora --image=fedora --restart=Never -- sh
```

Просмотреть переменные среды

```
env | grep KUBE
```

Получить значения переменных

```
K8S=https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT
SADIR=/var/run/secrets/kubernetes.io/serviceaccount
TOKEN=$(cat $SADIR/token)
CACERT=$SADIR/ca.crt
NAMESPACE=$(cat $SADIR/namespace)
```

Подключаемся к API

```
curl -H "Authorization: Bearer $TOKEN" --cacert $CACERT $K8S/api/v1/
```

В случае с minikube может быть другой адрес и порт, который можно взять здесь

```
cat ~/.kube/config
```

или здесь

```
kubectl cluster-info
```

---

## Ответ:

### Задание 1:

Как создать сервис-аккаунт?
```bash
ivan@MBP-Ivan 14.04_ServiceAccount % kubectl create serviceaccount netology
serviceaccount/netology created
```

<br>

Как просмотреть список сервис-акаунтов?
```bash
ivan@MBP-Ivan 14.04_ServiceAccount % kubectl get serviceaccounts
NAME       SECRETS   AGE
default    0         13d
netology   0         25s

ivan@MBP-Ivan 14.04_ServiceAccount % kubectl get serviceaccount
NAME       SECRETS   AGE
default    0         13d
netology   0         29s

ivan@MBP-Ivan 14.04_ServiceAccount % kubectl get serviceaccount netology
NAME       SECRETS   AGE
netology   0         37s
```

<br>

Как получить информацию в формате YAML и/или JSON?
```bash
ivan@MBP-Ivan 14.04_ServiceAccount % kubectl get serviceaccount netology -o yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  creationTimestamp: "2022-11-27T11:47:57Z"
  name: netology
  namespace: default
  resourceVersion: "13941"
  uid: 9212795a-1875-4f97-8b1a-595cb1d3e45e
  
ivan@MBP-Ivan 14.04_ServiceAccount % kubectl get serviceaccount default -o json
{
    "apiVersion": "v1",
    "kind": "ServiceAccount",
    "metadata": {
        "creationTimestamp": "2022-11-14T11:33:16Z",
        "name": "default",
        "namespace": "default",
        "resourceVersion": "326",
        "uid": "4d22811c-fc89-486f-b422-a91658b5e2c9"
    }
}
```

<br>

Как выгрузить сервис-акаунты и сохранить его в файл?
```bash
ivan@MBP-Ivan 14.4 % kubectl get serviceaccounts -o json > serviceaccounts.json
ivan@MBP-Ivan 14.4 % kubectl get serviceaccount netology -o yaml > netology.yml

ivan@MBP-Ivan 14.4 % ls -la
total 16
drwxr-xr-x  4 ivan  staff  128 Nov 27 14:52 .
drwxr-xr-x  4 ivan  staff  128 Nov 27 14:52 ..
-rw-r--r--  1 ivan  staff  199 Nov 27 14:52 netology.yml
-rw-r--r--  1 ivan  staff  868 Nov 27 14:52 serviceaccounts.json
```

<br>

Как удалить сервис-акаунт?
```bash
ivan@MBP-Ivan 14.4 % kubectl delete serviceaccount netology
serviceaccount "netology" deleted

ivan@MBP-Ivan 14.4 % kubectl get serviceaccounts
NAME      SECRETS   AGE
default   0         13d
```

<br>

Как загрузить сервис-акаунт из файла?
```bash
ivan@MBP-Ivan 14.4 % kubectl apply -f netology.yml
serviceaccount/netology created

ivan@MBP-Ivan 14.4 % kubectl get serviceaccounts
NAME       SECRETS   AGE
default    0         13d
netology   0         5s
```