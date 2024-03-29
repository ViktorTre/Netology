# Домашнее задание к занятию «Ansible.Часть 2» - Третьяков Виктор

### Задание 1

**Выполните действия, приложите файлы с плейбуками и вывод выполнения.**

Напишите три плейбука. 

1. Скачать какой-либо архив, создать папку для распаковки и распаковать скаченный архив. Например, можете использовать [официальный сайт](https://kafka.apache.org/downloads) и зеркало Apache Kafka. При этом можно скачать как исходный код, так и бинарные файлы, запакованные в архив — в нашем задании не принципиально.

![ansible2.yml](https://github.com/ViktorTre/Netology/tree/main/cicd/ansible_2/ansible2.yml)

![playbook kafka](/cicd/ansible_2/kafka.png)

![kafka](/cicd/ansible_2/kafka2.png)

---

2. Установить пакет tuned из стандартного репозитория вашей ОС. Запустить его, как демон — конфигурационный файл systemd появится автоматически при установке. Добавить tuned в автозагрузку.

![ansible2.yml](https://github.com/ViktorTre/Netology/tree/main/cicd/ansible_2/ansible2.yml)

![playbook tuned](/cicd/ansible_2/tuned.png)

![tuned](/cicd/ansible_2/tuned2.png)

---

3. Изменить приветствие системы (motd) при входе на любое другое. Пожалуйста, в этом задании используйте переменную для задания приветствия. Переменную можно задавать любым удобным способом.

![role motd](https://github.com/ViktorTre/Netology/tree/main/cicd/ansible_2/motd)

![playbook motd](/cicd/ansible_2/motd1.png)

![motd](/cicd/ansible_2/motd2.png)

---

### Задание 2

**Выполните действия, приложите файлы с модифицированным плейбуком и вывод выполнения.** 

Модифицируйте плейбук из пункта 3, задания 1. В качестве приветствия он должен установить IP-адрес и hostname управляемого хоста, пожелание хорошего дня системному администратору. 

![role motd](https://github.com/ViktorTre/Netology/tree/main/cicd/ansible_2/motd)

![playbook motd](/cicd/ansible_2/motd1.png)

![motd](/cicd/ansible_2/motd2.png)

---

### Задание 3

**Выполните действия, приложите архив с ролью и вывод выполнения.**

Ознакомьтесь со статьёй [«Ansible - это вам не bash»](https://habr.com/ru/post/494738/), сделайте соответствующие выводы и не используйте модули **shell** или **command** при выполнении задания.

Создайте плейбук, который будет включать в себя одну, созданную вами роль. Роль должна:

![role apache](https://github.com/ViktorTre/Netology/tree/main/cicd/ansible_2/apache)

1. Установить веб-сервер Apache на управляемые хосты.
2. Сконфигурировать файл index.html c выводом характеристик каждого компьютера как веб-страницу по умолчанию для Apache. Необходимо включить CPU, RAM, величину первого HDD, IP-адрес. Используйте [Ansible facts](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_vars_facts.html) и [jinja2-template](https://linuxways.net/centos/how-to-use-the-jinja2-template-in-ansible/)
3. Открыть порт 80, если необходимо, запустить сервер и добавить его в автозагрузку.
4. Сделать проверку доступности веб-сайта (ответ 200, модуль uri).

![playbook apache](/cicd/ansible_2/apache1.png)

![external apache](/cicd/ansible_2/apache2.png)

![internal apache](/cicd/ansible_2/apache3.png)

---
добавил в роль apache handlers, теперь если конфигурация апач не изменилась - не проиходит перезагрузка веб-сервера
![role apache](https://github.com/ViktorTre/Netology/tree/main/cicd/ansible_2/apache/handlers)


![extra1](/cicd/ansible_2/extratask1.png)

![extra2](/cicd/ansible_2/extratask2.png)