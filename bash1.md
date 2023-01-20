# Домашнее задание к занятию "Переменные и условные операторы" 

### Цель задания
В результате выполнения этого задания вы научитесь:
1. Использовать на практике переменные и условные операторы if и case;
2. Считывать и работать с данными, которые пользователь вводит с клавиатуры в терминале;
3. Сравнивать числовые переменные между собой.
------

### Чеклист готовности к домашнему заданию

1. Установлена операционная система Ubuntu на виртуальную машину или локально и имеется доступ к терминалу (удаленный или из графической оболочки)
2. Просмотрены скрипты, рассматриваемые на лекции, которые находятся по [ссылке](5-01/)
------

### Инструкция к заданию

1. Для успешного выполнения задания необходимо написать три bash скрипта.
2. На проверку необходимо направить код каждого скрипта и скриншот, демонстрирующий различные сценарии работы данного скрипта.

------
### Задание 1.

Напишите скрипт, который при запуске спрашивает у пользователя путь до директории и создает ее при условии, что ее еще не существует. 

Если директория существует – пользователю выводится сообщение, что директория существует.

Скрипт должен принимать абсолютный путь до директории, например `/tmp/testdir` или `/home/user/testdir`


------
### Задание 2.

Напишите скрипт:
1. При запуске скрипта пользователь вводит два числа.
2. Необходимо вычесть из большего числа меньшее и вывести результат в консоль.
3. Если числа равны – умножить их друг на друга (или возвести в квадрат одно из чисел) и вывести результат в консоль.


------
### Задание 3.

Напишите скрипт с использованием оператора `case`:
1. При запуске скрипта пользователь вводит в консоль имя файла с расширением, например 123.jpg или track.mp3.
2. Необходимо сообщить пользователю тип файла:
- Если jpg, gif или png – вывести слово «image»
- Если mp3 или wav – вывести слово «audio»
- Если txt или doc – вывести слово «text»
- Если формат не подходит под заданные выше – написать «unknown»

------
## Дополнительные задания (со звездочкой*)

Эти задания дополнительные (не обязательные к выполнению) и никак не повлияют на получение вами зачета по этому домашнему заданию. Вы можете их выполнить, если хотите глубже и/или шире разобраться в материале.

### Задание 4.

Напишите скрипт, который принимает на вход IP адрес и порт.

Программа проверяет доступность данного порта (например, через `telnet`) и сообщает пользователю, доступен данный порт или нет.

Также программа осуществляет запись сообщения в системный лог `/var/log/syslog` о доступности или недоступности порта.

------

### Правила приема работы

Домашнее задание выполните в Google Docs и отправьте в личном кабинете на проверку ссылку на ваш документ.

Название файла должно содержать название лекции и фамилию студента. Пример названия: "Программирование на Bash : Переменные и условные операторы - Иван Иванов"

Перед тем как выслать ссылку, убедитесь, что ее содержимое не является приватным (открыто на просмотр всем, у кого есть ссылка).

В файле должен присутствовать номер задания, текст задания, код скрипта и скриншоты, демонстрирующие корректную работу скрипта.

Любые вопросы по решению задач задавайте в чате учебной группы в Discord.