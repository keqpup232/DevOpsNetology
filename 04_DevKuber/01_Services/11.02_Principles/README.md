# Домашнее задание к занятию "11.02 Микросервисы: принципы"

Вы работаете в крупной компанию, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps специалисту необходимо выдвинуть предложение по организации инфраструктуры, для разработки и эксплуатации.

## Задача 1: API Gateway 

Предложите решение для обеспечения реализации API Gateway. Составьте сравнительную таблицу возможностей различных программных решений. На основе таблицы сделайте выбор решения.

Решение должно соответствовать следующим требованиям:
- Маршрутизация запросов к нужному сервису на основе конфигурации
- Возможность проверки аутентификационной информации в запросах
- Обеспечение терминации HTTPS

Обоснуйте свой выбор.

---

Ответ:

| API Gateway     | Routing services by config | Authentication | HTTPS |
|-----------------|----------------------------|----------------|-------|
| Kong            | +                          | +              | +     |
| Tyk.io          | +                          | +              | +     |
| Apigee          | +                          | +              | +     |
| Amazon AWS      | +                          | +              | +     |
| Azure           | +                          | +              | +     |
| Express         | +                          | +              | +     |
| KrakenD         | +                          | +              | +     |
| Apache APISIX   | +                          | +              | +     |
| Ocelot          | +                          | +              | -     |
| Goku            | -                          | +              | +     |
| Gloo            | +                          | +              | +     |
| Fusio           | +                          | +              | -     |
| WSO2            | +                          | +              | +     |
| NGINX           | +                          | +              | +     |

В целом продуктов очень много и разных с большим функционалом, я бы выбрал KrakenD т.к. имеет весь необходимый функционал, хорошую документацию и быстрее по сравнению с другими продуктами на рынке.

https://www.krakend.io/

<p align="center">
  <img src="./assets/1.png">
</p>

---

## Задача 2: Брокер сообщений

Составьте таблицу возможностей различных брокеров сообщений. На основе таблицы сделайте обоснованный выбор решения.

Решение должно соответствовать следующим требованиям:
- Поддержка кластеризации для обеспечения надежности
- Хранение сообщений на диске в процессе доставки
- Высокая скорость работы
- Поддержка различных форматов сообщений
- Разделение прав доступа к различным потокам сообщений
- Протота эксплуатации

Обоснуйте свой выбор.

---

| Message Broker | clustering support | Storing messages on disk | High speed | Various formats | Distribution of access | Simpless |
|----------------|--------------------|--------------------------|------------|-----------------|------------------------|----------|
| ActiveMQ       | +                  | +                        | +          | +               | +                      | +        |
| RabbitMQ       | +                  | +                        | +          | +               | +                      | +        |
| Redis          | +                  | -                        | +          | -               | +                      | +        |
| FFMQ           | +                  | +                        | ++         | -               | -                      | +        |
| Apollo         | +                  | +                        | +          | +               | +                      | +        |
| ZeroMQ         | +                  | +                        | ++         | -               | -                      | +        |

Есть большое сравнение по ссылке ниже
https://ultimate-comparisons.github.io/ultimate-message-broker-comparison/

Судя по большому количеству Google hits выигрывает ActiveMQ + подходит по всем параметрам, можно взять его.

---

## Задача 3: API Gateway * (необязательная)

### Есть три сервиса:

**minio**
- Хранит загруженные файлы в бакете images
- S3 протокол

**uploader**
- Принимает файл, если он картинка сжимает и загружает его в minio
- POST /v1/upload

**security**
- Регистрация пользователя POST /v1/user
- Получение информации о пользователе GET /v1/user
- Логин пользователя POST /v1/token
- Проверка токена GET /v1/token/validation

### Необходимо воспользоваться любым балансировщиком и сделать API Gateway:

**POST /v1/register**
- Анонимный доступ.
- Запрос направляется в сервис security POST /v1/user

**POST /v1/token**
- Анонимный доступ.
- Запрос направляется в сервис security POST /v1/token

**GET /v1/user**
- Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/
- Запрос направляется в сервис security GET /v1/user

**POST /v1/upload**
- Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/
- Запрос направляется в сервис uploader POST /v1/upload

**GET /v1/user/{image}**
- Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/
- Запрос направляется в сервис minio  GET /images/{image}

### Ожидаемый результат

Результатом выполнения задачи должен быть docker compose файл запустив который можно локально выполнить следующие команды с успешным результатом.
Предполагается что для реализации API Gateway будет написан конфиг для NGinx или другого балансировщика нагрузки который будет запущен как сервис через docker-compose и будет обеспечивать балансировку и проверку аутентификации входящих запросов.

**Авторизации**

curl -X POST -H 'Content-Type: application/json' -d '{"login":"bob", "password":"qwe123"}' http://localhost/token

**Загрузка файла**

curl -X POST -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJib2IifQ.hiMVLmssoTsy1MqbmIoviDeFPvo-nCd92d4UFiN2O2I' -H 'Content-Type: octet/stream' --data-binary @yourfilename.jpg http://localhost/upload

**Получение файла**

curl -X GET http://localhost/images/4e6df220-295e-4231-82bc-45e4b1484430.jpg

---

#### [Дополнительные материалы: как запускать, как тестировать, как проверить](https://github.com/netology-code/devkub-homeworks/tree/main/11-microservices-02-principles)

---

### Ответ

Конфиг [nginx.conf](services/gateway/nginx.conf)

Конфиг [docker-compose](services/docker-compose.yaml)

Вывод
```bash
ivan@MBP-Ivan services % curl -X POST -H 'Content-Type: application/json' -d '{"login":"bob", "password":"qwe123"}' http://localhost/token
eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJib2IifQ.hiMVLmssoTsy1MqbmIoviDeFPvo-nCd92d4UFiN2O2I%                                                                                 

ivan@MBP-Ivan services % curl -X POST -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJib2IifQ.hiMVLmssoTsy1MqbmIoviDeFPvo-nCd92d4UFiN2O2I' -H 'Content-Type: octet/stream' --data-binary @1.jpg http://localhost/upload
<?xml version="1.0" encoding="UTF-8"?>
<Error><Code>BadRequest</Code><Message>An error occurred when parsing the HTTP request POST at &#39;/v1/upload&#39;</Message><Resource>/v1/upload</Resource><RequestId></RequestId><HostId>93ca7dc2-d5d8-4f5c-b916-fb7af116c411</HostId></Error>%     
 
ivan@MacBook-Pro-Ivan services % curl -X GET -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJib2IifQ.hiMVLmssoTsy1MqbmIoviDeFPvo-nCd92d4UFiN2O2I' http://localhost/images/85c2a342-d19a-40d3-bdaf-7a214b4f45b4.jpg > 2.jpg
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   99k  100   99k    0     0  2901k      0 --:--:-- --:--:-- --:--:-- 4532k

ivan@MBP-Ivan services % ls
1.jpg                                           gateway                                         uploader
c31e9789-3fab-4689-aa67-e7ac2684fb0e.jpg        readme.md
docker-compose.yaml                             security
```