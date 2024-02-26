# Домашнее задание к занятию 4. «PostgreSQL» Третьяков Виктор

# Задача 1

Используя Docker, поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL, используя psql.

Воспользуйтесь командой \? для вывода подсказки по имеющимся в psql управляющим командам.

Найдите и приведите управляющие команды для:

вывода списка БД,
`\l`

подключения к БД,
`\c` 

вывода списка таблиц,
`\dt`

вывода описания содержимого таблиц,
`\dS+`

выхода из psql.
`\q`

---

# Задача 2

Используя psql, создайте БД test_database.
```sql
CREATE DATABASE test_database;
```
Изучите бэкап БД.

Восстановите бэкап БД в test_database.
```bash
psql -U postgres -d test_database < /data/backup/postgres/test_dump.sql
```
Перейдите в управляющую консоль psql внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.
```sql
ANALYZE VERBOSE orders;
```
Используя таблицу pg_stats, найдите столбец таблицы orders с наибольшим средним значением размера элементов в байтах.
```sql
SELECT tablename, attname, avg_width FROM pg_stats WHERE tablename='orders' ORDER BY avg_width DESC LIMIT 1;
```
Приведите в ответе команду, которую вы использовали для вычисления, и полученный результат.
![task2](/bd_devops/postgresql/task2_1.png)

---

# Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и поиск по ней занимает долгое время. Вам как успешному выпускнику курсов DevOps в Нетологии предложили провести разбиение таблицы на 2: шардировать на orders_1 - price>499 и orders_2 - price<=499.

Предложите SQL-транзакцию для проведения этой операции.
создаем
```sql
CREATE TABLE orders_1 (CHECK (price > 499)) INHERITS (orders);
CREATE TABLE orders_2 (CHECK (price <= 499)) INHERITS (orders);
```
заполняем старыми данными
```sql
INSERT INTO orders_1 SELECT * FROM orders WHERE price > 499;
INSERT INTO orders_2 SELECT * FROM orders WHERE price <= 499;
```
![task3](/bd_devops/postgresql/task3_1.png)

Можно ли было изначально исключить ручное разбиение при проектировании таблицы orders?

Можно, но желательно при проектировании определить по какому полю производить шардирование, чтобы оно было равномерно на протяжении всей жизни бд.

---

# Задача 4

Используя утилиту pg_dump, создайте бекап БД test_database.
```bash
pg_dump -U postgres test_database > /tmp/backup.sql
```
Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца title для таблиц test_database?
добавить свойство UNIQUE

`title character varying(80) NOT NULL UNIQUE`

Как cдавать задание
Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---