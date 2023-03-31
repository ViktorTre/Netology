Домашнее задание к занятию "HTTP/HTTPS"
**

"HTTP/HTTPS - Третьяков Виктор"

Задание 1.
Какие коды ответов HTTP лучше соответствуют описанным ситуациям?

Данная страница не найдена - 404
Страница была перенесена на новый сайт - 301
Ресурс удален - 410
Пользователь не авторизован для просмотра страницы - 401
Превышен лимит запросов от пользователя - 429
Приведите ответ в свободной форме.

Задание 2.
Установите Nginx.
sudo apt-get install nginx

Сгенерируйте сертификат для него указав localhost в качестве CN.
sudo openssl req -x509 -nodes -newkey rsa:4096 -keyout /etc/nginx/cert.key -out /etc/nginx/cert.pem -days 365

Отредактируйте модуль http в файле /etc/nginx/nginx.conf.
http {
    gzip on;
    server {
        listen 80 default_server;
        root   /var/www/public;
        listen  443 ssl http2 default_server;
        server_name  localhost;
        ssl_certificate  /etc/nginx/cert.pem;
        ssl_certificate_key /etc/nginx/cert.key;
        ssl_protocols   TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers   HIGH:!aNULL:!MD5;
        location / {
            index index.html;
        }
    }
}
Создайте файл /var/www/public/index.html c содержимым.
<h1>It works</h1>
Зайдите на страницу в браузере, пропустив сообщение о неработающем сертификате.
Пришлите скриншот работающей страницы https://localhost.

![](/network/http/task_1.png "1 скрин")

Задание 3.
Измените конфигурацию сервера добавив переадресацию c Вашего сервера на сайт netology.ru.

location / {
  return 301 https://netology.ru;
}
Используя curl сделайте запрос к своему серверу и в качестве ответа пришлите скриншот с 301 ответом.

![](/network/http/task_2.png "1 скрин")

Дополнительные задания (со звездочкой*)
Эти задания дополнительные (не обязательные к выполнению) и никак не повлияют на получение вами зачета по этому домашнему заданию. Вы можете их выполнить, если хотите глубже и/или шире разобраться в материале.

Задание 4.
Используя документацию https://httpd.apache.org/docs/current/ установите apache2 веб-сервер.

Сделайте задание 2, добившись аналогичной работы сервера.

Пришлите получившуюся конфигурацию в качестве ответа.