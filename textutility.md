# Домашнее задание к занятию "Работа с текстовыми утилитами" 

Третьяков Виктор

### Чеклист готовности к домашнему заданию

1. Установлена операционная система Ubuntu на виртуальную машину или локально и имеется доступ к терминалу (удаленный или из графической оболочки)
2. Просмотрены скрипты, рассматриваемые на лекции, которые находятся по [ссылке](5-04/)
3. Установлена утилита mlocate `sudo apt-get install mlocate`
------

### Инструкция к заданию

1. Для успешного выполнения задания необходимо составить конвейеры из нескольких команд
2. На проверку необходимо направить команды в текстовом виде и скриншот, демонстрирующий работу каждой команды.

------

### Задание 1.

- Найдите все файлы с расширением `.conf` в /etc сначала с помощью команды `find`, а потом с помощью команды `locate`;
- Перенаправьте результаты работы каждой команды в разные файлы;
- Подсчитайте количество найденных файлов в каждом случае с помощью `wc`.

find /etc -type f -name '*.conf' > /home/tretyakov/find.txt; wc -l /home/tretyakov/find.txt

locate '/etc/*.conf' > /home/tretyakov/locale.txt; wc -l /home/tretyakov/locate.txt

![](/images/textutils/task1.png "1 скрин 1 задания")
------
### Задание 2.

 - Выведите с помощью `cat` содержимое всех файлов в директории /etc `cat /etc/*`;
 - Направьте ошибки в отдельный файл в вашей домашней директории;
 - Стандартный поток вывода направьте в другой файл;
 - Подсчитайте, сколько объектов не удалось прочитать.

cat /etc/* > ~/catetc 2> ~/caterrors; cat ~/caterrors | wc - l

 ![](/images/textutils/task2.png "1 скрин 2 задания")
------
### Задание 3.

 - Перенаправьте результат работы команды `ls -l` в каталоге с большим количеством файлов в утилиту `cut`, чтобы отобразить только права доступа к файлам;
 - Отправьте в конвейере этот вывод на `sort` и `uniq`, чтобы отфильтровать все повторяющиеся строки;
 - Уберите из подсчета строку `total`;
 - С помощью `wc` подсчитайте различные типы разрешений в этом каталоге.

ls -l /dev | cut -f1 -d " " | sort | uniq -c | sed '/total/d' | wc -l

![](/images/textutils/task3.png "1 скрин 3 задания")
------
## Дополнительные задания (со звездочкой*)

Эти задания дополнительные (не обязательные к выполнению) и никак не повлияют на получение вами зачета по этому домашнему заданию. Вы можете их выполнить, если хотите глубже и/или шире разобраться в материале.

### Задание 4.

В ОС Linux скрытыми файлами считаются те, имена которых начинаются с точки.

Сколько скрытых файлов в вашем домашнем каталоге?

find ~/ -type f -name '.*' | wc -l

![](/images/textutils/task4.png "1 скрин 4 задания")




