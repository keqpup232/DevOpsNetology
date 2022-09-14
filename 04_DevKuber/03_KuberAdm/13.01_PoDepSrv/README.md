# Домашнее задание к занятию "13.1 контейнеры, поды, deployment, statefulset, services, endpoints"
Настроив кластер, подготовьте приложение к запуску в нём. Приложение стандартное: бекенд, фронтенд, база данных. Его можно найти в папке 13-kubernetes-config.

## Задание 1: подготовить тестовый конфиг для запуска приложения
Для начала следует подготовить запуск приложения в stage окружении с простыми настройками. Требования:
* под содержит в себе 2 контейнера — фронтенд, бекенд;
* регулируется с помощью deployment фронтенд и бекенд;
* база данных — через statefulset.

## Задание 2: подготовить конфиг для production окружения
Следующим шагом будет запуск приложения в production окружении. Требования сложнее:
* каждый компонент (база, бекенд, фронтенд) запускаются в своем поде, регулируются отдельными deployment’ами;
* для связи используются service (у каждого компонента свой);
* в окружении фронта прописан адрес сервиса бекенда;
* в окружении бекенда прописан адрес сервиса базы данных.

## Задание 3 (*): добавить endpoint на внешний ресурс api
Приложению потребовалось внешнее api, и для его использования лучше добавить endpoint в кластер, направленный на это api. Требования:
* добавлен endpoint до внешнего api (например, геокодер).

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

В качестве решения прикрепите к ДЗ конфиг файлы для деплоя. Прикрепите скриншоты вывода команды kubectl со списком запущенных объектов каждого типа (pods, deployments, statefulset, service) или скриншот из самого Kubernetes, что сервисы подняты и работают.

---
## Ответ:

### Задание 1:

Делаю build и push в докерхаб
```bash
docker login
docker buildx build --platform=linux/amd64 -t keqpup232/backend:1.1 .
docker push keqpup232/backend:1.1
docker buildx build --platform=linux/amd64 -t keqpup232/frontend:1.1 .
docker push keqpup232/frontend:1.1

# 1) need create dir /mnt/local-storage in master
# 2) You can run below command to remove the taint from master node and then you should be able to deploy your pod on that node
kubectl taint nodes --all node-role.kubernetes.io/master-
```

Запускаем манифесты stage и смотрим:
- [Deployment.yaml](./files/stage/Deployment.yaml)
- [Ingress.yaml](./files/stage/Ingress.yaml)
- [Service.yaml](./files/stage/Service.yaml)
- [Statefulset.yaml](./files/stage/Statefulset.yaml)

```bash
kubectl apply -f Deployment.yaml 
kubectl apply -f Ingress.yaml   
kubectl apply -f Service.yaml 
kubectl apply -f Statefulset.yaml 

ivan@MBP-Ivan stage % kubectl get pods 
NAME                  READY   STATUS    RESTARTS   AGE
db-0                  1/1     Running   0          119m
main-d7997f56-5m6fw   2/2     Running   0          10m
main-d7997f56-d68ch   2/2     Running   0          10m
main-d7997f56-s5x7r   2/2     Running   0          11m

ivan@MBP-Ivan stage % kubectl get services
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                         AGE
db           ClusterIP      10.233.52.136   <none>        5432/TCP                        119m
db-srv       LoadBalancer   10.233.0.208    <pending>     5432:31223/TCP                  3h50m
kubernetes   ClusterIP      10.233.0.1      <none>        443/TCP                         4h9m
main         LoadBalancer   10.233.55.50    <pending>     8000:30527/TCP,9000:31582/TCP   3h50m

ivan@MBP-Ivan prod % kubectl get statefulset -o wide
NAME   READY   AGE     CONTAINERS   IMAGES
db     1/1     3h42m   postgres     postgres:13-alpine

# Проверяем доступность фронта через сервис
ivan@MBP-Ivan stage % curl http://178.154.202.225:30527 
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
</html>%        

# подключились к контейнеру и смотрим бек который видит базу
ivan@MBP-Ivan stage % kubectl exec -it main-75ddb894cf-fhzpp bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
Defaulted container "backend" out of: backend, frontend
root@main-75ddb894cf-fhzpp:/app# curl localhost:9000/api/news/
[{"id":1,"title":"title 0","short_description":"small text 0small text 0small text 0small text 0small text 0small text 0small text 0small text 0small text 0small text 0","preview":"/static/image.png"}...    
```

### Задание 2:

Запускаем манифесты prod и смотрим:
- [Deployment.yaml](./files/prod/Deployment.yaml)
- [Ingress.yaml](./files/prod/Ingress.yaml)
- [Service.yaml](./files/prod/Service.yaml)
- [Statefulset.yaml](./files/prod/Statefulset.yaml)

```bash
ivan@MBP-Ivan prod % kubectl get pods -o wide
NAME                        READY   STATUS    RESTARTS   AGE    IP               NODE       NOMINATED NODE   READINESS GATES
backend-8f98564d4-d45l5     1/1     Running   0          48s    10.233.106.137   master01   <none>           <none>
backend-8f98564d4-dkpvm     1/1     Running   0          48s    10.233.94.70     worker02   <none>           <none>
backend-8f98564d4-phdk4     1/1     Running   0          48s    10.233.69.6      worker01   <none>           <none>
db-0                        1/1     Running   0          147m   10.233.106.134   master01   <none>           <none>
frontend-5d69f69b5d-phb4x   1/1     Running   0          48s    10.233.69.7      worker01   <none>           <none>
frontend-5d69f69b5d-tzbpk   1/1     Running   0          48s    10.233.106.138   master01   <none>           <none>
frontend-5d69f69b5d-x77bd   1/1     Running   0          48s    10.233.94.71     worker02   <none>           <none>
main-d7997f56-5m6fw         2/2     Running   0          39m    10.233.69.5      worker01   <none>           <none>
main-d7997f56-d68ch         2/2     Running   0          39m    10.233.106.136   master01   <none>           <none>
main-d7997f56-s5x7r         2/2     Running   0          39m    10.233.94.69     worker02   <none>           <none>

ivan@MBP-Ivan prod % kubectl get service     
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                         AGE
backend      LoadBalancer   10.233.15.143   <pending>     9000:32408/TCP                  66s
db           ClusterIP      10.233.52.136   <none>        5432/TCP                        148m
db-srv       LoadBalancer   10.233.0.208    <pending>     5432:31223/TCP                  4h19m
frontend     LoadBalancer   10.233.28.120   <pending>     8000:31196/TCP                  66s
kubernetes   ClusterIP      10.233.0.1      <none>        443/TCP                         4h38m
main         LoadBalancer   10.233.55.50    <pending>     8000:30527/TCP,9000:31582/TCP   4h19m
```

### Задание 3:

Запускаем манифесты prod и смотрим:
- [Endpoint.yaml](./files/prod/Endpoint.yaml)

```bash
ivan@MBP-Ivan prod % kubectl get endpoints
NAME           ENDPOINTS                                                            AGE
backend        10.233.106.137:9000,10.233.69.6:9000,10.233.94.70:9000               73m
db             10.233.106.134:5432                                                  3h41m
db-srv         10.233.106.134:5432                                                  5h32m
external-api   138.197.231.124:443                                                  16s
frontend       10.233.106.138:8000,10.233.69.7:8000,10.233.94.71:8000               73m
kubernetes     192.168.101.33:6443                                                  5h51m
main           10.233.106.136:9000,10.233.69.5:9000,10.233.94.69:9000 + 3 more...   5h32m
```