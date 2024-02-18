# создайте пользователя test-admin-user и БД test_db;
CREATE USER "test-admin-user";
CREATE DATABASE test_db;
# в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже);
\c test_db; # приконнектиться к test_db;
CREATE TABLE orders (
    id  SERIAL PRIMARY KEY,
    наименование TEXT,
    цена INT
);
CREATE TABLE clients (
	id SERIAL PRIMARY KEY, 
	фамилия TEXT,
	"страна проживания" TEXT, 
	заказ INT REFERENCES orders (id)
);

# предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db;

GRANT ALL ON TABLE clients, orders TO "test-admin-user";
# создайте пользователя test-simple-user;
предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE этих таблиц БД test_db.
CREATE USER "test-simple-user";
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE clients, orders TO "test-simple-user";
SELECT table_name,grantee,privilege_type FROM information_schema.table_privileges WHERE table_schema NOT IN ('information_schema','pg_catalog');
# вставить данные:
INSERT INTO orders (наименование, цена) VALUES ('Шоколад', 10), ('Принтер', 3000), ('Книга', 500), ('Монитор', 7000), ('Гитара', 4data000);
INSERT INTO clients (фамилия, "страна проживания") VALUES ('Иванов Иван Иванович', 'USA'), ('Петров Петр Петрович', 'Canada'), ('Иоганн Себастьян Бах', 'Japan'), ('Ронни Джеймс Дио', 'Russia'), ('Ritchie Blackmore', 'Russia');
SELECT count(*) FROM clients;
SELECT count(*) FROM orders;
UPDATE clients SET "заказ"=3 WHERE "фамилия"='Иванов Иван Иванович';
UPDATE clients SET "заказ"=4 WHERE "фамилия"='Петров Петр Петрович';
UPDATE clients SET "заказ"=5 WHERE "фамилия"='Иоганн Себастьян Бах';
SELECT "фамилия","заказ" FROM clients WHERE "заказ">0;
SELECT "фамилия",orders."наименование" FROM clients LEFT JOIN orders ON orders.id=clients."заказ" WHERE clients."заказ">0;
EXPLAIN (format yaml) SELECT * FROM clients WHERE "заказ">0;
# Здесь показано что таблица читалась последовательно, время чтения первой строки 0,00, время чтения всех строк 20,12, было выведено 270 строк из данных плаинровщика со средним размером 72 байта с фильтром на знаения заказа больше нуля. Эту информаию полезно знать для анализа и последующей оптимизацией таблицы
pg_dump -U postgres -d test_db > /data/backup/postgres/test_db.dump
#создаем базу test_db и накатываем на нее бэкап дамп
psql -U postgres -d test_db < /data/backup/postgres/test_db.dump