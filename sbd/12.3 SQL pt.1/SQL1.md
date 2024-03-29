# Домашнее задание к занятию «SQL. Часть 1» - Третьяков Виктор

Задание можно выполнить как в любом IDE, так и в командной строке.

# Задание 1
Получите уникальные названия районов из таблицы с адресами, которые начинаются на “K” и заканчиваются на “a” и не содержат пробелов.

``` 
SELECT DISTINCT DISTRICT FROM address WHERE DISTRICT LIKE 'K%a' and DISTRICT NOT LIKE '% %';
``` 
---
# Задание 2
Получите из таблицы платежей за прокат фильмов информацию по платежам, которые выполнялись в промежуток с 15 июня 2005 года по 18 июня 2005 года включительно и стоимость которых превышает 10.00.

``` 
SELECT customer_id, amount, rental_id, CAST(payment_date as DATE)  FROM payment WHERE amount > 10.00 and (CAST(payment_date as DATE) BETWEEN '2005-06-15' and '2005-06-18');
``` 
---
# Задание 3
Получите последние пять аренд фильмов.

``` 
SELECT * FROM rental ORDER BY rental_date DESC LIMIT 5;
``` 
---
# Задание 4
Одним запросом получите активных покупателей, имена которых Kelly или Willie.

Сформируйте вывод в результат таким образом:

все буквы в фамилии и имени из верхнего регистра переведите в нижний регистр,
замените буквы 'll' в именах на 'pp'.

``` 
SELECT REPLACE(LOWER(first_name), 'll', 'pp') as CHANGED_NAME, LOWER(last_name) as LAST_NAME FROM customer WHERE first_name LIKE 'kelly'
 or first_name LIKE 'willie';
``` 
---
Дополнительные задания (со звёздочкой*)
Эти задания дополнительные, то есть не обязательные к выполнению, и никак не повлияют на получение вами зачёта по этому домашнему заданию. Вы можете их выполнить, если хотите глубже шире разобраться в материале.

---
# Задание 5*
Выведите Email каждого покупателя, разделив значение Email на две отдельных колонки: в первой колонке должно быть значение, указанное до @, во второй — значение, указанное после @.

``` 
SELECT LEFT(email, (POSITION('@' IN email)-1)), RIGHT(email, (CHAR_LENGTH(email)-POSITION('@' IN email))) FROM customer;
``` 
---
# Задание 6*
Доработайте запрос из предыдущего задания, скорректируйте значения в новых колонках: первая буква должна быть заглавной, остальные — строчными.