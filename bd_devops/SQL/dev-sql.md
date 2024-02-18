# Домашнее задание к занятию 2. «SQL» - Третьяков Виктор
---
## Задача 1

Используя Docker, поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose-манифест.
``` 
version: '3.5'
services:
  postgres:
    image: postgres:12
    environment:
      - POSTGRES_PASSWORD=pass
      - POSTGRES_USER=postgres
    volumes:
      - ./data:/var/lib/postgresql/data
      - ./backup:/data/backup/postgres
    ports:
      - "5432:5432"
    restart: always
``` 
![docker-compose.yml](/bd_devops/SQL/docker-compose.yml)  
![task.sql](/bd_devops/SQL/task.sql)
---
## Задача 2

В БД из задачи 1: 

- создайте пользователя test-admin-user и БД test_db;
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже);
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db;
- создайте пользователя test-simple-user;
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE этих таблиц БД test_db.

Таблица orders:

- id (serial primary key);
- наименование (string);
- цена (integer).

Таблица clients:

- id (serial primary key);
- фамилия (string);
- страна проживания (string, index);
- заказ (foreign key orders).

Приведите:

- итоговый список БД после выполнения пунктов выше;

![task2](/bd_devops/SQL/task2_1.png)

- описание таблиц (describe);

![task2](/bd_devops/SQL/task2_2.png)

- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db;  
```
SELECT table_name,grantee,privilege_type FROM information_schema.table_privileges WHERE table_schema NOT IN ('information_schema','pg_catalog');
```  
- список пользователей с правами над таблицами test_db.  
![task2](/bd_devops/SQL/task2_3.png)  
---
## Задача 3

Используя SQL-синтаксис, наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL-синтаксис:
- вычислите количество записей для каждой таблицы.
Приведите в ответе:

    - запросы  
```    
INSERT INTO orders (наименование, цена) VALUES ('Шоколад', 10), ('Принтер', 3000), ('Книга', 500), ('Монитор', 7000), ('Гитара', 4data000);  
INSERT INTO clients (фамилия, "страна проживания") VALUES ('Иванов Иван Иванович', 'USA'), ('Петров Петр Петрович', 'Canada'), ('Иоганн Себастьян Бах', 'Japan'), ('Ронни Джеймс Дио', 'Russia'), ('Ritchie Blackmore', 'Russia');  
SELECT count(*) FROM clients;  
SELECT count(*) FROM orders;
```
    - результаты их выполнения.  
![task3](/bd_devops/SQL/task3_1.png)  
---
## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys, свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения этих операций.  
```    
UPDATE clients SET "заказ"=3 WHERE "фамилия"='Иванов Иван Иванович';
UPDATE clients SET "заказ"=4 WHERE "фамилия"='Петров Петр Петрович';
UPDATE clients SET "заказ"=5 WHERE "фамилия"='Иоганн Себастьян Бах';
```
Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод этого запроса.  
```    
SELECT "фамилия","заказ" FROM clients WHERE "заказ">0;
SELECT "фамилия",orders."наименование" FROM clients LEFT JOIN orders ON orders.id=clients."заказ" WHERE clients."заказ">0;
```
![task4](/bd_devops/SQL/task4_1.png)  
---
## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).
```    
EXPLAIN (format yaml) SELECT * FROM clients WHERE "заказ">0;
```

Приведите получившийся результат и объясните, что значат полученные значения.  

![task5](/bd_devops/SQL/task5_1.png)  

Здесь показано что таблица читалась последовательно, время чтения первой строки 0,00, время чтения всех строк 20,12, было выведено 270 строк из данных плаинровщика со средним размером 72 байта с фильтром на знаения заказа больше нуля. Эту информаию полезно знать для анализа и последующей оптимизацией таблицы  

---
## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. задачу 1).

Остановите контейнер с PostgreSQL, но не удаляйте volumes.

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 
```
pg_dump -U postgres -d test_db > /data/backup/postgres/test_db.dump  
#создаем базу test_db и накатываем на нее бэкап дамп
psql -U postgres -d test_db < /data/backup/postgres/test_db.dump  
```
![task6](/bd_devops/SQL/task6_1.png)  
![task6](/bd_devops/SQL/task6_2.png)  

---


