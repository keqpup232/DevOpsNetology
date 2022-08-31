# Домашнее задание к занятию "12.2 Команды для работы с Kubernetes"
Кластер — это сложная система, с которой крайне редко работает один человек. Квалифицированный devops умеет наладить работу всей команды, занимающейся каким-либо сервисом.
После знакомства с кластером вас попросили выдать доступ нескольким разработчикам. Помимо этого требуется служебный аккаунт для просмотра логов.

## Задание 1: Запуск пода из образа в деплойменте
Для начала следует разобраться с прямым запуском приложений из консоли. Такой подход поможет быстро развернуть инструменты отладки в кластере. Требуется запустить деплоймент на основе образа из hello world уже через deployment. Сразу стоит запустить 2 копии приложения (replicas=2). 

Требования:
 * пример из hello world запущен в качестве deployment
 * количество реплик в deployment установлено в 2
 * наличие deployment можно проверить командой kubectl get deployment
 * наличие подов можно проверить командой kubectl get pods


## Задание 2: Просмотр логов для разработки
Разработчикам крайне важно получать обратную связь от штатно работающего приложения и, еще важнее, об ошибках в его работе. 
Требуется создать пользователя и выдать ему доступ на чтение конфигурации и логов подов в app-namespace.

Требования: 
 * создан новый токен доступа для пользователя
 * пользователь прописан в локальный конфиг (~/.kube/config, блок users)
 * пользователь может просматривать логи подов и их конфигурацию (kubectl logs pod <pod_id>, kubectl describe pod <pod_id>)


## Задание 3: Изменение количества реплик 
Поработав с приложением, вы получили запрос на увеличение количества реплик приложения для нагрузки. Необходимо изменить запущенный deployment, увеличив количество реплик до 5. Посмотрите статус запущенных подов после увеличения реплик. 

Требования:
 * в deployment из задания 1 изменено количество реплик на 5
 * проверить что все поды перешли в статус running (kubectl get pods)

---

## Ответ:

Все задание выполнено в связке Terraform(YC)+Ansible

#### Terraform [folder](./terraform/)

#### Ansible [playbook](./playbook/site.yml)

### Задание 1:

Создаем namespace и запускаем deployment через файл [deployment_2.yaml](./playbook/kubectl/deployment_2.yaml)

```
kubectl create namespace app-namespace
kubectl apply -f /home/centos/.kube/deployment_2.yaml

kubectl get deployments,pods -n app-namespace
NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/hello-minikube   2/2     2            2           5m40s

NAME                                  READY   STATUS    RESTARTS   AGE
pod/hello-minikube-6b8969dc84-s25lw   1/1     Running   0          5m40s
pod/hello-minikube-6b8969dc84-swn58   1/1     Running   0          5m40s
```

### Задание 2:

Создаем сервисный аккаунт, токен, правила через файл [All.yaml](./playbook/kubectl/All.yaml)

Создаем новый [config](./playbook/kubectl/config) для пользователя и проверяем

```
kubectl apply -f /home/centos/.kube/All.yaml

kubectl --kubeconfig /home/centos/.kube/client get deployments -n app-namespace
Error from server (Forbidden): deployments.apps is forbidden: User "system:serviceaccount:app-namespace:jane" cannot list resource "deployments" in API group "apps" in the namespace "app-namespace"


kubectl --kubeconfig /home/centos/.kube/client get pods -n app-namespace
NAME                              READY   STATUS    RESTARTS   AGE
hello-minikube-6b8969dc84-s25lw   1/1     Running   0          7m20s
hello-minikube-6b8969dc84-swn58   1/1     Running   0          7m20s
```

### Задание 3:

Запускаем deployment через файл [deployment_5.yaml](./playbook/kubectl/deployment_5.yaml)

Или можно поменять количество в файле [deployment_2.yaml](./playbook/kubectl/deployment_2.yaml) на 5.

```
kubectl apply -f /home/centos/.kube/deployment_5.yaml

kubectl get pods -n app-namespace
NAME                              READY   STATUS    RESTARTS   AGE
hello-minikube-6b8969dc84-6fljv   1/1     Running   0          11s
hello-minikube-6b8969dc84-nd5tl   1/1     Running   0          11s
hello-minikube-6b8969dc84-s25lw   1/1     Running   0          8m2s
hello-minikube-6b8969dc84-sr7gg   1/1     Running   0          11s
hello-minikube-6b8969dc84-swn58   1/1     Running   0          8m2s
```

Хотел по статье [Accessing a remote minikube from a local computer NGINX](https://faun.pub/accessing-a-remote-minikube-from-a-local-computer-fd6180dd66dd) поднять nginx для того, что бы API minikube был доступен в локальной сети,

Что бы дальнейшем использовать конфиг кубера с сервисным аккаунтом на соседней машине, для проверки прав.

Но не получилось( minikube отваливался по 504 Gateway Time-out
```
[error] 22#22: *1 connect() failed (110: Connection timed out) while connecting to upstream, client: 94.25.171.111, server: localhost, request: "GET /favicon.ico HTTP/1.1", upstream: "https://192.168.49.2:8443/favicon.ico", host: "51.250.73.10:8080", referrer: "http://51.250.73.10:8080/"
```
