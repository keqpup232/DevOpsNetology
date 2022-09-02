# Домашнее задание к занятию "12.4 Развертывание кластера на собственных серверах, лекция 2"
Новые проекты пошли стабильным потоком. Каждый проект требует себе несколько кластеров: под тесты и продуктив. Делать все руками — не вариант, поэтому стоит автоматизировать подготовку новых кластеров.

## Задание 1: Подготовить инвентарь kubespray
Новые тестовые кластеры требуют типичных простых настроек. Нужно подготовить инвентарь и проверить его работу. Требования к инвентарю:
* подготовка работы кластера из 5 нод: 3 мастер и 4 рабочие ноды;
* в качестве CRI — docker;
* запуск etcd производить на мастере.

## Задание 2 (*): подготовить и проверить инвентарь для кластера в YC
Часть новых проектов хотят запускать на мощностях AWS. Требования похожи:
* разворачивать 7 нод: 3 мастер и 4 рабочие ноды;

---

## Ответ:

Подсказка по установке [kubespray](https://github.com/aak74/kubernetes-for-beginners/tree/master/15-install/30-kubespray).

Кластер разворачивается при с Terraform(YC)+Ansible+Kubespray

#### Terraform [folder](./terraform/)

#### Ansible [playbook](./playbook/site.yml)

Измененный [k8s-cluster.yml](./playbook/inventory/k8s-cluster.yml) по требованиям :
* в качестве CRI — docker;
* доступность кластера с локальной машины

Конфиг для создания [hosts.yaml](./terraform/hosts.tf) для дальнейшего использования в Kubespray.

Файл для изменения локального конфига, для доступности - [config](./terraform/config.tf)


```bash
# Вывод с плейбука
TASK [stdout] ******************************************************************
ok: [master_01] => {
    "msg": [
        "NAME       STATUS   ROLES           AGE     VERSION",
        "master01   Ready    control-plane   6m10s   v1.24.4",
        "master02   Ready    control-plane   5m34s   v1.24.4",
        "master03   Ready    control-plane   5m15s   v1.24.4",
        "worker01   Ready    <none>          4m10s   v1.24.4",
        "worker02   Ready    <none>          4m10s   v1.24.4",
        "worker03   Ready    <none>          4m10s   v1.24.4",
        "worker04   Ready    <none>          4m10s   v1.24.4"
    ]
}

# Проверяем доступность локально
ivan@MacBook-Pro-Ivan terraform % kubectl get nodes                                                                          
NAME       STATUS   ROLES           AGE   VERSION
master01   Ready    control-plane   12m   v1.24.4
master02   Ready    control-plane   12m   v1.24.4
master03   Ready    control-plane   11m   v1.24.4
worker01   Ready    <none>          10m   v1.24.4
worker02   Ready    <none>          10m   v1.24.4
worker03   Ready    <none>          10m   v1.24.4
worker04   Ready    <none>          10m   v1.24.4
```