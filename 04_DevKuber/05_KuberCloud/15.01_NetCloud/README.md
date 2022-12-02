# Домашнее задание к занятию "15.1. Организация сети"

Домашнее задание будет состоять из обязательной части, которую необходимо выполнить на провайдере Яндекс.Облако и дополнительной части в AWS по желанию. Все домашние задания в 15 блоке связаны друг с другом и в конце представляют пример законченной инфраструктуры.  
Все задания требуется выполнить с помощью Terraform, результатом выполненного домашнего задания будет код в репозитории. 

Перед началом работ следует настроить доступ до облачных ресурсов из Terraform используя материалы прошлых лекций и [ДЗ](https://github.com/netology-code/virt-homeworks/tree/master/07-terraform-02-syntax ). А также заранее выбрать регион (в случае AWS) и зону.

---
## Задание 1. Яндекс.Облако (обязательное к выполнению)

1. Создать VPC.
- Создать пустую VPC. Выбрать зону.
2. Публичная подсеть.
- Создать в vpc subnet с названием public, сетью 192.168.10.0/24.
- Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1
- Создать в этой публичной подсети виртуалку с публичным IP и подключиться к ней, убедиться что есть доступ к интернету.
3. Приватная подсеть.
- Создать в vpc subnet с названием private, сетью 192.168.20.0/24.
- Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс
- Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее и убедиться что есть доступ к интернету

Resource terraform для ЯО
- [VPC subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet)
- [Route table](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table)
- [Compute Instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance)
---
## Задание 2*. AWS (необязательное к выполнению)

1. Создать VPC.
- Cоздать пустую VPC с подсетью 10.10.0.0/16.
2. Публичная подсеть.
- Создать в vpc subnet с названием public, сетью 10.10.1.0/24
- Разрешить в данной subnet присвоение public IP по-умолчанию. 
- Создать Internet gateway 
- Добавить в таблицу маршрутизации маршрут, направляющий весь исходящий трафик в Internet gateway.
- Создать security group с разрешающими правилами на SSH и ICMP. Привязать данную security-group на все создаваемые в данном ДЗ виртуалки
- Создать в этой подсети виртуалку и убедиться, что инстанс имеет публичный IP. Подключиться к ней, убедиться что есть доступ к интернету.
- Добавить NAT gateway в public subnet.
3. Приватная подсеть.
- Создать в vpc subnet с названием private, сетью 10.10.2.0/24
- Создать отдельную таблицу маршрутизации и привязать ее к private-подсети
- Добавить Route, направляющий весь исходящий трафик private сети в NAT.
- Создать виртуалку в приватной сети.
- Подключиться к ней по SSH по приватному IP через виртуалку, созданную ранее в публичной подсети и убедиться, что с виртуалки есть выход в интернет.

Resource terraform
- [VPC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
- [Subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)
- [Internet Gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)

---

## Ответ:

### Задание 1:

1. Создать VPC.
- Создать пустую VPC. Выбрать зону. -> [vpc.tf](./yc/vpc.tf) 
2. Публичная подсеть.
- Создать в vpc subnet с названием public, сетью 192.168.10.0/24. -> [subnet.tf](./yc/subnet.tf) 
- Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1 -> [nat-instance.tf](./yc/nat-instance.tf) 
- Создать в этой публичной подсети виртуалку с публичным IP и подключиться к ней, убедиться что есть доступ к интернету. -> [vm.tf](./yc/vm.tf) 
3. Приватная подсеть.
- Создать в vpc subnet с названием private, сетью 192.168.20.0/24. -> [subnet.tf](./yc/subnet.tf) 
- Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс -> [route-table.tf](./yc/route-table.tf) 
- Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее и убедиться что есть доступ к интернету -> [vm.tf](./yc/vm.tf) 

All terraform [Resources](./yc/)

Result
```bash
terraform apply
#out
external_ip_address_nat-instance = "130.193.36.124"
external_ip_address_vm-private = ""
external_ip_address_vm-public = "51.250.75.151"
internal_ip_address_nat-instance = "192.168.10.254"
internal_ip_address_vm-private = "192.168.20.33"
internal_ip_address_vm-public = "192.168.10.8"

ivan@MBP-Ivan yc % yc compute instances list --folder-id b1g7evdi2gkc7jqre2af
+----------------------+--------------+---------------+---------+----------------+----------------+
|          ID          |     NAME     |    ZONE ID    | STATUS  |  EXTERNAL IP   |  INTERNAL IP   |
+----------------------+--------------+---------------+---------+----------------+----------------+
| fhmdto8pte61hj99ocjl | nat-instance | ru-central1-a | RUNNING | 130.193.36.124 | 192.168.10.254 |
| fhmpji1mjn8uf8dvab79 | vm-public    | ru-central1-a | RUNNING | 51.250.75.151  | 192.168.10.8   |
| fhmrimtiq336mdogut6i | vm-private   | ru-central1-a | RUNNING |                | 192.168.20.33  |
+----------------------+--------------+---------------+---------+----------------+----------------+

ivan@MBP-Ivan yc % ssh ubuntu@51.250.75.151 curl -sS ifconfig.me
51.250.75.151

ivan@MBP-Ivan yc % ssh -J ubuntu@51.250.75.151 ubuntu@192.168.20.33 curl -sS ifconfig.me
130.193.36.124
```