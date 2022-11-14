# Домашнее задание к занятию "14.1 Создание и использование секретов"

## Задача 1: Работа с секретами через утилиту kubectl в установленном minikube

Выполните приведённые ниже команды в консоли, получите вывод команд. Сохраните
задачу 1 как справочный материал.

### Как создать секрет?

```
openssl genrsa -out cert.key 4096
openssl req -x509 -new -key cert.key -days 3650 -out cert.crt \
-subj '/C=RU/ST=Moscow/L=Moscow/CN=server.local'
kubectl create secret tls domain-cert --cert=certs/cert.crt --key=certs/cert.key
```

### Как просмотреть список секретов?

```
kubectl get secrets
kubectl get secret
```

### Как просмотреть секрет?

```
kubectl get secret domain-cert
kubectl describe secret domain-cert
```

### Как получить информацию в формате YAML и/или JSON?

```
kubectl get secret domain-cert -o yaml
kubectl get secret domain-cert -o json
```

### Как выгрузить секрет и сохранить его в файл?

```
kubectl get secrets -o json > secrets.json
kubectl get secret domain-cert -o yaml > domain-cert.yml
```

### Как удалить секрет?

```
kubectl delete secret domain-cert
```

### Как загрузить секрет из файла?

```
kubectl apply -f domain-cert.yml
```

---

## Задача 2 (*): Работа с секретами внутри модуля

Выберите любимый образ контейнера, подключите секреты и проверьте их доступность
как в виде переменных окружения, так и в виде примонтированного тома.

---

## Ответ:

### Задание 1:

Генерируем секрет и добавляем в куб
```bash
ivan@MBP-Ivan ~ % openssl genrsa -out cert.key 4096
Generating RSA private key, 4096 bit long modulus
.....................................................................................++
.....................................++
e is 65537 (0x10001)

ivan@MBP-Ivan ~ % openssl req -x509 -new -key cert.key -days 3650 -out cert.crt \
-subj '/C=RU/ST=Moscow/L=Moscow/CN=server.local'

ivan@MBP-Ivan ~ % kubectl create secret tls domain-cert --cert=cert.crt --key=cert.key  
secret/domain-cert created
```

<br>

Смотрим список секретов
```bash
ivan@MBP-Ivan ~ % kubectl get secrets
NAME          TYPE                DATA   AGE
domain-cert   kubernetes.io/tls   2      110s

ivan@MBP-Ivan ~ % kubectl get secret
NAME          TYPE                DATA   AGE
domain-cert   kubernetes.io/tls   2      3m53s
```

<br>

Смотрим конкретно наш созданный секрет
```bash
ivan@MBP-Ivan ~ % kubectl get secret domain-cert
NAME          TYPE                DATA   AGE
domain-cert   kubernetes.io/tls   2      5m53s

ivan@MBP-Ivan ~ % kubectl describe secret domain-cert
Name:         domain-cert
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  kubernetes.io/tls

Data
====
tls.crt:  1805 bytes
tls.key:  3243 bytes
```

<br>

Получаем информацию в формате YAML и JSON
```bash
ivan@MBP-Ivan ~ % kubectl get secret domain-cert -o yaml
apiVersion: v1
data:
  tls.crt: xxx
  tls.key: xxx
kind: Secret
metadata:
  creationTimestamp: "2022-11-14T11:38:44Z"
  name: domain-cert
  namespace: default
  resourceVersion: "589"
  uid: f0bd3999-db69-4790-a4d0-aff47a157602
type: kubernetes.io/tls

ivan@MBP-Ivan ~ % kubectl get secret domain-cert -o json
{
    "apiVersion": "v1",
    "data": {
        "tls.crt": "xxx",
        "tls.key": "xxx"
    },
    "kind": "Secret",
    "metadata": {
        "creationTimestamp": "2022-11-14T11:38:44Z",
        "name": "domain-cert",
        "namespace": "default",
        "resourceVersion": "589",
        "uid": "f0bd3999-db69-4790-a4d0-aff47a157602"
    },
    "type": "kubernetes.io/tls"
}
```

<br>

Выгружаем секреты и сохраняем в файл
```bash
ivan@MBP-Ivan ~ % kubectl get secrets -o json > secrets.json
ivan@MBP-Ivan ~ % kubectl get secret domain-cert -o yaml > domain-cert.yml

ivan@MBP-Ivan ~ % ls -la | grep domain
-rw-r--r--   1 ivan  staff   6978 Nov 14 14:47 domain-cert.yml
ivan@MBP-Ivan ~ % ls -la | grep secrets
-rw-r--r--   1 ivan  staff   7361 Nov 14 14:47 secrets.json
```

<br>

Удаляем секрет
```bash
ivan@MBP-Ivan ~ % kubectl delete secret domain-cert
secret "domain-cert" deleted

ivan@MBP-Ivan ~ % kubectl get secrets
No resources found in default namespace.
```

<br>

Восстанавливаем ранее удаленный секрет с файла
```bash
ivan@MBP-Ivan ~ % kubectl apply -f domain-cert.yml
secret/domain-cert created

ivan@MBP-Ivan ~ % kubectl get secrets             
NAME          TYPE                DATA   AGE
domain-cert   kubernetes.io/tls   2      3s
```