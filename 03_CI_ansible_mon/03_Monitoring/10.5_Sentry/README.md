# Домашнее задание к занятию "10.05. Sentry"

## Задание 1

Так как self-hosted Sentry довольно требовательная к ресурсам система, мы будем использовать Free cloud аккаунт.

Free cloud account имеет следующие ограничения:
- 5 000 errors
- 10 000 transactions
- 1 GB attachments

Для подключения Free cloud account:
- зайдите на sentry.io
- нажжмите "Try for free"
- используйте авторизацию через ваш github-account
- далее следуйте инструкциям

Для выполнения задания - пришлите скриншот меню Projects.

## Задание 2

Создайте python проект и нажмите `Generate sample event` для генерации тестового события.

Изучите информацию, представленную в событии.

Перейдите в список событий проекта, выберите созданное вами и нажмите `Resolved`.

Для выполнения задание предоставьте скриншот `Stack trace` из этого события и список событий проекта, 
после нажатия `Resolved`.

## Задание 3

Перейдите в создание правил алёртинга.

Выберите проект и создайте дефолтное правило алёртинга, без настройки полей.

Снова сгенерируйте событие `Generate sample event`.

Если всё было выполнено правильно - через некоторое время, вам на почту, привязанную к github аккаунту придёт
оповещение о произошедшем событии.

Если сообщение не пришло - проверьте настройки аккаунта Sentry (например привязанную почту), что у вас не было 
`sample issue` до того как вы его сгенерировали и то, что правило алёртинга выставлено по дефолту (во всех полях all).
Также проверьте проект в котором вы создаёте событие, возможно алёрт привязан к другому.

Для выполнения задания - пришлите скриншот тела сообщения из оповещения на почте.

Дополнительно поэкспериментируйте с правилами алёртинга. 
Выбирайте разные условия отправки и создавайте sample events. 

## Задание повышенной сложности

Создайте проект на ЯП python или GO (небольшой, буквально 10-20 строк), подключите к нему sentry SDK и отправьте несколько тестовых событий.
Поэкспериментируйте с различными передаваемыми параметрами, но помните об ограничениях free учетной записи cloud Sentry.

Для выполнения задания пришлите скриншот меню issues вашего проекта и 
пример кода подключения sentry sdk/отсылки событий.

---

## Ответ:

1) Register on sentry.io

<p align="center">
  <img src="./assets/1.png">
</p>

2) Stack trace and Resolved

<p align="center">
  <img src="./assets/2.png">
</p>

<p align="center">
  <img src="./assets/3.png">
</p>

3) Create alert and send email

<p align="center">
  <img src="./assets/4.png">
</p>

<p align="center">
  <img src="./assets/5.png">
</p>

4) Issues and PyScript -> [main.py](./main.py)

<p align="center">
  <img src="./assets/6.png">
</p>

```python
import sentry_sdk

sentry_sdk.init(
    dsn="*",
    traces_sample_rate=1.0
)

while True:
    num = input('Enter error number: ')
    if num == '1':
        division_by_zero = 1 / 0
    elif num == '2':
        print(x)
    elif num == '3':
        f = open("demofile.txt")
        f.write("Lorum Ipsum")
        f.close()
    elif num == '4':
        geeky_list = ["Geeky", "GeeksforGeeks", "SuperGeek", "Geek"]
        indices = [0, 1, "2", 3]
        for i in range(len(indices)):
            print(geeky_list[indices[i]])
    elif num == 'q':
        quit()
```