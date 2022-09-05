# Домашнее задание к занятию "12.5 Сетевые решения CNI"
После работы с Flannel появилась необходимость обеспечить безопасность для приложения. Для этого лучше всего подойдет Calico.
## Задание 1: установить в кластер CNI плагин Calico
Для проверки других сетевых решений стоит поставить отличный от Flannel плагин — например, Calico. Требования: 
* установка производится через ansible/kubespray;
* после применения следует настроить политику доступа к hello-world извне. Инструкции [kubernetes.io](https://kubernetes.io/docs/concepts/services-networking/network-policies/), [Calico](https://docs.projectcalico.org/about/about-network-policy)

## Задание 2: изучить, что запущено по умолчанию
Самый простой способ — проверить командой calicoctl get <type>. Для проверки стоит получить список нод, ipPool и profile.
Требования: 
* установить утилиту calicoctl;
* получить 3 вышеописанных типа в консоли.

---

## Ответ:

## Задание 1

Создаем файл с приложением [hello-world.yaml](./giles/hello-world.yaml) и политикой [network.yaml](./files/network.yaml)

Создаем deployment и service
```bash
ivan@MacBook-Pro-Ivan files % kubectl get nodes                
NAME       STATUS   ROLES           AGE     VERSION
master01   Ready    control-plane   10m     v1.24.4
master02   Ready    control-plane   10m     v1.24.4
master03   Ready    control-plane   9m49s   v1.24.4
worker01   Ready    <none>          8m30s   v1.24.4
worker02   Ready    <none>          8m31s   v1.24.4
worker03   Ready    <none>          8m30s   v1.24.4
worker04   Ready    <none>          8m30s   v1.24.4

ivan@MacBook-Pro-Ivan files % kubectl apply -f hello-world.yaml
namespace/hello-world created
deployment.apps/hello-world created
service/hello-world created

ivan@MacBook-Pro-Ivan files % kubectl -n hello-world get pods -o wide
NAME                          READY   STATUS    RESTARTS   AGE   IP              NODE       NOMINATED NODE   READINESS GATES
hello-world-c67fb59b8-2nwvd   1/1     Running   0          37s   10.233.94.65    worker02   <none>           <none>
hello-world-c67fb59b8-f5ccp   1/1     Running   0          37s   10.233.69.1     worker01   <none>           <none>
hello-world-c67fb59b8-mm8dr   1/1     Running   0          37s   10.233.75.129   worker04   <none>           <none>

ivan@MacBook-Pro-Ivan files % kubectl get services hello-world -n hello-world
NAME          TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
hello-world   NodePort   10.233.17.179   <none>        8080:30402/TCP   13m
```

Проверяем доступность сервиса извне, до применения политики
```bash
ivan@MacBook-Pro-Ivan files % curl http://130.193.36.135:30402       

Hostname: hello-world-c67fb59b8-mm8dr

Pod Information:
        -no pod information available-

Server values:
        server_version=nginx: 1.13.3 - lua: 10008

Request Information:
        client_address=10.233.106.128
        method=GET
        real path=/
        query=
        request_version=1.1
        request_scheme=http
        request_uri=http://130.193.36.135:8080/

Request Headers:
        accept=*/*
        host=130.193.36.135:30402
        user-agent=curl/7.79.1

Request Body:
        -no body in request-
```

Применяем политику
```bash
ivan@MacBook-Pro-Ivan files % kubectl apply -f network.yaml      
networkpolicy.networking.k8s.io/default-deny-all created
networkpolicy.networking.k8s.io/test-network-policy created
```

Проверяем доступность извне и между подами
```bash
ivan@MacBook-Pro-Ivan files % curl http://130.193.36.135:30402               
curl: (28) Failed to connect to 130.193.36.135 port 30402 after 75012 ms: Operation timed out

ivan@MacBook-Pro-Ivan DevOpsNetology % ssh ubuntu@130.193.36.135

$ kubectl run test -ti --image=k8s.gcr.io/echoserver:1.4 -- bash

root@test:/# curl http://192.168.101.3:30402

Hostname: hello-world-c67fb59b8-f5ccp

Pod Information:
        -no pod information available-

Server values:
        server_version=nginx: 1.13.3 - lua: 10008

Request Information:
        client_address=192.168.101.3
        method=GET
        real path=/
        query=
        request_version=1.1
        request_scheme=http
        request_uri=http://192.168.101.3:8080/

Request Headers:
        accept=*/*
        host=192.168.101.3:30402
        user-agent=curl/7.47.0

Request Body:
        -no body in request-
```

## Задание 2

Устанавливаем calicoctl
```bash
ivan@MacBook-Pro-Ivan files % kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.24.1/manifests/calicoctl.yaml
serviceaccount/calicoctl created
pod/calicoctl created
clusterrole.rbac.authorization.k8s.io/calicoctl created
clusterrolebinding.rbac.authorization.k8s.io/calicoctl created
```

Получаем с помощью calicoctl - nodes
```bash
ivan@MacBook-Pro-Ivan files % kubectl exec -ti -n kube-system calicoctl -- /calicoctl --allow-version-mismatch get nodes -o wide
NAME       ASN       IPV4                IPV6   
master01   (64512)   192.168.101.20/24          
master02   (64512)   192.168.101.14/24          
master03   (64512)   192.168.101.32/24          
worker01   (64512)   192.168.101.3/24           
worker02   (64512)   192.168.101.21/24          
worker03   (64512)   192.168.101.31/24          
worker04   (64512)   192.168.101.18/24 
```

Получаем с помощью calicoctl - ipPool
```bash
ivan@MacBook-Pro-Ivan files % kubectl exec -ti -n kube-system calicoctl -- /calicoctl --allow-version-mismatch get ipPool -o wide
NAME           CIDR             NAT    IPIPMODE   VXLANMODE   DISABLED   DISABLEBGPEXPORT   SELECTOR   
default-pool   10.233.64.0/18   true   Never      Always      false      false              all()
```

Получаем с помощью calicoctl - profiles
```bash
ivan@MacBook-Pro-Ivan files % kubectl exec -ti -n kube-system calicoctl -- /calicoctl --allow-version-mismatch get profiles -o wide
NAME                                                 LABELS                                                                                         
projectcalico-default-allow                                                                                                                         
kns.default                                          pcns.kubernetes.io/metadata.name=default,pcns.projectcalico.org/name=default                   
kns.hello-world                                      pcns.kubernetes.io/metadata.name=hello-world,pcns.projectcalico.org/name=hello-world           
kns.kube-node-lease                                  pcns.kubernetes.io/metadata.name=kube-node-lease,pcns.projectcalico.org/name=kube-node-lease   
kns.kube-public                                      pcns.kubernetes.io/metadata.name=kube-public,pcns.projectcalico.org/name=kube-public           
kns.kube-system                                      pcns.kubernetes.io/metadata.name=kube-system,pcns.projectcalico.org/name=kube-system           
ksa.default.default                                  pcsa.projectcalico.org/name=default                                                            
ksa.hello-world.default                              pcsa.projectcalico.org/name=default                                                            
ksa.kube-node-lease.default                          pcsa.projectcalico.org/name=default                                                            
ksa.kube-public.default                              pcsa.projectcalico.org/name=default                                                            
ksa.kube-system.attachdetach-controller              pcsa.projectcalico.org/name=attachdetach-controller                                            
ksa.kube-system.bootstrap-signer                     pcsa.projectcalico.org/name=bootstrap-signer                                                   
ksa.kube-system.calico-node                          pcsa.projectcalico.org/name=calico-node                                                        
ksa.kube-system.calicoctl                            pcsa.projectcalico.org/name=calicoctl                                                          
ksa.kube-system.certificate-controller               pcsa.projectcalico.org/name=certificate-controller                                             
ksa.kube-system.clusterrole-aggregation-controller   pcsa.projectcalico.org/name=clusterrole-aggregation-controller                                 
ksa.kube-system.coredns                              pcsa.addonmanager.kubernetes.io/mode=Reconcile,pcsa.projectcalico.org/name=coredns             
ksa.kube-system.cronjob-controller                   pcsa.projectcalico.org/name=cronjob-controller                                                 
ksa.kube-system.daemon-set-controller                pcsa.projectcalico.org/name=daemon-set-controller                                              
ksa.kube-system.default                              pcsa.projectcalico.org/name=default                                                            
ksa.kube-system.deployment-controller                pcsa.projectcalico.org/name=deployment-controller                                              
ksa.kube-system.disruption-controller                pcsa.projectcalico.org/name=disruption-controller                                              
ksa.kube-system.dns-autoscaler                       pcsa.addonmanager.kubernetes.io/mode=Reconcile,pcsa.projectcalico.org/name=dns-autoscaler      
ksa.kube-system.endpoint-controller                  pcsa.projectcalico.org/name=endpoint-controller                                                
ksa.kube-system.endpointslice-controller             pcsa.projectcalico.org/name=endpointslice-controller                                           
ksa.kube-system.endpointslicemirroring-controller    pcsa.projectcalico.org/name=endpointslicemirroring-controller                                  
ksa.kube-system.ephemeral-volume-controller          pcsa.projectcalico.org/name=ephemeral-volume-controller                                        
ksa.kube-system.expand-controller                    pcsa.projectcalico.org/name=expand-controller                                                  
ksa.kube-system.generic-garbage-collector            pcsa.projectcalico.org/name=generic-garbage-collector                                          
ksa.kube-system.horizontal-pod-autoscaler            pcsa.projectcalico.org/name=horizontal-pod-autoscaler                                          
ksa.kube-system.job-controller                       pcsa.projectcalico.org/name=job-controller                                                     
ksa.kube-system.kube-proxy                           pcsa.projectcalico.org/name=kube-proxy                                                         
ksa.kube-system.namespace-controller                 pcsa.projectcalico.org/name=namespace-controller                                               
ksa.kube-system.node-controller                      pcsa.projectcalico.org/name=node-controller                                                    
ksa.kube-system.nodelocaldns                         pcsa.addonmanager.kubernetes.io/mode=Reconcile,pcsa.projectcalico.org/name=nodelocaldns        
ksa.kube-system.persistent-volume-binder             pcsa.projectcalico.org/name=persistent-volume-binder                                           
ksa.kube-system.pod-garbage-collector                pcsa.projectcalico.org/name=pod-garbage-collector                                              
ksa.kube-system.pv-protection-controller             pcsa.projectcalico.org/name=pv-protection-controller                                           
ksa.kube-system.pvc-protection-controller            pcsa.projectcalico.org/name=pvc-protection-controller                                          
ksa.kube-system.replicaset-controller                pcsa.projectcalico.org/name=replicaset-controller                                              
ksa.kube-system.replication-controller               pcsa.projectcalico.org/name=replication-controller                                             
ksa.kube-system.resourcequota-controller             pcsa.projectcalico.org/name=resourcequota-controller                                           
ksa.kube-system.root-ca-cert-publisher               pcsa.projectcalico.org/name=root-ca-cert-publisher                                             
ksa.kube-system.service-account-controller           pcsa.projectcalico.org/name=service-account-controller                                         
ksa.kube-system.service-controller                   pcsa.projectcalico.org/name=service-controller                                                 
ksa.kube-system.statefulset-controller               pcsa.projectcalico.org/name=statefulset-controller                                             
ksa.kube-system.token-cleaner                        pcsa.projectcalico.org/name=token-cleaner                                                      
ksa.kube-system.ttl-after-finished-controller        pcsa.projectcalico.org/name=ttl-after-finished-controller                                      
ksa.kube-system.ttl-controller                       pcsa.projectcalico.org/name=ttl-controller  
```