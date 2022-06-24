# Домашнее задание к занятию "09.05 Teamcity"

## Подготовка к выполнению

1. В Ya.Cloud создайте новый инстанс (4CPU4RAM) на основе образа `jetbrains/teamcity-server`
2. Дождитесь запуска teamcity, выполните первоначальную настройку
3. Создайте ещё один инстанс(2CPU4RAM) на основе образа `jetbrains/teamcity-agent`. Пропишите к нему переменную окружения `SERVER_URL: "http://<teamcity_url>:8111"`
4. Авторизуйте агент
5. Сделайте fork [репозитория](https://github.com/aragastmatb/example-teamcity)
6. Создать VM (2CPU4RAM) и запустить [playbook](./infrastructure)

## Основная часть

1. Создайте новый проект в teamcity на основе fork
2. Сделайте autodetect конфигурации
3. Сохраните необходимые шаги, запустите первую сборку master'a
4. Поменяйте условия сборки: если сборка по ветке `master`, то должен происходит `mvn clean deploy`, иначе `mvn clean test`
5. Для deploy будет необходимо загрузить [settings.xml](./teamcity/settings.xml) в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus
6. В pom.xml необходимо поменять ссылки на репозиторий и nexus
7. Запустите сборку по master, убедитесь что всё прошло успешно, артефакт появился в nexus
8. Мигрируйте `build configuration` в репозиторий
9. Создайте отдельную ветку `feature/add_reply` в репозитории
10. Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово `hunter`
11. Дополните тест для нового метода на поиск слова `hunter` в новой реплике
12. Сделайте push всех изменений в новую ветку в репозиторий
13. Убедитесь что сборка самостоятельно запустилась, тесты прошли успешно
14. Внесите изменения из произвольной ветки `feature/add_reply` в `master` через `Merge`
15. Убедитесь, что нет собранного артефакта в сборке по ветке `master`
16. Настройте конфигурацию так, чтобы она собирала `.jar` в артефакты сборки
17. Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны
18. Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity
19. В ответ предоставьте ссылку на репозиторий

---

### Ответ:
## Подготовка к выполнению
1) terraform apply, который после создания master запустит terraform agent`a, т.к. яндекс провайдер не может depends_on в yandex_compute_instance
2) http://51.250.82.246:8111 -> proceed -> Internal (HSQLDB) -> proceed -> accept licence -> create admin user
3) already created in 1)
4) In master web -> Agents -> Unauthorized -> Authorize
5) done https://github.com/keqpup232/example-teamcity
6) already created in 1)

## Основная часть
1) Создайте новый проект в teamcity на основе fork
```text
    -> Create project -> Manually -> Name [netology] -> Create 
    -> Add ssh key -> Create Build -> Repository URL [git@github.com:keqpup232/example-teamcity.git] -> Proceed
```

2) Сделайте autodetect конфигурации
```text
    -> Up [Maven] -> Use selected
```

3) Сохраните необходимые шаги, запустите первую сборку master'a
<p align="center">
  <img src="./assets/1.png">
</p>

4) Поменяйте условия сборки: если сборка по ветке `master`, то должен происходит `mvn clean deploy`, иначе `mvn clean test`
<p align="center">
  <img src="./assets/2.png">
</p>

5) Для deploy будет необходимо загрузить [settings.xml](./teamcity/settings.xml) и добавить в настройки build
<p align="center">
  <img src="./assets/3.png">
</p>

6) В pom.xml необходимо поменять ссылки на репозиторий и nexus
```text
https://github.com/keqpup232/example-teamcity/blob/master/pom.xml
```

7) Запустите сборку по master, убедитесь что всё прошло успешно, артефакт появился в nexus
<p align="center">
  <img src="./assets/4.png">
</p>
<p align="center">
  <img src="./assets/5.png">
</p>

8) Мигрируйте `build configuration` в репозиторий
<p align="center">
  <img src="./assets/6.png">
</p>

9) Создайте отдельную ветку `feature/add_reply` в репозитории
<p align="center">
  <img src="./assets/7.png">
</p>

10) Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово `hunter`
```bash
	public String sayHunter(){
		return "In 2007, hunter said, A non-white majority America would simply.";
	}
```
11) Дополните тест для нового метода на поиск слова `hunter` в новой реплике
```bash
	@Test
	public void welcomerSaysHunter() {
		assertThat(welcomer.sayWelcome(), containsString("hunter"));
		assertThat(welcomer.sayFarewell(), containsString("hunter"));
		assertThat(welcomer.sayHunter(), containsString("hunter"));
	}
```
12) Сделайте push всех изменений в новую ветку в репозиторий [done]
13) Убедитесь что сборка самостоятельно запустилась, тесты прошли успешно
<p align="center">
  <img src="./assets/8.png">
</p>

14) Внесите изменения из произвольной ветки `feature/add_reply` в `master` через `Merge` [done]
15) Убедитесь, что нет собранного артефакта в сборке по ветке `master`

отвалился по коду 400, Repository does not allow updating assets: maven-releases, как и надо
<p align="center">
  <img src="./assets/9.png">
</p>

16) Настройте конфигурацию так, чтобы она собирала `.jar` в артефакты сборки
<p align="center">
  <img src="./assets/10.png">
</p>

17) Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны
<p align="center">
  <img src="./assets/11.png">
</p>

<p align="center">
  <img src="./assets/12.png">
</p>

18) Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity [done]
19) В ответ предоставьте ссылку на репозиторий -> [keqpup232/example-teamcity](https://github.com/keqpup232/example-teamcity)