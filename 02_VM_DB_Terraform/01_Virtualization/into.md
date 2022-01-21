## Задача 1

Опишите кратко, как вы поняли: в чем основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.

### Ответ:
```text
полная (аппаратная) виртуализация - полноценная ОС (гипервизор) которая ставится на железо,
с возможностью создавать множество ВМ и кластеров

паравиртуализация - гипервозор который ставится поверх ОС

виртуализации на основе ОС - на самой ОС создаются виртуалки(контейнеры), но только с идентичными ядрами
```

## Задача 2

Выберите один из вариантов использования организации физических серверов, в зависимости от условий использования.

Организация серверов:
- физические сервера,
- паравиртуализация,
- виртуализация уровня ОС.

Условия использования:
- Высоконагруженная база данных, чувствительная к отказу.
- Различные web-приложения.
- Windows системы для использования бухгалтерским отделом.
- Системы, выполняющие высокопроизводительные расчеты на GPU.

Опишите, почему вы выбрали к каждому целевому использованию такую организацию.

### Ответ:
```text
Высоконагруженная база данных, чувствительная к отказу.
    - физические сервера
    БД важна скорость, а физ сервера, лучший вариант + организовать RAID 1 к примеру. 

Различные web-приложения.
    - виртуализация уровня ОС
    Все приложения будут крутиться в одной среде, требуется меньше ресурсов.
    Можно быстро развернуть новые приложения.
    
Windows системы для использования бухгалтерским отделом.
    - паравиртуализация
    Просто виртуалки которые требуются не так часто, возможно расширять ресурсы.
    Можно эффективно делать бекапы.

Системы, выполняющие высокопроизводительные расчеты на GPU.
    - физические сервера
    Так как и с БД важна скорость.
```

## Задача 3

Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.

Сценарии:

1. 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.
2. Требуется наиболее производительное бесплатное open source решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.
3. Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows инфраструктуры.
4. Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.

### Ответ:
```text
1. Hyper-V(полный) потому, что виртуалок много, база Linux и Windows он поддерживает.
Преимущественно Windows based, почему бы не взять их же продукт.
Имеется балансировщик нагрузки, репликация данных и создания резервных копий.

2. KVM потому, что бесплатный производительный open source гипервизор который работает и с  Linux и Windows.

3. VirtualBox потому, что бесплатная, популярная и совместима с Windows.
(не указано сколько виртуалок, как я понял пара штук)

4. LXC Docker потому, что продукты в одной среде, удобно тестировать и быстро разворачивать.
```

## Задача 4

Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, то создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.

### Ответ:
```text
например развернуть Virtualbox+vagrant + docker

Возможно проблемы если ляжет виртуалка(vagrant) то и лягут все контейнеры(docker)

Недостатки - двойная виртуализция, пониженная производительность из-за лишней работы аппаратной части

Что надо сделать для минимизации рисков?
Бекапы, Рейды, Мониторинг) Правильная Балансировка и Трезвая Выдача Ресурсов

Если бы у вас был выбор, то создавали бы вы гетерогенную среду или нет? 
В целом ДА, но все зависит от задач,
к примеру есть сервер(железка) туда ставим несколько виртуалок на KVM
и каждую виртуалку отдаем разным отделам, которые будут создавать на ней контейнеры(docker)
```